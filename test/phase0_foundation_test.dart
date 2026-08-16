import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mr_gym/core/config/app_config.dart';
import 'package:mr_gym/core/crypto/crypto_service.dart';
import 'package:mr_gym/core/errors/app_exception.dart';
import 'package:mr_gym/core/logging/app_logger.dart';
import 'package:mr_gym/core/security/secure_store.dart';
import 'package:mr_gym/data/db/app_database.dart';
import 'package:mr_gym/data/db/database_session.dart';
import 'package:mr_gym/data/repositories/local_location_repository.dart';
import 'package:mr_gym/data/repositories/local_member_repository.dart';
import 'package:mr_gym/data/repositories/local_membership_repository.dart';
import 'package:mr_gym/data/repositories/local_organization_repository.dart';
import 'package:mr_gym/domain/attendance/attendance_source.dart';
import 'package:mr_gym/domain/services/backup_service.dart';
import 'package:mr_gym/domain/services/security_service.dart';
import 'package:mr_gym/updates/app_update_service.dart';
import 'package:path/path.dart' as p;

void main() {
  group('CryptoService', () {
    final crypto = CryptoService();

    test('hashes and verifies PIN', () {
      final salt = crypto.randomBytes(16);
      final hash = crypto.hashPin(pin: '123456', salt: salt);
      expect(
        crypto.verifyPin(
          pin: '123456',
          saltBase64: crypto.toBase64(salt),
          expectedHashBase64: hash,
        ),
        isTrue,
      );
      expect(
        crypto.verifyPin(
          pin: '000000',
          saltBase64: crypto.toBase64(salt),
          expectedHashBase64: hash,
        ),
        isFalse,
      );
    });

    test('encrypts backup without plaintext payload in package', () {
      final plain = crypto.randomBytes(64);
      final package = crypto.encryptBackup(
        plaintext: plain,
        password: 'password123',
      );
      expect(package.containsKey('ciphertext'), isTrue);
      expect(package.containsKey('password'), isFalse);
      expect(jsonEncode(package), isNot(contains(String.fromCharCodes(plain))));
      final decrypted = crypto.decryptBackup(
        package: Map<String, dynamic>.from(package),
        password: 'password123',
      );
      expect(decrypted, plain);
    });

    test('rejects wrong backup password', () {
      final package = crypto.encryptBackup(
        plaintext: crypto.randomBytes(32),
        password: 'password123',
      );
      expect(
        () => crypto.decryptBackup(
          package: Map<String, dynamic>.from(package),
          password: 'wrong-password',
        ),
        throwsA(isA<Object>()),
      );
    });
  });

  group('SecurityService', () {
    late AppDatabase db;
    late MemorySecureStore store;
    late SecurityService security;

    setUp(() {
      db = AppDatabase.memory();
      store = MemorySecureStore();
      security = SecurityService(
        db: db,
        crypto: CryptoService(),
        logger: AppLogger(sink: (_, __, {error, stackTrace}) {}),
        secureStore: store,
      );
    });

    tearDown(() async {
      await db.close();
    });

    test('setup, unlock, lockout, and change PIN', () async {
      expect(await security.isPinConfigured(), isFalse);
      await security.setupPin(pin: '123456', confirmPin: '123456');
      expect(await security.isPinConfigured(), isTrue);
      expect(security.isUnlocked, isTrue);
      expect(await store.read(SecurityService.pinHashKey), isNotNull);
      expect(await store.read(SecurityService.pinHashKey), isNot('123456'));

      security.lock();
      expect(security.isUnlocked, isFalse);

      final bad = await security.unlock('000000');
      expect(bad.success, isFalse);
      expect(bad.errorCode, AppErrorCodes.authInvalidPin);

      final ok = await security.unlock('123456');
      expect(ok.success, isTrue);

      await security.changePin(
        currentPin: '123456',
        newPin: '654321',
        confirmNewPin: '654321',
      );
      security.lock();
      expect((await security.unlock('654321')).success, isTrue);
    });

    test('rejects mismatched PIN setup', () async {
      expect(
        () => security.setupPin(pin: '123456', confirmPin: '654321'),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.authPinMismatch,
          ),
        ),
      );
    });

    test('applies lockout after repeated failures', () async {
      await security.setupPin(pin: '123456', confirmPin: '123456');
      security.lock();
      UnlockResult? last;
      for (var i = 0; i < 5; i++) {
        last = await security.unlock('000000');
      }
      expect(last?.errorCode, AppErrorCodes.authLockoutActive);
      expect(last?.lockoutRemainingSeconds, greaterThan(0));
    });

    test('factory reset requires RESET and wipes PIN', () async {
      await security.setupPin(pin: '123456', confirmPin: '123456');
      expect(
        () => security.factoryReset(confirmation: 'nope'),
        throwsA(isA<AppException>()),
      );
      await security.factoryReset(confirmation: 'RESET');
      expect(await security.isPinConfigured(), isFalse);
      expect(await store.read(SecurityService.pinHashKey), isNull);
    });
  });

  group('BackupService', () {
    late Directory tempDir;
    late File dbFile;
    late AppDatabase db;
    late DatabaseSession session;
    late BackupService backup;
    late MemorySecureStore store;
    late SecurityService security;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('mr-gym-p0-');
      dbFile = File(p.join(tempDir.path, 'mr_gym.sqlite'));
      db = AppDatabase(NativeDatabase(dbFile));
      session = DatabaseSession(db, () async {
        return AppDatabase(NativeDatabase(dbFile));
      });
      backup = BackupService(
        session: session,
        crypto: CryptoService(),
        logger: AppLogger(sink: (_, __, {error, stackTrace}) {}),
        config: const AppConfig(
          githubUpdateOwner: '',
          githubUpdateRepo: 'Mr-Gym',
          applicationId: 'com.mrgym.app',
          versionName: '0.0.1',
          versionCode: 1,
        ),
        databaseFilePath: () async => dbFile.path,
        documentsDirectory: () async => tempDir,
      );
      store = MemorySecureStore();
      security = SecurityService(
        db: session.db,
        crypto: CryptoService(),
        logger: AppLogger(sink: (_, __, {error, stackTrace}) {}),
        secureStore: store,
      );
    });

    tearDown(() async {
      try {
        await session.close();
      } catch (_) {}
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('creates encrypted backup without plaintext SQLite payload', () async {
      await security.setupPin(pin: '123456', confirmPin: '123456');
      final orgs = LocalOrganizationRepository(db: session.db);
      await orgs.create(
        name: 'Alpha Gym',
        countryCode: 'US',
        defaultCurrency: 'USD',
      );

      final file = await backup.createEncryptedBackup(
        password: 'backup-pass',
        confirmPassword: 'backup-pass',
      );
      expect(file.path.endsWith('.mrgym-backup'), isTrue);
      final raw = await file.readAsString();
      expect(raw.contains('SQLite format 3'), isFalse);
      expect(raw.contains('Alpha Gym'), isFalse);
      expect(raw.contains('backup-pass'), isFalse);

      final status = await backup.status();
      expect(status.lastBackupAt, isNotNull);
      expect(status.lastErrorCode, isNull);
    });

    test('rejects mismatched backup passwords', () async {
      expect(
        () => backup.createEncryptedBackup(
          password: 'backup-pass',
          confirmPassword: 'other-pass',
        ),
        throwsA(isA<AppException>()),
      );
    });

    test('restore is atomic: wrong password leaves live data', () async {
      final orgs = LocalOrganizationRepository(db: session.db);
      await orgs.create(
        name: 'Keep Me',
        countryCode: 'GB',
        defaultCurrency: 'GBP',
      );
      final file = await backup.createEncryptedBackup(
        password: 'backup-pass',
        confirmPassword: 'backup-pass',
      );

      await orgs.create(
        name: 'Newer Gym',
        countryCode: 'US',
        defaultCurrency: 'USD',
      );

      expect(
        () => backup.restoreEncryptedBackup(
          backupFile: file,
          password: 'wrong-password',
        ),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.backupPassphraseInvalid,
          ),
        ),
      );

      final remaining = await orgs.list();
      expect(
        remaining.map((o) => o.name),
        containsAll(['Keep Me', 'Newer Gym']),
      );
    });

    test('restore replaces data after valid password', () async {
      final orgs = LocalOrganizationRepository(db: session.db);
      await orgs.create(
        name: 'Original Gym',
        countryCode: 'AE',
        defaultCurrency: 'AED',
      );
      final file = await backup.createEncryptedBackup(
        password: 'backup-pass',
        confirmPassword: 'backup-pass',
      );

      await orgs.create(
        name: 'Should Disappear',
        countryCode: 'US',
        defaultCurrency: 'USD',
      );

      await backup.restoreEncryptedBackup(
        backupFile: file,
        password: 'backup-pass',
      );

      final restoredOrgs = LocalOrganizationRepository(db: session.db);
      final names = (await restoredOrgs.list()).map((o) => o.name).toList();
      expect(names, contains('Original Gym'));
      expect(names, isNot(contains('Should Disappear')));
    });

    test('corrupt backup does not change the live database', () async {
      final orgs = LocalOrganizationRepository(db: session.db);
      await orgs.create(
        name: 'Live Gym',
        countryCode: 'PK',
        defaultCurrency: 'PKR',
      );
      final junk = File(p.join(tempDir.path, 'broken.mr-gym-backup'));
      await junk.writeAsString('not-a-backup');

      expect(
        () => backup.restoreEncryptedBackup(
          backupFile: junk,
          password: 'backup-pass',
        ),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.backupCorrupt,
          ),
        ),
      );
      expect((await orgs.list()).single.name, 'Live Gym');
    });

    test('incompatible backup version is rejected', () async {
      final package = CryptoService().encryptBackup(
        plaintext: Uint8List.fromList(utf8.encode('not-sqlite')),
        password: 'backup-pass',
      );
      package['formatVersion'] = '999';
      final file = File(p.join(tempDir.path, 'old.mr-gym-backup'));
      await file.writeAsString(jsonEncode(package));

      expect(
        () => backup.restoreEncryptedBackup(
          backupFile: file,
          password: 'backup-pass',
        ),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.backupIncompatibleVersion,
          ),
        ),
      );
    });

    test('reminder marks backup stale when never created', () async {
      final status = await backup.status();
      expect(status.isStale, isTrue);
      expect(status.lastBackupAt, isNull);
    });
  });

  group('Repositories tenant isolation', () {
    late AppDatabase db;

    setUp(() => db = AppDatabase.memory());
    tearDown(() => db.close());

    test('members cannot be read across organizations', () async {
      final orgs = LocalOrganizationRepository(db: db);
      final locations = LocalLocationRepository(db: db);
      final members = LocalMemberRepository(db: db);
      final memberships = LocalMembershipRepository(db: db);

      final orgA = await orgs.create(
        name: 'Gym A',
        countryCode: 'US',
        defaultCurrency: 'USD',
      );
      final orgB = await orgs.create(
        name: 'Gym B',
        countryCode: 'GB',
        defaultCurrency: 'GBP',
      );
      final locA = await locations.create(
        organizationId: orgA.id,
        name: 'Main',
        timezone: 'America/New_York',
        countryCode: 'US',
        currencyCode: 'USD',
      );
      final locB = await locations.create(
        organizationId: orgB.id,
        name: 'Central',
        timezone: 'Europe/London',
        countryCode: 'GB',
        currencyCode: 'GBP',
      );

      final memberA = await members.create(
        organizationId: orgA.id,
        locationId: locA.id,
        firstName: 'Ada',
        lastName: 'Lovelace',
      );
      await memberships.create(
        organizationId: orgA.id,
        locationId: locA.id,
        memberId: memberA.id,
        startAt: DateTime.utc(2026, 1, 1),
        endAt: DateTime.utc(2026, 12, 31),
        status: 'active',
        currencyCode: 'USD',
      );

      expect(
        await members.get(organizationId: orgB.id, id: memberA.id),
        isNull,
      );
      expect(await members.list(organizationId: orgB.id), isEmpty);
      expect(await locations.list(orgB.id), hasLength(1));
      expect(await locations.get(organizationId: orgB.id, id: locA.id), isNull);
      expect(await memberships.list(organizationId: orgB.id), isEmpty);
      expect(locB.timezone, 'Europe/London');
    });
  });

  group('MockAttendanceSource', () {
    test('unavailable health is not treated as reliable zero data', () async {
      final source = MockAttendanceSource();
      final health = await source.health();
      expect(health.status, AttendanceSourceHealthStatus.unavailable);
      expect(health.isDataReliable, isFalse);
    });

    test('connected mock returns simulated events', () async {
      final source = MockAttendanceSource();
      await source.connect();
      final events = await source.syncSince(null);
      expect(events, isNotEmpty);
      final health = await source.health();
      expect(health.isDataReliable, isTrue);
    });
  });

  group('AppUpdateService', () {
    test('returns newer release only', () async {
      final provider = _FakeUpdateProvider(
        const AppReleaseInfo(
          versionName: '0.0.2',
          versionCode: 2,
          apkUrl:
              'https://github.com/test-owner/Mr-Gym/releases/download/v0.0.2/app.apk',
          sha256:
              'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
          releaseNotes: 'test',
        ),
      );
      final service = AppUpdateService(
        provider: provider,
        currentVersionCode: 1,
        applicationId: 'com.mrgym.app',
        githubOwner: 'test-owner',
        githubRepo: 'Mr-Gym',
      );
      final update = await service.checkForUpdate();
      expect(update?.versionCode, 2);

      final service2 = AppUpdateService(
        provider: provider,
        currentVersionCode: 2,
        applicationId: 'com.mrgym.app',
        githubOwner: 'test-owner',
        githubRepo: 'Mr-Gym',
      );
      expect(await service2.checkForUpdate(), isNull);
    });
  });

  group('AppLogger', () {
    test('redacts sensitive terms', () {
      final lines = <String>[];
      final logger = AppLogger(
        sink: (level, message, {error, stackTrace}) {
          lines.add(message);
        },
      );
      logger.info('user password=secret123 pin=999999');
      expect(lines.single, contains('[REDACTED]'));
      expect(lines.single, isNot(contains('secret123')));
      expect(lines.single, isNot(contains('999999')));
    });
  });

  group('DisabledSyncPort', () {
    test('remains disabled', () async {
      final port = DisabledSyncPort();
      expect(await port.isEnabled, isFalse);
    });
  });
}

class _FakeUpdateProvider implements AppUpdateProvider {
  _FakeUpdateProvider(this.info);
  final AppReleaseInfo info;
  @override
  Future<AppReleaseInfo?> fetchLatest() async => info;
}
