import 'package:drift/drift.dart';

import '../../core/errors/app_exception.dart';
import '../../data/db/app_database.dart';
import '../../data/repositories/local_attendance_repository.dart';
import '../../data/repositories/local_member_repository.dart';
import '../models/workspace.dart';

/// Plain-text CSV interoperability. This is NOT an encrypted backup.
class CsvInteropService {
  CsvInteropService({
    required LocalMemberRepository members,
    required LocalAttendanceRepository attendance,
    required AppDatabase db,
  }) : _members = members,
       _attendance = attendance,
       _db = db;

  final LocalMemberRepository _members;
  final LocalAttendanceRepository _attendance;
  final AppDatabase _db;

  Future<String> exportMembers(Workspace workspace) async {
    final rows = await _members.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final out = StringBuffer()
      ..writeln('external_member_id,first_name,last_name,phone,email,status');
    for (final m in rows) {
      out.writeln(
        '${_csv(m.externalMemberId)},${_csv(m.firstName)},${_csv(m.lastName)},${_csv(m.phone)},${_csv(m.email)},${_csv(m.status)}',
      );
    }
    return out.toString();
  }

  Future<String> exportAttendance(Workspace workspace) async {
    final rows = await _attendance.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final out = StringBuffer()
      ..writeln(
        'external_event_id,external_member_id,occurred_at,event_type,match_status',
      );
    for (final e in rows) {
      out.writeln(
        '${_csv(e.externalEventId)},${_csv(e.externalMemberId)},${e.occurredAtUtc.toIso8601String()},${_csv(e.eventType)},${_csv(e.matchStatus)}',
      );
    }
    return out.toString();
  }

  Future<String> exportFollowUps(Workspace workspace) async {
    final rows =
        await (_db.select(_db.followUps)..where(
              (t) =>
                  t.organizationId.equals(workspace.organization.id) &
                  t.locationId.equals(workspace.location.id),
            ))
            .get();
    final out = StringBuffer()
      ..writeln('member_id,type,reason,status,priority,due_at');
    for (final f in rows) {
      out.writeln(
        '${_csv(f.memberId)},${_csv(f.type)},${_csv(f.reason)},${_csv(f.status)},${f.priority},${f.dueAt?.toIso8601String() ?? ''}',
      );
    }
    return out.toString();
  }

  Future<int> importMembers({
    required Workspace workspace,
    required String csv,
  }) async {
    final lines = csv.split(RegExp(r'\r?\n')).where((l) => l.trim().isNotEmpty);
    if (lines.isEmpty) {
      throw AppException(
        code: AppErrorCodes.importFailed,
        message: 'The member CSV is empty.',
      );
    }
    final header = lines.first.toLowerCase();
    if (!header.contains('first_name')) {
      throw AppException(
        code: AppErrorCodes.importFailed,
        message: 'Member CSV must include a first_name column.',
      );
    }
    var created = 0;
    for (final line in lines.skip(1)) {
      final cols = _split(line);
      if (cols.isEmpty || cols[0].trim().isEmpty && cols.length < 2) continue;
      final first = cols.length > 1 ? cols[1].trim() : cols[0].trim();
      if (first.isEmpty) continue;
      await _members.create(
        organizationId: workspace.organization.id,
        locationId: workspace.location.id,
        firstName: first,
        lastName: cols.length > 2 ? cols[2] : '',
        externalMemberId: cols.isNotEmpty ? cols[0] : null,
        phone: cols.length > 3 ? cols[3] : null,
        email: cols.length > 4 ? cols[4] : null,
        status: cols.length > 5 && cols[5].isNotEmpty ? cols[5] : 'active',
      );
      created += 1;
    }
    return created;
  }

  Future<String> exportTrials(Workspace workspace) async {
    final rows =
        await (_db.select(_db.trials)..where(
              (t) =>
                  t.organizationId.equals(workspace.organization.id) &
                  t.locationId.equals(workspace.location.id),
            ))
            .get();
    final out = StringBuffer()
      ..writeln('member_id,status,started_at,ends_at,converted_at,source');
    for (final t in rows) {
      out.writeln(
        '${_csv(t.memberId)},${_csv(t.status)},${t.startedAt.toIso8601String()},${t.endsAt.toIso8601String()},${t.convertedAt?.toIso8601String() ?? ''},${_csv(t.source)}',
      );
    }
    return out.toString();
  }

  Future<String> exportCancellations(Workspace workspace) async {
    final rows =
        await (_db.select(_db.cancellationEvents)..where(
              (t) =>
                  t.organizationId.equals(workspace.organization.id) &
                  t.locationId.equals(workspace.location.id),
            ))
            .get();
    final out = StringBuffer()
      ..writeln('member_id,occurred_at,reason_code,reason_text,source');
    for (final c in rows) {
      out.writeln(
        '${_csv(c.memberId)},${c.occurredAt.toIso8601String()},${_csv(c.reasonCode)},${_csv(c.reasonText)},${_csv(c.source)}',
      );
    }
    return out.toString();
  }

  String exportOperations({
    required String locationName,
    required String explanation,
    required List<String> peakLines,
    required List<String> locationLines,
  }) {
    final out = StringBuffer()
      ..writeln('GymPulse operations report')
      ..writeln('location,$locationName')
      ..writeln('notes,$explanation')
      ..writeln()
      ..writeln('peak_hours')
      ..writeln('weekday,hour,visits,average,max,p90,rolling_average,label');
    for (final line in peakLines) {
      out.writeln(line);
    }
    out
      ..writeln()
      ..writeln('locations')
      ..writeln('name,visits,unique,unmatched,active_members,notes');
    for (final line in locationLines) {
      out.writeln(line);
    }
    return out.toString();
  }

  String _csv(String? value) {
    final raw = value ?? '';
    if (raw.contains(',') || raw.contains('"') || raw.contains('\n')) {
      return '"${raw.replaceAll('"', '""')}"';
    }
    return raw;
  }

  List<String> _split(String line) =>
      line.split(',').map((e) => e.trim()).toList();
}
