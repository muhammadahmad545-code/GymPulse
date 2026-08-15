import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/crypto/crypto_service.dart';
import '../../core/errors/app_exception.dart';
import '../../core/logging/app_logger.dart';
import '../../core/security/secure_store.dart';
import '../../data/db/app_database.dart';

class UnlockResult {
  const UnlockResult._({
    required this.success,
    this.lockoutRemainingSeconds,
    this.errorCode,
    this.message,
  });

  factory UnlockResult.ok() => const UnlockResult._(success: true);

  factory UnlockResult.failed({
    required String errorCode,
    required String message,
    int? lockoutRemainingSeconds,
  }) => UnlockResult._(
    success: false,
    errorCode: errorCode,
    message: message,
    lockoutRemainingSeconds: lockoutRemainingSeconds,
  );

  final bool success;
  final int? lockoutRemainingSeconds;
  final String? errorCode;
  final String? message;
}

class _PinMaterial {
  const _PinMaterial({
    required this.hash,
    required this.salt,
    required this.algo,
    required this.failedAttempts,
    this.lockoutUntilUtc,
  });

  final String hash;
  final String salt;
  final String algo;
  final int failedAttempts;
  final DateTime? lockoutUntilUtc;
}

/// Local PIN protection per Feature Spec §1.
///
/// PIN hash/salt live in Android Keystore-backed secure storage and are also
/// copied into `security_state` so encrypted backups can restore unlock state.
/// The raw PIN and backup passwords are never persisted.
class SecurityService {
  SecurityService({
    required AppDatabase db,
    required CryptoService crypto,
    required AppLogger logger,
    required SecureStore secureStore,
    Uuid? uuid,
  }) : _db = db,
       _crypto = crypto,
       _logger = logger,
       _secureStore = secureStore,
       _uuid = uuid ?? const Uuid();

  static const securityRowId = 'default';
  static const minPinLength = 6;
  static const pinHashKey = 'gp.pin.hash';
  static const pinSaltKey = 'gp.pin.salt';
  static const pinAlgoKey = 'gp.pin.algo';
  static const failedAttemptsKey = 'gp.pin.failed_attempts';
  static const lockoutUntilKey = 'gp.pin.lockout_until';

  final AppDatabase _db;
  final CryptoService _crypto;
  final AppLogger _logger;
  final SecureStore _secureStore;
  final Uuid _uuid;

  bool _unlocked = false;

  bool get isUnlocked => _unlocked;

  Future<bool> isPinConfigured() async {
    final material = await _readMaterial();
    return material != null && material.hash.isNotEmpty;
  }

  Future<SecurityState?> currentState() {
    return (_db.select(
      _db.securityStates,
    )..where((t) => t.id.equals(securityRowId))).getSingleOrNull();
  }

  Future<void> setupPin({
    required String pin,
    required String confirmPin,
  }) async {
    _validatePinPair(pin, confirmPin);
    if (await isPinConfigured()) {
      throw AppException(
        code: AppErrorCodes.authForbidden,
        message: 'PIN is already configured.',
      );
    }

    final salt = _crypto.randomBytes(16);
    final hash = _crypto.hashPin(pin: pin, salt: salt);
    final saltB64 = _crypto.toBase64(salt);
    final now = DateTime.now().toUtc();

    await _writeSecureMaterial(
      hash: hash,
      salt: saltB64,
      algo: CryptoService.pinAlgo,
      failedAttempts: 0,
      lockoutUntilUtc: null,
    );

    await _db
        .into(_db.securityStates)
        .insert(
          SecurityStatesCompanion.insert(
            id: securityRowId,
            pinHash: hash,
            pinSalt: saltB64,
            pinAlgo: CryptoService.pinAlgo,
            updatedAt: now,
          ),
        );

    await _audit('pin_setup');
    _unlocked = true;
    _logger.info('PIN setup completed');
  }

