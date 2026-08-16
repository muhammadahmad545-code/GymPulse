import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/attendance/attendance_source.dart'
    show AttendanceSourceHealthStatus;
import '../db/app_database.dart';

class LocalAttendanceRepository {
  LocalAttendanceRepository({required AppDatabase db, Uuid? uuid})
    : _db = db,
      _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  Future<AttendanceSource> ensureManualSource({
    required String organizationId,
    required String locationId,
  }) {
    return _ensureSource(
      organizationId: organizationId,
      locationId: locationId,
      type: 'manual',
      vendor: 'in-app',
    );
  }

  Future<AttendanceSource> ensureCsvSource({
    required String organizationId,
    required String locationId,
  }) {
    return _ensureSource(
      organizationId: organizationId,
      locationId: locationId,
      type: 'csv',
      vendor: 'csv-file',
    );
  }

  Future<AttendanceSource> _ensureSource({
    required String organizationId,
    required String locationId,
    required String type,
    required String vendor,
  }) async {
    final existing =
        await (_db.select(_db.attendanceSources)..where(
              (t) =>
                  t.organizationId.equals(organizationId) &
                  t.locationId.equals(locationId) &
                  t.type.equals(type),
            ))
            .getSingleOrNull();
    if (existing != null) return existing;
    final now = DateTime.now().toUtc();
    final id = _uuid.v4();
    await _db
        .into(_db.attendanceSources)
        .insert(
          AttendanceSourcesCompanion.insert(
            id: id,
            organizationId: organizationId,
            locationId: locationId,
            type: type,
            vendor: Value(vendor),
            status: const Value('ready'),
            lastAttemptAt: Value(now),
          ),
        );
    return (await (_db.select(
      _db.attendanceSources,
    )..where((t) => t.id.equals(id))).getSingle());
  }

  Future<AttendanceSource?> sourceFor({
    required String organizationId,
    required String locationId,
  }) async {
    final rows =
        await (_db.select(_db.attendanceSources)..where(
              (t) =>
                  t.organizationId.equals(organizationId) &
                  t.locationId.equals(locationId),
            ))
            .get();
    if (rows.isEmpty) return null;
    AttendanceSource? manual;
    AttendanceSource? ready;
    for (final row in rows) {
      if (row.type == 'manual') manual = row;
      if (row.lastSuccessAt != null) ready = row;
    }
    return manual ?? ready ?? rows.first;
  }

  Future<void> markSourceAttempt({
    required String sourceId,
    required bool success,
    AttendanceSourceHealthStatus? status,
  }) async {
    final now = DateTime.now().toUtc();
    await (_db.update(
      _db.attendanceSources,
    )..where((t) => t.id.equals(sourceId))).write(
      AttendanceSourcesCompanion(
        lastAttemptAt: Value(now),
        lastSuccessAt: success ? Value(now) : const Value.absent(),
        status: Value(status?.name ?? (success ? 'ready' : 'error')),
      ),
    );
  }

  Future<bool> eventExists({
    required String sourceId,
    required String externalEventId,
  }) async {
    if (externalEventId.isEmpty) return false;
    final row =
        await (_db.select(_db.attendanceEvents)..where(
              (t) =>
                  t.sourceId.equals(sourceId) &
                  t.externalEventId.equals(externalEventId),
            ))
            .getSingleOrNull();
    return row != null;
  }

  Future<void> insertEvent(AttendanceEventsCompanion row) {
    return _db.into(_db.attendanceEvents).insert(row);
  }

  Future<List<AttendanceEvent>> list({
    required String organizationId,
    String? locationId,
    String? memberId,
    DateTime? sinceUtc,
  }) {
    final query = _db.select(_db.attendanceEvents)
      ..where((t) => t.organizationId.equals(organizationId))
      ..orderBy([(t) => OrderingTerm.desc(t.occurredAtUtc)]);
    if (locationId != null) {
      query.where((t) => t.locationId.equals(locationId));
    }
    if (memberId != null) {
      query.where((t) => t.memberId.equals(memberId));
    }
    if (sinceUtc != null) {
      query.where((t) => t.occurredAtUtc.isBiggerOrEqualValue(sinceUtc));
    }
    return query.get();
  }

  Future<int> unmatchedCount({
    required String organizationId,
    required String locationId,
  }) async {
    final rows =
        await (_db.select(_db.attendanceEvents)..where(
              (t) =>
                  t.organizationId.equals(organizationId) &
                  t.locationId.equals(locationId) &
                  t.matchStatus.equals('unmatched'),
            ))
            .get();
    return rows.length;
  }

  Future<void> recordSyncRun({
    required String organizationId,
    required String locationId,
    required String sourceId,
    required String status,
    required int read,
    required int created,
    required int skipped,
    required int errors,
    String? summary,
  }) {
    return _db
        .into(_db.integrationSyncRuns)
        .insert(
          IntegrationSyncRunsCompanion.insert(
            id: _uuid.v4(),
            organizationId: organizationId,
            locationId: locationId,
            sourceId: sourceId,
            startedAt: DateTime.now().toUtc(),
            completedAt: Value(DateTime.now().toUtc()),
            status: status,
            recordsRead: Value(read),
            recordsCreated: Value(created),
            recordsSkipped: Value(skipped),
            errorCount: Value(errors),
            errorSummary: Value(summary),
          ),
        );
  }
}
