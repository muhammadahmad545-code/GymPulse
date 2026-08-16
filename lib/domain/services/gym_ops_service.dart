import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/app_exception.dart';
import '../../core/time/location_clock.dart';
import '../../data/db/app_database.dart';
import '../../data/repositories/local_attendance_repository.dart';
import '../../data/repositories/local_follow_up_repository.dart';
import '../../data/repositories/local_member_repository.dart';
import '../../data/repositories/local_membership_repository.dart';
import '../models/workspace.dart';
import 'fee_cycle.dart';

class FeeStatus {
  const FeeStatus({
    required this.nextFeeDate,
    required this.dueToday,
    required this.dueIn3Days,
    required this.overdue,
    required this.label,
  });

  final DateTime nextFeeDate;
  final bool dueToday;
  final bool dueIn3Days;
  final bool overdue;
  final String label;
}

class MemberDirectoryRow {
  const MemberDirectoryRow({
    required this.member,
    required this.displayName,
    required this.fee,
    this.lastVisit,
    this.visitCount = 0,
    this.riskLevel,
  });

  final Member member;
  final String displayName;
  final FeeStatus fee;
  final DateTime? lastVisit;
  final int visitCount;
  final String? riskLevel;
}

class GymDashboard {
  const GymDashboard({
    required this.todayAttendance,
    required this.activeMembers,
    required this.feesDueToday,
    required this.feesDueIn3Days,
    required this.overdue,
    required this.recentAttendance,
    required this.inactive,
    required this.openFollowUps,
    required this.pendingReminders,
  });

  final int todayAttendance;
  final int activeMembers;
  final List<MemberDirectoryRow> feesDueToday;
  final List<MemberDirectoryRow> feesDueIn3Days;
  final List<MemberDirectoryRow> overdue;
  final List<AttendanceEvent> recentAttendance;
  final List<MemberDirectoryRow> inactive;
  final int openFollowUps;
  final List<FeeReminder> pendingReminders;
}

class SearchHit {
  const SearchHit({
    required this.kind,
    required this.id,
    required this.title,
    required this.subtitle,
    this.memberId,
  });

  final String kind;
  final String id;
  final String title;
  final String subtitle;
  final String? memberId;
}

class MarkAttendanceResult {
  const MarkAttendanceResult({
    required this.event,
    required this.alreadyMarked,
  });

  final AttendanceEvent event;
  final bool alreadyMarked;
}

/// In-app attendance, fee reminders, and local search for Mr. Gym.
class GymOpsService {
  GymOpsService({
    required AppDatabase db,
    required LocalMemberRepository members,
    required LocalMembershipRepository memberships,
    required LocalAttendanceRepository attendance,
    required LocalFollowUpRepository followUps,
    LocationClock? clock,
    FeeCycle? feeCycle,
    Uuid? uuid,
  }) : _db = db,
       _members = members,
       _memberships = memberships,
       _attendance = attendance,
       _followUps = followUps,
       _clock = clock ?? const LocationClock(),
       _fees = feeCycle ?? const FeeCycle(),
       _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final LocalMemberRepository _members;
  final LocalMembershipRepository _memberships;
  final LocalAttendanceRepository _attendance;
  final LocalFollowUpRepository _followUps;
  final LocationClock _clock;
  final FeeCycle _fees;
  final Uuid _uuid;

  static const reminderDueSoon = 'due_in_3_days';
  static const reminderDueToday = 'due_today';

