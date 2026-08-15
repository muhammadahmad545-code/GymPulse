import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/app_exception.dart';
import '../db/app_database.dart';

class LocalFollowUpRepository {
  LocalFollowUpRepository({required AppDatabase db, Uuid? uuid})
    : _db = db,
      _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  Future<List<FollowUp>> listOpen({
    required String organizationId,
    required String locationId,
  }) {
    return (_db.select(_db.followUps)
          ..where(
            (t) =>
                t.organizationId.equals(organizationId) &
                t.locationId.equals(locationId) &
                t.status.isNotIn(['resolved', 'dismissed']),
          )
          ..orderBy([
            (t) => OrderingTerm.desc(t.priority),
            (t) => OrderingTerm.asc(t.dueAt),
          ]))
        .get();
  }

  Future<FollowUp?> openFor({
    required String organizationId,
    required String memberId,
    required String type,
  }) {
    return (_db.select(_db.followUps)..where(
          (t) =>
              t.organizationId.equals(organizationId) &
              t.memberId.equals(memberId) &
              t.type.equals(type) &
              t.status.isNotIn(['resolved', 'dismissed']),
        ))
        .getSingleOrNull();
  }

  Future<FollowUp> create({
    required String organizationId,
    required String locationId,
    required String memberId,
    required String type,
    required String reason,
    required int priority,
    DateTime? dueAt,
  }) async {
    final now = DateTime.now().toUtc();
    final id = _uuid.v4();
    await _db
        .into(_db.followUps)
        .insert(
          FollowUpsCompanion.insert(
            id: id,
            organizationId: organizationId,
            locationId: locationId,
            memberId: memberId,
            type: type,
            priority: Value(priority),
            reason: reason,
            status: 'new',
            dueAt: Value(dueAt),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (await (_db.select(
      _db.followUps,
    )..where((t) => t.id.equals(id))).getSingle());
  }

  Future<FollowUp> updateStatus({
    required String organizationId,
    required String id,
    required String status,
    String? resolutionNote,
    String? contactChannel,
  }) async {
    final existing =
        await (_db.select(_db.followUps)..where(
              (t) => t.id.equals(id) & t.organizationId.equals(organizationId),
            ))
            .getSingleOrNull();
    if (existing == null) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Follow-up was not found.',
      );
    }
    await (_db.update(_db.followUps)..where(
          (t) => t.id.equals(id) & t.organizationId.equals(organizationId),
        ))
        .write(
          FollowUpsCompanion(
            status: Value(status),
            resolutionNote: resolutionNote == null
                ? const Value.absent()
                : Value(resolutionNote),
            contactChannel: contactChannel == null
                ? const Value.absent()
                : Value(contactChannel),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );
    return (await (_db.select(
      _db.followUps,
    )..where((t) => t.id.equals(id))).getSingle());
  }
}
