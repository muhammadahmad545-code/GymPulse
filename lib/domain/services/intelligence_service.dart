import '../../core/time/location_clock.dart';
import '../../data/db/app_database.dart';
import '../../data/repositories/local_attendance_repository.dart';
import '../../data/repositories/local_follow_up_repository.dart';
import '../../data/repositories/local_member_repository.dart';
import '../../data/repositories/local_membership_repository.dart';
import '../attendance/attendance_source.dart' hide AttendanceEvent;
import '../models/workspace.dart';

enum InactivityLevel { none, monitor, followUp, highRisk, critical }

class MemberInsight {
  const MemberInsight({
    required this.member,
    required this.daysSinceVisit,
    required this.inactivityLevel,
    required this.membership,
    required this.daysUntilExpiry,
  });

  final Member member;
  final int? daysSinceVisit;
  final InactivityLevel inactivityLevel;
  final Membership? membership;
  final int? daysUntilExpiry;
}

class HealthScore {
  const HealthScore({
    required this.hasEnoughData,
    this.score,
    this.explanation = 'Not enough data',
    this.components = const {},
    this.confidence = 0,
  });

  final bool hasEnoughData;
  final int? score;
  final String explanation;
  final Map<String, int> components;
  final double confidence;
}

class PeakHour {
  const PeakHour({
    required this.hour,
    required this.visits,
    required this.label,
  });

  final int hour;
  final int visits;
  final String label;
}

class AttendanceSummary {
  const AttendanceSummary({
    required this.visits,
    required this.uniqueVisitors,
    required this.reliable,
    required this.health,
  });

  final int visits;
  final int uniqueVisitors;
  final bool reliable;
  final AttendanceSourceHealth health;
}

class DashboardSnapshot {
  const DashboardSnapshot({
    required this.healthScore,
    required this.attendance,
    required this.expiring,
    required this.inactive,
    required this.peakHours,
    required this.openFollowUps,
    required this.unmatchedEvents,
    required this.activeMembers,
  });

  final HealthScore healthScore;
  final AttendanceSummary attendance;
  final List<MemberInsight> expiring;
  final List<MemberInsight> inactive;
  final List<PeakHour> peakHours;
  final int openFollowUps;
  final int unmatchedEvents;
  final int activeMembers;
}

class IntelligenceService {
  IntelligenceService({
    required LocalMemberRepository members,
    required LocalMembershipRepository memberships,
    required LocalAttendanceRepository attendance,
    required LocalFollowUpRepository followUps,
    required AppDatabase db,
    LocationClock? clock,
  }) : _members = members,
       _memberships = memberships,
       _attendance = attendance,
       _followUps = followUps,
       _db = db,
       _clock = clock ?? const LocationClock();

  final LocalMemberRepository _members;
  final LocalMembershipRepository _memberships;
  final LocalAttendanceRepository _attendance;
  final LocalFollowUpRepository _followUps;
  final AppDatabase _db;
  final LocationClock _clock;

