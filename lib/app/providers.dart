import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../core/config/app_config.dart';
import '../core/crypto/crypto_service.dart';
import '../core/l10n/app_strings.dart';
import '../core/logging/app_logger.dart';
import '../core/security/secure_store.dart';
import '../data/db/app_database.dart';
import '../data/db/database_session.dart';
import '../data/repositories/local_audit_repository.dart';
import '../data/repositories/local_location_repository.dart';
import '../data/repositories/local_member_repository.dart';
import '../data/repositories/local_membership_repository.dart';
import '../data/repositories/local_organization_repository.dart';
import '../data/security/keystore_secure_store.dart';
import '../domain/attendance/attendance_source.dart';
import '../domain/repositories/audit_repository.dart';
import '../domain/repositories/location_repository.dart';
import '../domain/repositories/member_repository.dart';
import '../domain/repositories/membership_repository.dart';
import '../domain/repositories/organization_repository.dart';
import '../domain/services/backup_service.dart';
import '../domain/services/security_service.dart';
import '../updates/app_update_service.dart';

final appConfigProvider = Provider<AppConfig>(
  (ref) => AppConfig.fromEnvironment(),
);

final appStringsProvider = Provider<AppStrings>((ref) => const AppStrings());

final appLoggerProvider = Provider<AppLogger>((ref) => AppLogger());

final cryptoServiceProvider = Provider<CryptoService>((ref) => CryptoService());

final secureStoreProvider = Provider<SecureStore>(
  (ref) => KeystoreSecureStore(),
);

final databaseSessionProvider = ChangeNotifierProvider<DatabaseSession>((ref) {
  throw UnimplementedError('DatabaseSession must be overridden in main()');
});

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return ref.watch(databaseSessionProvider).db;
});

final databasePathProvider = Provider<Future<String> Function()>((ref) {
  return () async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, 'gympulse.sqlite');
  };
});

final organizationRepositoryProvider = Provider<OrganizationRepository>((ref) {
  return LocalOrganizationRepository(db: ref.watch(appDatabaseProvider));
});

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  return LocalLocationRepository(db: ref.watch(appDatabaseProvider));
});

final memberRepositoryProvider = Provider<MemberRepository>((ref) {
  return LocalMemberRepository(db: ref.watch(appDatabaseProvider));
});

final membershipRepositoryProvider = Provider<MembershipRepository>((ref) {
  return LocalMembershipRepository(db: ref.watch(appDatabaseProvider));
});

final auditRepositoryProvider = Provider<AuditRepository>((ref) {
  return LocalAuditRepository(db: ref.watch(appDatabaseProvider));
});

final securityServiceProvider = Provider<SecurityService>((ref) {
  return SecurityService(
    db: ref.watch(appDatabaseProvider),
    crypto: ref.watch(cryptoServiceProvider),
    logger: ref.watch(appLoggerProvider),
    secureStore: ref.watch(secureStoreProvider),
  );
});

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(
    session: ref.watch(databaseSessionProvider),
    crypto: ref.watch(cryptoServiceProvider),
    logger: ref.watch(appLoggerProvider),
    config: ref.watch(appConfigProvider),
    databaseFilePath: ref.watch(databasePathProvider),
  );
});

final syncPortProvider = Provider<SyncPort>((ref) => DisabledSyncPort());

final mockAttendanceSourceProvider = Provider<MockAttendanceSource>((ref) {
  return MockAttendanceSource();
});

final appUpdateServiceProvider = Provider<AppUpdateService>((ref) {
  final config = ref.watch(appConfigProvider);
  final provider = GitHubReleaseUpdateProvider(
    owner: config.githubUpdateOwner,
    repo: config.githubUpdateRepo,
    httpGet: (uri) async {
      final response = await http.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw HttpException('Update check failed (${response.statusCode})');
      }
      return response.body;
    },
  );
  return AppUpdateService(
    provider: provider,
    currentVersionCode: config.versionCode,
    applicationId: config.applicationId,
  );
});

final sessionUnlockedProvider = StateProvider<bool>((ref) => false);

final pinConfiguredProvider = StateProvider<bool?>((ref) => null);