  Future<MarkAttendanceResult> markAttendance({
    required Workspace workspace,
    required String memberId,
    bool allowDuplicate = false,
    DateTime? nowUtc,
  }) async {
    final member = await _members.get(
      organizationId: workspace.organization.id,
      id: memberId,
    );
    if (member == null || member.status != 'active') {
      throw AppException(
        code: AppErrorCodes.memberNotFound,
        message: member == null
            ? 'Member was not found.'
            : 'Inactive members cannot be marked present.',
      );
    }
    final now = nowUtc ?? DateTime.now().toUtc();
    final local = _clock.toLocation(now, workspace.location.timezone);
    final localDate =
        '${local.year.toString().padLeft(4, '0')}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
    final existing = await _todayMark(
      organizationId: workspace.organization.id,
      memberId: memberId,
      localDate: localDate,
    );
    if (existing != null && !allowDuplicate) {
      throw AppException(
        code: AppErrorCodes.attendanceDuplicateEvent,
        message: 'Attendance already marked today.',
      );
    }
    final source = await _attendance.ensureManualSource(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final id = _uuid.v4();
    final suffix = existing == null ? localDate : '$localDate-$id';
    await _attendance.insertEvent(
      AttendanceEventsCompanion.insert(
        id: id,
        organizationId: workspace.organization.id,
        locationId: workspace.location.id,
        memberId: Value(member.id),
        externalMemberId: member.externalMemberId ?? member.id,
        sourceId: source.id,
        occurredAtUtc: now,
        occurredAtLocal: DateTime(
          local.year,
          local.month,
          local.day,
          local.hour,
          local.minute,
          local.second,
        ),
        eventType: 'check_in',
        externalEventId: Value('manual-${member.id}-$suffix'),
        ingestedAt: now,
        matchStatus: const Value('matched'),
        localDate: Value(localDate),
        isManual: const Value(true),
      ),
    );
    await _attendance.markSourceAttempt(sourceId: source.id, success: true);
    final created = (await (_db.select(
      _db.attendanceEvents,
    )..where((t) => t.id.equals(id))).getSingle());
    return MarkAttendanceResult(
      event: created,
      alreadyMarked: existing != null,
    );
  }

  Future<AttendanceEvent?> todaysAttendance({
    required Workspace workspace,
    required String memberId,
    DateTime? nowUtc,
  }) async {
    final now = nowUtc ?? DateTime.now().toUtc();
    final local = _clock.toLocation(now, workspace.location.timezone);
    final localDate =
        '${local.year.toString().padLeft(4, '0')}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
    return _todayMark(
      organizationId: workspace.organization.id,
      memberId: memberId,
      localDate: localDate,
    );
  }

  FeeStatus feeStatusFor({
    required Member member,
    required DateTime todayLocal,
    Membership? membership,
  }) {
    final joined = member.joinedAt ?? member.createdAt;
    final feeDate = membership != null
        ? _fees.dateOnly(membership.endAt.toLocal())
        : _fees.nextFeeDate(joinedAt: joined.toLocal(), today: todayLocal);
    final dueToday = _fees.isDueToday(feeDate: feeDate, today: todayLocal);
    final dueIn3 = _fees.isDueInDays(
      feeDate: feeDate,
      today: todayLocal,
      days: 3,
    );
    final overdue = membership != null
        ? _fees.isOverdue(
            feeDate: membership.endAt.toLocal(),
            today: todayLocal,
          )
        : _fees.isOverdue(
                feeDate: _fees.currentCycleDate(
                  joinedAt: joined.toLocal(),
                  today: todayLocal,
                ),
                today: todayLocal,
              ) &&
              !dueToday;
    final label = overdue
        ? 'Overdue'
        : dueToday
        ? 'Due today'
        : dueIn3
        ? 'Due in 3 days'
        : 'Next fee ${_fees.dateOnly(feeDate).toIso8601String().split('T').first}';
    return FeeStatus(
      nextFeeDate: _fees.dateOnly(feeDate),
      dueToday: dueToday,
      dueIn3Days: dueIn3,
      overdue: overdue,
      label: label,
    );
  }

  Future<List<MemberDirectoryRow>> directory({
    required Workspace workspace,
    DateTime? nowUtc,
  }) async {
    final now = nowUtc ?? DateTime.now().toUtc();
    final today = _clock.toLocation(now, workspace.location.timezone);
    final members = await _members.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final memberships = await _memberships.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final events = await _attendance.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final last = <String, DateTime>{};
    final counts = <String, int>{};
    for (final event in events) {
      if (event.memberId == null) continue;
      counts[event.memberId!] = (counts[event.memberId!] ?? 0) + 1;
      final current = last[event.memberId!];
      if (current == null || event.occurredAtUtc.isAfter(current)) {
        last[event.memberId!] = event.occurredAtUtc;
      }
    }
    Membership? latest(String memberId) {
      final mine = memberships.where((m) => m.memberId == memberId).toList()
        ..sort((a, b) => b.endAt.compareTo(a.endAt));
      return mine.isEmpty ? null : mine.first;
    }

    return members.map((member) {
      return MemberDirectoryRow(
        member: member,
        displayName: '${member.firstName} ${member.lastName}'.trim(),
        fee: feeStatusFor(
          member: member,
          todayLocal: today,
          membership: latest(member.id),
        ),
        lastVisit: last[member.id],
        visitCount: counts[member.id] ?? 0,
      );
    }).toList();
  }

  Future<GymDashboard> dashboard({
    required Workspace workspace,
    DateTime? nowUtc,
  }) async {
    final now = nowUtc ?? DateTime.now().toUtc();
    final today = _clock.toLocation(now, workspace.location.timezone);
    final localDate =
        '${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    final rows = await directory(workspace: workspace, nowUtc: now);
    final events = await _attendance.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final todayEvents = events.where((e) {
      if (e.localDate == localDate) return true;
      final local = e.occurredAtLocal;
      return local.year == today.year &&
          local.month == today.month &&
          local.day == today.day;
    }).toList();
    final open = await _followUps.listOpen(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final reminders = await pendingReminders(workspace);
    final inactive = rows.where((r) {
      if (r.member.status != 'active') return false;
      if (r.lastVisit == null) return true;
      return now.difference(r.lastVisit!).inDays >=
          workspace.settings.inactivityFollowUpDays;
    }).toList();
    return GymDashboard(
      todayAttendance: todayEvents.length,
      activeMembers: rows.where((r) => r.member.status == 'active').length,
      feesDueToday: rows
          .where((r) => r.member.status == 'active' && r.fee.dueToday)
          .toList(),
      feesDueIn3Days: rows
          .where((r) => r.member.status == 'active' && r.fee.dueIn3Days)
          .toList(),
      overdue: rows
          .where((r) => r.member.status == 'active' && r.fee.overdue)
          .toList(),
      recentAttendance: events.take(12).toList(),
      inactive: inactive,
      openFollowUps: open.length,
      pendingReminders: reminders,
    );
  }

  Future<List<FeeReminder>> generateDueReminders({
    required Workspace workspace,
    DateTime? nowUtc,
  }) async {
    final now = nowUtc ?? DateTime.now().toUtc();
    final rows = await directory(workspace: workspace, nowUtc: now);
    final created = <FeeReminder>[];
    for (final row in rows.where((r) => r.member.status == 'active')) {
      if (row.fee.dueIn3Days) {
        final reminder = await _ensureReminder(
          workspace: workspace,
          member: row.member,
          feeDate: row.fee.nextFeeDate,
          type: reminderDueSoon,
          now: now,
        );
        if (reminder != null) created.add(reminder);
      }
      if (row.fee.dueToday) {
        final reminder = await _ensureReminder(
          workspace: workspace,
          member: row.member,
          feeDate: row.fee.nextFeeDate,
          type: reminderDueToday,
          now: now,
        );
        if (reminder != null) created.add(reminder);
      }
    }
    return created;
  }

  Future<List<FeeReminder>> pendingReminders(Workspace workspace) {
    return (_db.select(_db.feeReminders)..where(
          (t) =>
              t.organizationId.equals(workspace.organization.id) &
              t.locationId.equals(workspace.location.id) &
              t.status.equals('pending'),
        ))
        .get();
  }

  Future<List<FeeReminder>> remindersForMember({
    required Workspace workspace,
    required String memberId,
  }) {
    return (_db.select(_db.feeReminders)
          ..where(
            (t) =>
                t.organizationId.equals(workspace.organization.id) &
                t.memberId.equals(memberId),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.generatedAt)]))
        .get();
  }

