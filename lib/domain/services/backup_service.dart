import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../core/config/app_config.dart';
import '../../core/crypto/crypto_service.dart';
import '../../core/errors/app_exception.dart';
import '../../core/logging/app_logger.dart';
import '../../data/db/app_database.dart';
import '../../data/db/database_session.dart';

class BackupStatus {
  const BackupStatus({
    required this.lastBackupAt,
    required this.lastRestoreAt,
    required this.intervalDays,
    required this.reminderEnabled,
    required this.isStale,
    this.lastBackupPath,
    this.lastErrorCode,
    this.lastErrorMessage,
  });

  final DateTime? lastBackupAt;
  final DateTime? lastRestoreAt;
  final int intervalDays;
  final bool reminderEnabled;
  final bool isStale;
  final String? lastBackupPath;
  final String? lastErrorCode;
  final String? lastErrorMessage;
}

/// Encrypted local backup foundation (Feature Spec §17).
class BackupService {
  BackupService({
    required DatabaseSession session,
    required CryptoService crypto,
    required AppLogger logger,
    required AppConfig config,
    required Future<String> Function() databaseFilePath,
    Future<Directory> Function()? documentsDirectory,
    Uuid? uuid,
  }) : _session = session,
       _crypto = crypto,
       _logger = logger,
       _config = config,
       _databaseFilePath = databaseFilePath,
       _documentsDirectory =
           documentsDirectory ?? getApplicationDocumentsDirectory,
       _uuid = uuid ?? const Uuid();

  static const forgottenPasswordWarning =
      'If you forget this backup password, this backup cannot be recovered. GymPulse cannot reset it.';
  static const lastBackupPathKey = 'last_backup_path';

  final DatabaseSession _session;
  final CryptoService _crypto;
  final AppLogger _logger;
  final AppConfig _config;
  final Future<String> Function() _databaseFilePath;
  final Future<Directory> Function() _documentsDirectory;
  final Uuid _uuid;

  AppDatabase get _db => _session.db;

  Future<BackupStatus> status({String organizationId = 'local'}) async {
    final lastBackup =
        await (_db.select(_db.backupRuns)
              ..where(
                (t) =>
                    t.direction.equals('export') & t.status.equals('success'),
              )
              ..orderBy([(t) => OrderingTerm.desc(t.completedAt)])
              ..limit(1))
            .getSingleOrNull();
    final lastRestore =
        await (_db.select(_db.backupRuns)
              ..where(
                (t) =>
                    t.direction.equals('restore') & t.status.equals('success'),
              )
              ..orderBy([(t) => OrderingTerm.desc(t.completedAt)])
              ..limit(1))
            .getSingleOrNull();
    final lastFailed =
        await (_db.select(_db.backupRuns)
              ..where((t) => t.status.isNotValue('success'))
              ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
              ..limit(1))
            .getSingleOrNull();

    final reminder = await (_db.select(
      _db.backupReminderSettings,
    )..where((t) => t.organizationId.equals(organizationId))).getSingleOrNull();
    final interval = reminder?.intervalDays ?? 7;
    final enabled = reminder?.enabled ?? true;
    final lastAt = lastBackup?.completedAt;
    final isStale =
        enabled &&
        (lastAt == null ||
            DateTime.now().toUtc().difference(lastAt).inDays >= interval);

    final pathRow = await (_db.select(
      _db.appMetaEntries,
    )..where((t) => t.key.equals(lastBackupPathKey))).getSingleOrNull();

    return BackupStatus(
      lastBackupAt: lastAt,
      lastRestoreAt: lastRestore?.completedAt,
      intervalDays: interval,
      reminderEnabled: enabled,
      isStale: isStale,
      lastBackupPath: pathRow?.value,
      lastErrorCode: lastFailed?.status == 'success'
          ? null
          : lastFailed?.errorCode,
      lastErrorMessage: lastFailed?.status == 'success'
          ? null
          : lastFailed?.errorSummary,
    );
  }

