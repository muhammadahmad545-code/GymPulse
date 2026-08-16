import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/app_exception.dart';
import '../../core/logging/app_logger.dart';
import '../../core/time/location_clock.dart';
import '../../data/db/app_database.dart' hide AttendanceEvent, AttendanceSource;
import '../../data/repositories/local_attendance_repository.dart';
import '../../data/repositories/local_member_repository.dart';
import '../attendance/attendance_source.dart';
import '../attendance/csv_import_adapter.dart';
import '../attendance/json_import_adapter.dart';
import '../models/workspace.dart';

class ImportReport {
  const ImportReport({
    required this.recordsRead,
    required this.created,
    required this.skipped,
    required this.unmatched,
    required this.errors,
    required this.errorLines,
    required this.sourceHealth,
  });

  final int recordsRead;
  final int created;
  final int skipped;
  final int unmatched;
  final int errors;
  final List<String> errorLines;
  final AttendanceSourceHealth sourceHealth;

  bool get isPartial => errors > 0 && created > 0;
}

class AttendanceIngestService {
  AttendanceIngestService({
    required LocalAttendanceRepository attendance,
    required LocalMemberRepository members,
    required AppLogger logger,
    LocationClock? clock,
    Uuid? uuid,
  }) : _attendance = attendance,
       _members = members,
       _logger = logger,
       _clock = clock ?? const LocationClock(),
       _uuid = uuid ?? const Uuid();

  final LocalAttendanceRepository _attendance;
  final LocalMemberRepository _members;
  final AppLogger _logger;
  final LocationClock _clock;
  final Uuid _uuid;