  Future<void> markReminderOpened(String reminderId) async {
    final now = DateTime.now().toUtc();
    await (_db.update(
      _db.feeReminders,
    )..where((t) => t.id.equals(reminderId))).write(
      FeeRemindersCompanion(
        status: const Value('opened'),
        openedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> markReminderDismissed(String reminderId) async {
    await (_db.update(
      _db.feeReminders,
    )..where((t) => t.id.equals(reminderId))).write(
      FeeRemindersCompanion(
        status: const Value('dismissed'),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> markReminderCompleted(String reminderId) async {
    await (_db.update(
      _db.feeReminders,
    )..where((t) => t.id.equals(reminderId))).write(
      FeeRemindersCompanion(
        status: const Value('completed'),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  String feeWhatsAppMessage({
    required String memberName,
    required DateTime feeDate,
    required String type,
  }) {
    final date =
        '${feeDate.year.toString().padLeft(4, '0')}-${feeDate.month.toString().padLeft(2, '0')}-${feeDate.day.toString().padLeft(2, '0')}';
    if (type == reminderDueSoon) {
      return 'Assalam-o-Alaikum $memberName,\n\nThis is a friendly reminder from Mr. Gym that your monthly gym fee is due in 3 days, on $date.\n\nThank you,\nMr. Gym';
    }
    return 'Assalam-o-Alaikum $memberName,\n\nThis is a friendly reminder from Mr. Gym that your monthly gym fee is due on $date.\n\nThank you,\nMr. Gym';
  }

  Future<List<SearchHit>> search({
    required Workspace workspace,
    required String query,
  }) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    final hits = <SearchHit>[];
    final members = await _members.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    for (final member in members) {
      final name = '${member.firstName} ${member.lastName}'.trim();
      final hay = '$name ${member.phone ?? ''} ${member.notes ?? ''}'
          .toLowerCase();
      if (hay.contains(q)) {
        hits.add(
          SearchHit(
            kind: 'member',
            id: member.id,
            title: name,
            subtitle: member.phone ?? 'No WhatsApp number',
            memberId: member.id,
          ),
        );
      }
    }
    final followUps = await _followUps.listOpen(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    for (final item in followUps) {
      if (item.reason.toLowerCase().contains(q) ||
          item.type.toLowerCase().contains(q)) {
        hits.add(
          SearchHit(
            kind: 'follow_up',
            id: item.id,
            title: item.reason,
            subtitle: item.type,
            memberId: item.memberId,
          ),
        );
      }
    }
    final events = await _attendance.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    for (final event in events.take(400)) {
      final stamp = event.localDate ?? event.occurredAtLocal.toIso8601String();
      if (stamp.toLowerCase().contains(q) ||
          event.externalMemberId.toLowerCase().contains(q)) {
        hits.add(
          SearchHit(
            kind: 'attendance',
            id: event.id,
            title: 'Attendance $stamp',
            subtitle: event.externalMemberId,
            memberId: event.memberId,
          ),
        );
      }
    }
    return hits.take(40).toList();
  }

  Future<List<CancellationReason>> listReasons(String organizationId) {
    return (_db.select(_db.cancellationReasons)
          ..where((t) => t.organizationId.equals(organizationId))
          ..orderBy([(t) => OrderingTerm.asc(t.label)]))
        .get();
  }

  Future<CancellationReason> addReason({
    required String organizationId,
    required String label,
  }) async {
    final trimmed = label.trim();
    if (trimmed.isEmpty) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'A cancellation reason is required.',
      );
    }
    final now = DateTime.now().toUtc();
    final code = trimmed.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');
    final id = _uuid.v4();
    await _db
        .into(_db.cancellationReasons)
        .insert(
          CancellationReasonsCompanion.insert(
            id: id,
            organizationId: organizationId,
            code: code.isEmpty ? id : code,
            label: trimmed,
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (await (_db.select(
      _db.cancellationReasons,
    )..where((t) => t.id.equals(id))).getSingle());
  }

  Future<void> setReasonActive({
    required String organizationId,
    required String id,
    required bool active,
  }) async {
    await (_db.update(_db.cancellationReasons)..where(
          (t) => t.id.equals(id) & t.organizationId.equals(organizationId),
        ))
        .write(
          CancellationReasonsCompanion(
            active: Value(active),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );
  }

  Future<void> seedDefaultReasons(String organizationId) async {
    final existing = await listReasons(organizationId);
    if (existing.isNotEmpty) return;
    const defaults = {
      'price': 'Too expensive',
      'moving': 'Moving away',
      'schedule': 'Not enough time',
      'health': 'Health/personal reasons',
      'not_satisfied': 'Not satisfied',
      'equipment': 'Equipment',
      'trainer': 'Trainer',
      'another_gym': 'Found another gym',
      'other': 'Other',
    };
    final now = DateTime.now().toUtc();
    for (final entry in defaults.entries) {
      await _db
          .into(_db.cancellationReasons)
          .insert(
            CancellationReasonsCompanion.insert(
              id: _uuid.v4(),
              organizationId: organizationId,
              code: entry.key,
              label: entry.value,
              createdAt: now,
              updatedAt: now,
            ),
          );
    }
  }

  Future<FeeReminder?> _ensureReminder({
    required Workspace workspace,
    required Member member,
    required DateTime feeDate,
    required String type,
    required DateTime now,
  }) async {
    final cycle = DateTime.utc(feeDate.year, feeDate.month, feeDate.day);
    final existing =
        await (_db.select(_db.feeReminders)..where(
              (t) =>
                  t.memberId.equals(member.id) &
                  t.feeCycleDate.equals(cycle) &
                  t.reminderType.equals(type),
            ))
            .getSingleOrNull();
    if (existing != null) return null;
    final id = _uuid.v4();
    await _db
        .into(_db.feeReminders)
        .insert(
          FeeRemindersCompanion.insert(
            id: id,
            organizationId: workspace.organization.id,
            locationId: workspace.location.id,
            memberId: member.id,
            feeCycleDate: cycle,
            reminderType: type,
            generatedAt: now,
            updatedAt: now,
          ),
        );
    return (await (_db.select(
      _db.feeReminders,
    )..where((t) => t.id.equals(id))).getSingle());
  }

  Future<AttendanceEvent?> _todayMark({
    required String organizationId,
    required String memberId,
    required String localDate,
  }) async {
    final rows =
        await (_db.select(_db.attendanceEvents)
              ..where(
                (t) =>
                    t.organizationId.equals(organizationId) &
                    t.memberId.equals(memberId) &
                    t.localDate.equals(localDate) &
                    t.isManual.equals(true),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.occurredAtUtc)]))
            .get();
    return rows.isEmpty ? null : rows.first;
  }
}