  Future<void> updateReminderSettings({
    required int intervalDays,
    required bool enabled,
    String organizationId = 'local',
  }) async {
    if (intervalDays < 1) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Reminder interval must be at least 1 day.',
      );
    }
    await _db
        .into(_db.backupReminderSettings)
        .insertOnConflictUpdate(
          BackupReminderSettingsCompanion.insert(
            organizationId: organizationId,
            intervalDays: Value(intervalDays),
            enabled: Value(enabled),
            updatedAt: DateTime.now().toUtc(),
          ),
        );
  }

  /// Creates an encrypted backup file. Passwords are never stored.
  Future<File> createEncryptedBackup({
    required String password,
    required String confirmPassword,
  }) async {
    if (password.length < 8) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Backup password must be at least 8 characters.',
      );
    }
    if (password != confirmPassword) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Backup passwords do not match.',
      );
    }

    final runId = _uuid.v4();
    final now = DateTime.now().toUtc();
    await _db
        .into(_db.backupRuns)
        .insert(
          BackupRunsCompanion.insert(
            id: runId,
            createdAt: now,
            direction: 'export',
            status: 'in_progress',
            appVersion: Value(_config.versionName),
            formatVersion: Value(CryptoService.backupFormatVersion),
          ),
        );

    File? outFile;
    File? snapshot;
    try {
      final docs = await _documentsDirectory();
      final backupDir = Directory(p.join(docs.path, 'backups'));
      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true);
      }

      snapshot = File(p.join(backupDir.path, '.$runId.snapshot.sqlite'));
      if (await snapshot.exists()) {
        await snapshot.delete();
      }
      await _vacuumInto(snapshot);

      final plaintext = await snapshot.readAsBytes();
      final package = _crypto.encryptBackup(
        plaintext: Uint8List.fromList(plaintext),
        password: password,
      );
      package['appVersion'] = _config.versionName;
      package['applicationId'] = _config.applicationId;
      package['sha256'] = _crypto.sha256Hex(Uint8List.fromList(plaintext));

      final fileName =
          'gympulse-backup-${now.toIso8601String().replaceAll(':', '')}.gympulse-backup';
      outFile = File(p.join(backupDir.path, fileName));

      final encoded = utf8.encode(jsonEncode(package));
      await outFile.writeAsBytes(encoded, flush: true);
      await _deleteQuietly(snapshot);

      final checksum = _crypto.sha256Hex(Uint8List.fromList(encoded));
      await (_db.update(
        _db.backupRuns,
      )..where((t) => t.id.equals(runId))).write(
        BackupRunsCompanion(
          completedAt: Value(DateTime.now().toUtc()),
          status: const Value('success'),
          fileName: Value(fileName),
          checksum: Value(checksum),
        ),
      );
      await _db
          .into(_db.appMetaEntries)
          .insertOnConflictUpdate(
            AppMetaEntriesCompanion.insert(
              key: lastBackupPathKey,
              value: outFile.path,
              updatedAt: DateTime.now().toUtc(),
            ),
          );
      _logger.info('Encrypted backup created');
      return outFile;
    } on AppException catch (e) {
      await _deleteQuietly(snapshot);
      await _deleteQuietly(outFile);
      await _failRun(runId, e.code, e.message);
      rethrow;
    } catch (e, st) {
      await _deleteQuietly(snapshot);
      await _deleteQuietly(outFile);
      _logger.error('Backup failed', error: e, stackTrace: st);
      final code = _isStorageError(e)
          ? AppErrorCodes.backupInsufficientStorage
          : AppErrorCodes.backupInterrupted;
      final message = code == AppErrorCodes.backupInsufficientStorage
          ? 'Not enough storage to create a backup.'
          : 'Backup was interrupted. No usable backup file was kept.';
      await _failRun(runId, code, message);
      throw AppException(
        code: code,
        message: message,
        cause: e,
        retryable: true,
      );
    }
  }

  /// Restores from an encrypted backup using temp file + atomic swap.
  /// A failed or interrupted restore leaves the live database unchanged.
  Future<void> restoreEncryptedBackup({
    required File backupFile,
    required String password,
  }) async {
    final runId = _uuid.v4();
    final now = DateTime.now().toUtc();
    await _db
        .into(_db.backupRuns)
        .insert(
          BackupRunsCompanion.insert(
            id: runId,
            createdAt: now,
            direction: 'restore',
            status: 'in_progress',
            appVersion: Value(_config.versionName),
            fileName: Value(p.basename(backupFile.path)),
          ),
        );

    File? tempDb;
    var swapped = false;
    try {
      if (!await backupFile.exists()) {
        throw AppException(
          code: AppErrorCodes.backupCorrupt,
          message: 'Backup file was not found or is unreadable.',
        );
      }

      final raw = await backupFile.readAsBytes();
      late final Map<String, dynamic> package;
      try {
        package = jsonDecode(utf8.decode(raw)) as Map<String, dynamic>;
      } catch (_) {
        throw AppException(
          code: AppErrorCodes.backupCorrupt,
          message: 'This backup file is corrupted or unreadable.',
        );
      }

      if (package['formatVersion']?.toString() !=
          CryptoService.backupFormatVersion) {
        throw AppException(
          code: AppErrorCodes.backupIncompatibleVersion,
          message:
              'This backup was created by an incompatible GymPulse version.',
        );
      }

      late final Uint8List plaintext;
      try {
        plaintext = _crypto.decryptBackup(package: package, password: password);
      } catch (_) {
        throw AppException(
          code: AppErrorCodes.backupPassphraseInvalid,
          message: 'Incorrect backup password. This backup cannot be opened.',
        );
      }

      final livePath = await _databaseFilePath();
      final liveFile = File(livePath);
      final safetyCopy = File('$livePath.bak');
      tempDb = File('$livePath.restore-temp');
      if (await tempDb.exists()) {
        await tempDb.delete();
      }
      await tempDb.writeAsBytes(plaintext, flush: true);
      await _verifySqliteFile(tempDb);

      await _session.db.close();
      if (await liveFile.exists()) {
        if (await safetyCopy.exists()) {
          await safetyCopy.delete();
        }
        await liveFile.rename(safetyCopy.path);
      }
      await tempDb.rename(livePath);
      swapped = true;

      try {
        final restored = await _session.reopen();
        await restored
            .into(restored.backupRuns)
            .insert(
              BackupRunsCompanion.insert(
                id: _uuid.v4(),
                createdAt: DateTime.now().toUtc(),
                completedAt: Value(DateTime.now().toUtc()),
                direction: 'restore',
                status: 'success',
                appVersion: Value(_config.versionName),
                fileName: Value(p.basename(backupFile.path)),
                formatVersion: Value(CryptoService.backupFormatVersion),
              ),
            );
        if (await safetyCopy.exists()) {
          await safetyCopy.delete();
        }
        _logger.info('Encrypted backup restored');
      } catch (e, st) {
        _logger.error('Restore reopen failed', error: e, stackTrace: st);
        await _rollbackSwap(liveFile: liveFile, safetyCopy: safetyCopy);
        await _session.reopen();
        throw AppException(
          code: AppErrorCodes.restoreFailed,
          message:
              'Restore was interrupted. Your existing data was not changed.',
          cause: e,
          retryable: true,
        );
      }
    } on AppException catch (e) {
      await _deleteQuietly(tempDb);
      if (!swapped) {
        await _failRun(runId, e.code, e.message);
      }
      rethrow;
    } catch (e, st) {
      await _deleteQuietly(tempDb);
      _logger.error('Restore failed', error: e, stackTrace: st);
      if (!swapped) {
        await _failRun(
          runId,
          AppErrorCodes.restoreInterrupted,
          'Restore was interrupted. Your existing data was not changed.',
        );
      }
      throw AppException(
        code: AppErrorCodes.restoreInterrupted,
        message: 'Restore was interrupted. Your existing data was not changed.',
        cause: e,
        retryable: true,
      );
    }
  }

  Future<void> _vacuumInto(File snapshot) async {
    final sqlPath = snapshot.path.replaceAll(r'\', '/').replaceAll("'", "''");
    try {
      await _db.customStatement("VACUUM INTO '$sqlPath'");
    } catch (e) {
      if (_isStorageError(e)) {
        throw AppException(
          code: AppErrorCodes.backupInsufficientStorage,
          message: 'Not enough storage to create a backup.',
          cause: e,
          retryable: true,
        );
      }
      rethrow;
    }
    if (!await snapshot.exists() || await snapshot.length() < 100) {
      throw AppException(
        code: AppErrorCodes.backupFailed,
        message: 'Backup snapshot was empty or incomplete.',
      );
    }
  }

  Future<void> _verifySqliteFile(File file) async {
    if (await file.length() < 100) {
      throw AppException(
        code: AppErrorCodes.restoreIntegrityFailed,
        message: 'Restored database failed integrity checks.',
      );
    }
    final header = await file.openRead(0, 16).fold<List<int>>(<int>[], (
      prev,
      chunk,
    ) {
      prev.addAll(chunk);
      return prev;
    });
    final headerText = String.fromCharCodes(header.take(15));
    if (!headerText.startsWith('SQLite format 3')) {
      throw AppException(
        code: AppErrorCodes.restoreIntegrityFailed,
        message: 'Restored database failed integrity checks.',
      );
    }

    final previousWarn = driftRuntimeOptions.dontWarnAboutMultipleDatabases;
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    final probe = AppDatabase(NativeDatabase(file));
    try {
      final rows = await probe.customSelect('PRAGMA integrity_check').get();
      final result = rows.isEmpty
          ? ''
          : rows.first.data.values.first.toString();
      if (result.toLowerCase() != 'ok') {
        throw AppException(
          code: AppErrorCodes.restoreIntegrityFailed,
          message: 'Restored database failed integrity checks.',
        );
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(
        code: AppErrorCodes.restoreIntegrityFailed,
        message: 'Restored database failed integrity checks.',
        cause: e,
      );
    } finally {
      await probe.close();
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = previousWarn;
    }
  }

  Future<void> _rollbackSwap({
    required File liveFile,
    required File safetyCopy,
  }) async {
    try {
      if (await liveFile.exists()) {
        await liveFile.delete();
      }
      if (await safetyCopy.exists()) {
        await safetyCopy.rename(liveFile.path);
      }
    } catch (e, st) {
      _logger.error('Restore rollback failed', error: e, stackTrace: st);
    }
  }

  Future<void> _failRun(String id, String code, String message) async {
    try {
      await (_db.update(_db.backupRuns)..where((t) => t.id.equals(id))).write(
        BackupRunsCompanion(
          completedAt: Value(DateTime.now().toUtc()),
          status: const Value('failed'),
          errorCode: Value(code),
          errorSummary: Value(message),
        ),
      );
    } catch (e, st) {
      _logger.error(
        'Could not record backup failure',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _deleteQuietly(File? file) async {
    if (file == null) return;
    try {
      if (await file.exists()) await file.delete();
    } catch (_) {}
  }

  bool _isStorageError(Object e) {
    final text = e.toString().toLowerCase();
    return text.contains('no space') ||
        text.contains('enospc') ||
        text.contains('not enough space') ||
        text.contains('disk full');
  }
}