  Future<ImportReport> importCsv({
    required Workspace workspace,
    required String csv,
  }) async {
    final adapter = CsvImportAdapter();
    late final List<AttendanceEvent> events;
    try {
      events = adapter.parse(csv);
    } catch (e) {
      throw AppException(
        code: AppErrorCodes.importFailed,
        message:
            'The CSV could not be read. Include external_member_id and occurred_at columns.',
        cause: e,
      );
    }

    final source = await _attendance.ensureCsvSource(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final members = await _members.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final byExternal = <String, Member>{
      for (final m in members)
        if (m.externalMemberId != null && m.externalMemberId!.isNotEmpty)
          m.externalMemberId!: m,
    };

    var created = 0;
    var skipped = 0;
    var unmatched = 0;
    var errors = 0;
    final errorLines = <String>[];

    for (final event in events) {
      try {
        if (event.externalEventId.isNotEmpty &&
            await _attendance.eventExists(
              sourceId: source.id,
              externalEventId: event.externalEventId,
            )) {
          skipped += 1;
          continue;
        }
        final member = byExternal[event.externalMemberId];
        final matchStatus = member == null ? 'unmatched' : 'matched';
        if (member == null) unmatched += 1;
        final local = _clock.toLocation(
          event.occurredAt,
          workspace.location.timezone,
        );
        await _attendance.insertEvent(
          AttendanceEventsCompanion.insert(
            id: _uuid.v4(),
            organizationId: workspace.organization.id,
            locationId: workspace.location.id,
            memberId: Value(member?.id),
            externalMemberId: event.externalMemberId,
            sourceId: source.id,
            occurredAtUtc: event.occurredAt.toUtc(),
            occurredAtLocal: DateTime(
              local.year,
              local.month,
              local.day,
              local.hour,
              local.minute,
              local.second,
            ),
            eventType: event.eventType.isEmpty ? 'check_in' : event.eventType,
            externalEventId: Value(
              event.externalEventId.isEmpty ? null : event.externalEventId,
            ),
            rawPayloadJson: Value(event.metadata['raw']?.toString()),
            ingestedAt: DateTime.now().toUtc(),
            matchStatus: Value(matchStatus),
          ),
        );
        created += 1;
      } catch (e, st) {
        errors += 1;
        errorLines.add('Row ${event.metadata['row'] ?? '?'}: import failed');
        _logger.error('Attendance row failed', error: e, stackTrace: st);
      }
    }

    final failedCompletely = events.isNotEmpty && created == 0 && skipped == 0;
    await _attendance.markSourceAttempt(
      sourceId: source.id,
      success: created > 0 || skipped > 0,
      status: failedCompletely
          ? AttendanceSourceHealthStatus.error
          : AttendanceSourceHealthStatus.ready,
    );
    await _attendance.recordSyncRun(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      sourceId: source.id,
      status: errors > 0 && created == 0
          ? 'failed'
          : (errors > 0 ? 'partial' : 'success'),
      read: events.length,
      created: created,
      skipped: skipped,
      errors: errors,
      summary: errorLines.isEmpty ? null : errorLines.take(8).join(' | '),
    );

    final health = await importHealth(workspace);
    if (failedCompletely) {
      throw AppException(
        code: AppErrorCodes.importFailed,
        message:
            'Attendance import failed. Existing attendance was not changed.',
      );
    }
    return ImportReport(
      recordsRead: events.length,
      created: created,
      skipped: skipped,
      unmatched: unmatched,
      errors: errors,
      errorLines: errorLines,
      sourceHealth: health,
    );
  }

  Future<ImportReport> importMock(Workspace workspace) async {
    final mock = MockAttendanceSource();
    await mock.connect();
    final events = await mock.syncSince(null);
    final csv = StringBuffer()
      ..writeln('external_event_id,external_member_id,occurred_at,event_type');
    for (final e in events) {
      csv.writeln(
        '${e.externalEventId},${e.externalMemberId},${e.occurredAt.toIso8601String()},${e.eventType}',
      );
    }
    return importCsv(workspace: workspace, csv: csv.toString());
  }

  Future<ImportReport> importJson({
    required Workspace workspace,
    required String json,
  }) async {
    final adapter = JsonImportAdapter();
    late final List<AttendanceEvent> events;
    try {
      events = adapter.parse(json);
    } catch (e) {
      throw AppException(
        code: AppErrorCodes.importFailed,
        message:
            'The JSON could not be read. Use an events array with external_member_id and occurred_at.',
        cause: e,
      );
    }
    final csv = StringBuffer()
      ..writeln('external_event_id,external_member_id,occurred_at,event_type');
    for (final e in events) {
      csv.writeln(
        '${e.externalEventId},${e.externalMemberId},${e.occurredAt.toIso8601String()},${e.eventType}',
      );
    }
    return importCsv(workspace: workspace, csv: csv.toString());
  }

  Future<AttendanceSourceHealth> importHealth(Workspace workspace) async {
    final source = await _attendance.sourceFor(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final events = await _attendance.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    if (events.isNotEmpty) {
      return AttendanceSourceHealth(
        status: AttendanceSourceHealthStatus.ready,
        lastSuccessAt: source?.lastSuccessAt ?? events.first.ingestedAt,
        lastAttemptAt: source?.lastAttemptAt,
      );
    }
    if (source == null || source.lastSuccessAt == null) {
      return AttendanceSourceHealth(
        status: AttendanceSourceHealthStatus.unavailable,
        lastSuccessAt: source?.lastSuccessAt,
        lastAttemptAt: source?.lastAttemptAt,
        message: 'No attendance has been recorded yet.',
      );
    }
    final staleAfter = Duration(hours: workspace.settings.staleImportHours);
    final age = DateTime.now().toUtc().difference(source.lastSuccessAt!);
    if (source.status == 'error') {
      return AttendanceSourceHealth(
        status: AttendanceSourceHealthStatus.error,
        lastSuccessAt: source.lastSuccessAt,
        lastAttemptAt: source.lastAttemptAt,
        message: 'The last attendance import failed.',
      );
    }
    if (age > staleAfter) {
      return AttendanceSourceHealth(
        status: AttendanceSourceHealthStatus.delayed,
        lastSuccessAt: source.lastSuccessAt,
        lastAttemptAt: source.lastAttemptAt,
        message: 'Attendance import may be delayed.',
      );
    }
    return AttendanceSourceHealth(
      status: AttendanceSourceHealthStatus.ready,
      lastSuccessAt: source.lastSuccessAt,
      lastAttemptAt: source.lastAttemptAt,
    );
  }
}