  Future<UnlockResult> unlock(String pin) async {
    final material = await _readMaterial();
    if (material == null) {
      return UnlockResult.failed(
        errorCode: AppErrorCodes.authUnlockFailed,
        message: 'PIN is not configured.',
      );
    }

    final now = DateTime.now().toUtc();
    if (material.lockoutUntilUtc != null &&
        material.lockoutUntilUtc!.isAfter(now)) {
      final seconds = material.lockoutUntilUtc!.difference(now).inSeconds;
      return UnlockResult.failed(
        errorCode: AppErrorCodes.authLockoutActive,
        message: 'Too many attempts. Try again later.',
        lockoutRemainingSeconds: seconds < 1 ? 1 : seconds,
      );
    }

    final ok = _crypto.verifyPin(
      pin: pin,
      saltBase64: material.salt,
      expectedHashBase64: material.hash,
    );

    if (ok) {
      await _persistAttempts(failedAttempts: 0, lockoutUntilUtc: null);
      _unlocked = true;
      await _audit('unlock_success');
      return UnlockResult.ok();
    }

    final attempts = material.failedAttempts + 1;
    final lockout = _lockoutForAttempts(attempts, now);
    await _persistAttempts(failedAttempts: attempts, lockoutUntilUtc: lockout);
    await _audit('unlock_failed', metadata: '{"attempts":$attempts}');

    if (lockout != null) {
      final seconds = lockout.difference(now).inSeconds;
      return UnlockResult.failed(
        errorCode: AppErrorCodes.authLockoutActive,
        message: 'Too many attempts. Try again later.',
        lockoutRemainingSeconds: seconds < 1 ? 1 : seconds,
      );
    }

    return UnlockResult.failed(
      errorCode: AppErrorCodes.authInvalidPin,
      message: 'Incorrect PIN. Try again.',
    );
  }

  void lock() {
    _unlocked = false;
    _logger.info('App locked');
  }

