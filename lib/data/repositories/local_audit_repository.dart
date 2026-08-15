import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repositories/audit_repository.dart';
import '../db/app_database.dart';

class LocalAuditRepository implements AuditRepository {
  LocalAuditRepository({required AppDatabase db, Uuid? uuid})
    : _db = db,
      _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  @override
  Future<void> record({
    required String action,
    String? organizationId,
    String? userId,
    String? entityType,
    String? entityId,
    String? metadataJson,
  }) async {
    await _db
        .into(_db.auditLogs)
        .insert(
          AuditLogsCompanion.insert(
            id: _uuid.v4(),
            organizationId: Value(organizationId),
            userId: Value(userId),
            action: action,
            entityType: Value(entityType),
            entityId: Value(entityId),
            occurredAt: DateTime.now().toUtc(),
            metadataJson: Value(metadataJson),
          ),
        );
  }

  @override
  Future<List<AuditLog>> list({String? organizationId, int limit = 100}) {
    final query = _db.select(_db.auditLogs)
      ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)])
      ..limit(limit);
    if (organizationId != null) {
      query.where((t) => t.organizationId.equals(organizationId));
    }
    return query.get();
  }
}