  Future<DashboardSnapshot> dashboard({
    required Workspace workspace,
    required AttendanceSourceHealth importHealth,
  }) async {
    final insights = await memberInsights(
      workspace: workspace,
      importHealth: importHealth,
    );
    final expiring =
        insights
            .where(
              (i) =>
                  i.daysUntilExpiry != null &&
                  i.daysUntilExpiry! >= 0 &&
                  i.daysUntilExpiry! <= 30 &&
                  i.membership?.status != 'cancelled',
            )
            .toList()
          ..sort((a, b) => a.daysUntilExpiry!.compareTo(b.daysUntilExpiry!));
    final inactive =
        insights
            .where((i) => i.inactivityLevel != InactivityLevel.none)
            .toList()
          ..sort(
            (a, b) => (b.daysSinceVisit ?? 0).compareTo(a.daysSinceVisit ?? 0),
          );

    await _syncFollowUps(workspace, expiring, inactive, importHealth);

    final since = DateTime.now().toUtc().subtract(const Duration(days: 7));
    final weekEvents = await _attendance.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      sinceUtc: since,
    );
    final unique = weekEvents.map((e) => e.externalMemberId).toSet().length;
    final attendance = AttendanceSummary(
      visits: weekEvents.length,
      uniqueVisitors: unique,
      reliable: importHealth.isDataReliable,
      health: importHealth,
    );
    final open = await _followUps.listOpen(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final unmatched = await _attendance.unmatchedCount(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final active = insights.where((i) => i.member.status == 'active').length;
    return DashboardSnapshot(
      healthScore: _healthScore(
        insights: insights,
        attendance: attendance,
        importHealth: importHealth,
        unmatched: unmatched,
      ),
      attendance: attendance,
      expiring: expiring,
      inactive: inactive,
      peakHours: _peakHours(weekEvents, workspace),
      openFollowUps: open.length,
      unmatchedEvents: unmatched,
      activeMembers: active,
    );
  }

  Future<List<MemberInsight>> memberInsights({
    required Workspace workspace,
    required AttendanceSourceHealth importHealth,
  }) async {
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
    final lastVisit = <String, DateTime>{};
    for (final event in events) {
      if (event.memberId == null) continue;
      final current = lastVisit[event.memberId!];
      if (current == null || event.occurredAtUtc.isAfter(current)) {
        lastVisit[event.memberId!] = event.occurredAtUtc;
      }
    }
    final now = DateTime.now().toUtc();
    final closures = LocationSettingView.fromRow(
      workspace.settings,
    ).closureDates;
    final settings = workspace.settings;
    return members.map((member) {
      final membership = _currentMembership(memberships, member.id);
      final last = lastVisit[member.id];
      int? daysSince;
      if (last != null) {
        daysSince = now.difference(last).inDays;
      }
      var level = InactivityLevel.none;
      final canJudgeInactivity =
          importHealth.isDataReliable &&
          member.status == 'active' &&
          (membership == null || membership.status == 'active') &&
          !_clock.isClosureDay(now, workspace.location.timezone, closures);
      if (canJudgeInactivity && daysSince != null) {
        if (daysSince >= settings.inactivityCriticalDays) {
          level = InactivityLevel.critical;
        } else if (daysSince >= settings.inactivityHighRiskDays) {
          level = InactivityLevel.highRisk;
        } else if (daysSince >= settings.inactivityFollowUpDays) {
          level = InactivityLevel.followUp;
        } else if (daysSince >= settings.inactivityMonitorDays) {
          level = InactivityLevel.monitor;
        }
      }
      int? daysUntilExpiry;
      if (membership != null) {
        daysUntilExpiry = membership.endAt.toUtc().difference(now).inDays;
      }
      return MemberInsight(
        member: member,
        daysSinceVisit: daysSince,
        inactivityLevel: level,
        membership: membership,
        daysUntilExpiry: daysUntilExpiry,
      );
    }).toList();
  }

  Membership? _currentMembership(List<Membership> all, String memberId) {
    final mine = all.where((m) => m.memberId == memberId).toList()
      ..sort((a, b) => b.endAt.compareTo(a.endAt));
    return mine.isEmpty ? null : mine.first;
  }

  Future<void> _syncFollowUps(
    Workspace workspace,
    List<MemberInsight> expiring,
    List<MemberInsight> inactive,
    AttendanceSourceHealth importHealth,
  ) async {
    for (final item in expiring.take(50)) {
      final existing = await _followUps.openFor(
        organizationId: workspace.organization.id,
        memberId: item.member.id,
        type: 'expiry',
      );
      if (existing != null) continue;
      final days = item.daysUntilExpiry ?? 0;
      await _followUps.create(
        organizationId: workspace.organization.id,
        locationId: workspace.location.id,
        memberId: item.member.id,
        type: 'expiry',
        reason: '${item.member.firstName} membership expires in $days day(s).',
        priority: days <= 3 ? 90 : (days <= 7 ? 75 : 60),
        dueAt: DateTime.now().toUtc(),
      );
    }
    if (!importHealth.isDataReliable) return;
    for (final item in inactive.take(50)) {
      if (item.inactivityLevel == InactivityLevel.monitor) continue;
      final existing = await _followUps.openFor(
        organizationId: workspace.organization.id,
        memberId: item.member.id,
        type: 'inactivity',
      );
      if (existing != null) continue;
      await _followUps.create(
        organizationId: workspace.organization.id,
        locationId: workspace.location.id,
        memberId: item.member.id,
        type: 'inactivity',
        reason:
            '${item.member.firstName} has not visited for ${item.daysSinceVisit} day(s).',
        priority: item.inactivityLevel == InactivityLevel.critical
            ? 95
            : (item.inactivityLevel == InactivityLevel.highRisk ? 80 : 65),
        dueAt: DateTime.now().toUtc(),
      );
    }
  }

  HealthScore _healthScore({
    required List<MemberInsight> insights,
    required AttendanceSummary attendance,
    required AttendanceSourceHealth importHealth,
    required int unmatched,
  }) {
    final active = insights.where((i) => i.member.status == 'active').length;
    if (active < 3 || !importHealth.isDataReliable || attendance.visits < 5) {
      return HealthScore(
        hasEnoughData: false,
        explanation: importHealth.isDataReliable
            ? 'Not enough data. Import more attendance and members for a reliable score.'
            : 'Attendance data is stale or unavailable, so a health score is not shown.',
        confidence: 0,
      );
    }
    final retention = ((active / insights.length) * 100).round();
    final engagement = ((attendance.uniqueVisitors / active) * 100)
        .clamp(0, 100)
        .round();
    final dataQuality = unmatched == 0
        ? 90
        : (80 - (unmatched * 5)).clamp(20, 80);
    final renewalDenom = insights
        .where((i) => i.daysUntilExpiry != null && i.daysUntilExpiry! <= 30)
        .length;
    final stillActiveExpiring = insights
        .where(
          (i) =>
              i.daysUntilExpiry != null &&
              i.daysUntilExpiry! <= 30 &&
              i.membership?.status == 'active',
        )
        .length;
    final renewal = renewalDenom == 0
        ? 70
        : (((renewalDenom - stillActiveExpiring) / renewalDenom) * 100)
              .round()
              .clamp(0, 100);
    final overall =
        ((retention * 0.3) +
                (engagement * 0.25) +
                (renewal * 0.2) +
                (dataQuality * 0.25))
            .round();
    return HealthScore(
      hasEnoughData: true,
      score: overall,
      confidence: importHealth.status == AttendanceSourceHealthStatus.ready
          ? 0.8
          : 0.5,
      explanation:
          'Retention $retention, engagement $engagement, renewal pressure $renewal, data quality $dataQuality.',
      components: {
        'retention': retention,
        'engagement': engagement,
        'renewal': renewal,
        'dataQuality': dataQuality,
      },
    );
  }

  List<PeakHour> _peakHours(List<AttendanceEvent> events, Workspace workspace) {
    final counts = <int, int>{};
    for (final event in events) {
      final local = _clock.toLocation(
        event.occurredAtUtc,
        workspace.location.timezone,
      );
      counts[local.hour] = (counts[local.hour] ?? 0) + 1;
    }
    final ranked = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final capacity = workspace.location.capacity;
    final threshold = workspace.settings.peakHighAttendance;
    return ranked.take(3).map((e) {
      final crowded =
          (capacity != null && e.value >= capacity) ||
          (threshold != null && e.value >= threshold);
      return PeakHour(
        hour: e.key,
        visits: e.value,
        label: crowded ? 'Crowded' : 'High attendance',
      );
    }).toList();
  }

  Future<List<MessageTemplate>> templates(String organizationId) {
    return (_db.select(
      _db.messageTemplates,
    )..where((t) => t.organizationId.equals(organizationId))).get();
  }

  String renderTemplate({
    required String body,
    required Member member,
    required Workspace workspace,
    int? daysSinceVisit,
    DateTime? expiry,
  }) {
    return body
        .replaceAll(
          '{{member_name}}',
          '${member.firstName} ${member.lastName}'.trim(),
        )
        .replaceAll('{{gym_name}}', workspace.organization.name)
        .replaceAll('{{gym_phone}}', workspace.settings.gymPhone ?? '')
        .replaceAll('{{days_since_visit}}', daysSinceVisit?.toString() ?? '—')
        .replaceAll(
          '{{expiry_date}}',
          expiry == null ? '—' : expiry.toIso8601String().split('T').first,
        );
  }
}
