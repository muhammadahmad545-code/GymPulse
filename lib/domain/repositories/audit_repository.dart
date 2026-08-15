import '../../data/db/app_database.dart';

abstract class AuditRepository {
  Future<void> record({
    required String action,
    String? organizationId,
    String? userId,
    String? entityType,
    String? entityId,
    String? metadataJson,
  });

  Future<List<AuditLog>> list({String? organizationId, int limit = 100});
}