  Future<void> changePin({
    required String currentPin,
    required String newPin,
    required String confirmNewPin,
  }) async {
    if (!_unlocked) {
      throw AppException(
        code: AppErrorCodes.authForbidden,
        message: 'Unlock required to change PIN.',
      );
    }
    _validatePinPair(newPin, confirmNewPin);

    final result = await unlock(currentPin);
    if (!result.success) {
      throw AppException(
        code: result.errorCode ?? AppErrorCodes.authInvalidPin,
        message: result.message ?? 'Incorrect PIN. Try again.',
      );
    }

    final salt = _crypto.randomBytes(16);
    final hash = _crypto.hashPin(pin: newPin, salt: salt);
    final saltB64 = _crypto.toBase64(salt);
    await _writeSecureMaterial(
      hash: hash,
      salt: saltB64,
      algo: CryptoService.pinAlgo,
      failedAttempts: 0,
      lockoutUntilUtc: null,
    );
    await (_db.update(
      _db.securityStates,
    )..where((t) => t.id.equals(securityRowId))).write(
      SecurityStatesCompanion(
        pinHash: Value(hash),
        pinSalt: Value(saltB64),
        pinAlgo: const Value(CryptoService.pinAlgo),
        failedAttempts: const Value(0),
        lockoutUntilUtc: const Value(null),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
    await _audit('pin_changed');
  }

  /// After an encrypted restore, copy PIN material from the restored DB
  /// into Keystore-backed storage so unlock uses the restored PIN.
  Future<void> syncRestoredPinToSecureStore() async {
    final row = await currentState();
    if (row == null || row.pinHash.isEmpty) return;
    await _writeSecureMaterial(
      hash: row.pinHash,
      salt: row.pinSalt,
      algo: row.pinAlgo,
      failedAttempts: row.failedAttempts,
      lockoutUntilUtc: row.lockoutUntilUtc,
    );
    _unlocked = false;
    _logger.info('Restored PIN material synced to secure storage');
  }

  Future<void> factoryReset({required String confirmation}) async {
    if (confirmation.trim().toUpperCase() != 'RESET') {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Type RESET to confirm factory reset.',
      );
    }
    await _db.transaction(() async {
      for (final table in _db.allTables) {
        await _db.delete(table).go();
      }
    });
    await _secureStore.deleteAll();
    _unlocked = false;
    _logger.warn('Factory reset completed');
  }

  Future<_PinMaterial?> _readMaterial() async {
    final hash = await _secureStore.read(pinHashKey);
    final salt = await _secureStore.read(pinSaltKey);
    if (hash != null && hash.isNotEmpty && salt != null && salt.isNotEmpty) {
      final attemptsRaw = await _secureStore.read(failedAttemptsKey);
      final lockoutRaw = await _secureStore.read(lockoutUntilKey);
      return _PinMaterial(
        hash: hash,
        salt: salt,
        algo: await _secureStore.read(pinAlgoKey) ?? CryptoService.pinAlgo,
        failedAttempts: int.tryParse(attemptsRaw ?? '') ?? 0,
        lockoutUntilUtc: lockoutRaw == null || lockoutRaw.isEmpty
            ? null
            : DateTime.tryParse(lockoutRaw)?.toUtc(),
      );
    }

    final row = await currentState();
    if (row == null || row.pinHash.isEmpty) return null;
    await _writeSecureMaterial(
      hash: row.pinHash,
      salt: row.pinSalt,
      algo: row.pinAlgo,
      failedAttempts: row.failedAttempts,
      lockoutUntilUtc: row.lockoutUntilUtc,
    );
    return _PinMaterial(
      hash: row.pinHash,
      salt: row.pinSalt,
      algo: row.pinAlgo,
      failedAttempts: row.failedAttempts,
      lockoutUntilUtc: row.lockoutUntilUtc,
    );
  }

  Future<void> _writeSecureMaterial({
    required String hash,
    required String salt,
    required String algo,
    required int failedAttempts,
    required DateTime? lockoutUntilUtc,
  }) async {
    await _secureStore.write(pinHashKey, hash);
    await _secureStore.write(pinSaltKey, salt);
    await _secureStore.write(pinAlgoKey, algo);
    await _secureStore.write(failedAttemptsKey, '$failedAttempts');
    if (lockoutUntilUtc == null) {
      await _secureStore.delete(lockoutUntilKey);
    } else {
      await _secureStore.write(
        lockoutUntilKey,
        lockoutUntilUtc.toIso8601String(),
      );
    }
  }

  Future<void> _persistAttempts({
    required int failedAttempts,
    required DateTime? lockoutUntilUtc,
  }) async {
    final existing = await _readMaterial();
    if (existing != null) {
      await _writeSecureMaterial(
        hash: existing.hash,
        salt: existing.salt,
        algo: existing.algo,
        failedAttempts: failedAttempts,
        lockoutUntilUtc: lockoutUntilUtc,
      );
    }
    final now = DateTime.now().toUtc();
    await (_db.update(
      _db.securityStates,
    )..where((t) => t.id.equals(securityRowId))).write(
      SecurityStatesCompanion(
        failedAttempts: Value(failedAttempts),
        lockoutUntilUtc: Value(lockoutUntilUtc),
        updatedAt: Value(now),
      ),
    );
  }

  void _validatePinPair(String pin, String confirm) {
    if (pin.length < minPinLength || !RegExp(r'^\d+$').hasMatch(pin)) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'PIN must be at least 6 digits.',
      );
    }
    if (pin != confirm) {
      throw AppException(
        code: AppErrorCodes.authPinMismatch,
        message: 'PINs do not match.',
      );
    }
  }

  DateTime? _lockoutForAttempts(int attempts, DateTime now) {
    if (attempts >= 12) return now.add(const Duration(minutes: 30));
    if (attempts >= 8) return now.add(const Duration(minutes: 5));
    if (attempts >= 5) return now.add(const Duration(seconds: 30));
    return null;
  }

  Future<void> _audit(String action, {String? metadata}) async {
    await _db
        .into(_db.auditLogs)
        .insert(
          AuditLogsCompanion.insert(
            id: _uuid.v4(),
            action: action,
            occurredAt: DateTime.now().toUtc(),
            metadataJson: Value(metadata),
          ),
        );
  }
}
