import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/app_exception.dart';
import '../../data/db/app_database.dart';
import '../../data/repositories/local_attendance_repository.dart';
import '../../data/repositories/local_follow_up_repository.dart';
import '../../data/repositories/local_member_repository.dart';
import '../../data/repositories/local_membership_repository.dart';
import '../attendance/attendance_source.dart' hide AttendanceEvent;
import '../models/workspace.dart';

class RiskWeights {
  const RiskWeights({
    this.decline = 30,
    this.inactivity = 25,
    this.expiry = 20,
    this.engagement = 15,
    this.history = 10,
  });

  final int decline;
  final int inactivity;
  final int expiry;
  final int engagement;
  final int history;

  int get total => decline + inactivity + expiry + engagement + history;

  factory RiskWeights.fromJson(String? raw) {
    if (raw == null || raw.trim().isEmpty) return const RiskWeights();
    try {
      final map = jsonDecode(raw);
      if (map is! Map) return const RiskWeights();
      final parsed = RiskWeights(
        decline: int.tryParse('${map['decline']}') ?? 30,
        inactivity: int.tryParse('${map['inactivity']}') ?? 25,
        expiry: int.tryParse('${map['expiry']}') ?? 20,
        engagement: int.tryParse('${map['engagement']}') ?? 15,
        history: int.tryParse('${map['history']}') ?? 10,
      );
      if (parsed.total <= 0) return const RiskWeights();
      return parsed;
    } catch (_) {
      return const RiskWeights();
    }
  }

  String toJson() => jsonEncode({
    'decline': decline,
    'inactivity': inactivity,
    'expiry': expiry,
    'engagement': engagement,
    'history': history,
  });
}

class AttendanceDecline {
  const AttendanceDecline({
    required this.hasEnoughData,
    this.baselinePerWeek,
    this.recentPerWeek,
    this.declinePercent,
    this.explanation = 'Not enough personal attendance history.',
  });

  final bool hasEnoughData;
  final double? baselinePerWeek;
  final double? recentPerWeek;
  final int? declinePercent;
  final String explanation;
}

class RiskFactor {
  const RiskFactor({
    required this.key,
    required this.label,
    required this.points,
    required this.weight,
    required this.used,
  });

  final String key;
  final String label;
  final int points;
  final int weight;
  final bool used;
}

class MemberRisk {
  const MemberRisk({
    required this.memberId,
    required this.memberName,
    required this.score,
    required this.level,
    required this.confidence,
    required this.factors,
    required this.enoughData,
    required this.explanation,
    this.decline,
  });

  final String memberId;
  final String memberName;
  final int score;
  final String level;
  final double confidence;
  final List<RiskFactor> factors;
  final bool enoughData;
  final String explanation;
  final AttendanceDecline? decline;
}

class TimelineItem {
  const TimelineItem({
    required this.at,
    required this.type,
    required this.title,
    this.detail,
  });

  final DateTime at;
  final String type;
  final String title;
  final String? detail;
}

class RenewalAnalytics {
  const RenewalAnalytics({
    required this.expiring7,
    required this.expiring14,
    required this.expiring30,
    required this.renewed30,
    required this.lapsed30,
    required this.hasEnoughData,
    this.renewalPercent,
    this.explanation = 'Not enough membership history.',
  });

  final int expiring7;
  final int expiring14;
  final int expiring30;
  final int renewed30;
  final int lapsed30;
  final bool hasEnoughData;
  final int? renewalPercent;
  final String explanation;
}

class TrialAnalytics {
  const TrialAnalytics({
    required this.active,
    required this.eligible,
    required this.converted,
    required this.expired,
    this.conversionPercent,
    this.explanation = 'No eligible trials yet.',
  });

  final int active;
  final int eligible;
  final int converted;
  final int expired;
  final int? conversionPercent;
  final String explanation;
}

class CancellationAnalytics {
  const CancellationAnalytics({
    required this.total,
    required this.byReason,
    this.explanation = 'No cancellations recorded.',
  });

  final int total;
  final Map<String, int> byReason;
  final String explanation;
}

class RetentionSnapshot {
  const RetentionSnapshot({
    required this.risks,
    required this.renewal,
    required this.trials,
    required this.cancellations,
  });

  final List<MemberRisk> risks;
  final RenewalAnalytics renewal;
  final TrialAnalytics trials;
  final CancellationAnalytics cancellations;
}

class CancellationReasons {
  static const defaults = <String, String>{
    'price': 'Price',
    'moving': 'Moving',
    'schedule': 'Schedule',
    'equipment': 'Equipment',
    'trainer': 'Trainer',
    'not_satisfied': 'Not satisfied',
    'another_gym': 'Found another gym',
    'other': 'Other',
  };
}

class RetentionService {
  RetentionService({
    required AppDatabase db,
    required LocalMemberRepository members,
    required LocalMembershipRepository memberships,
    required LocalAttendanceRepository attendance,
    required LocalFollowUpRepository followUps,
    Uuid? uuid,
  }) : _db = db,
       _members = members,
       _memberships = memberships,
       _attendance = attendance,
       _followUps = followUps,
       _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final LocalMemberRepository _members;
  final LocalMembershipRepository _memberships;
  final LocalAttendanceRepository _attendance;
  final LocalFollowUpRepository _followUps;
  final Uuid _uuid;

  AttendanceDecline declineFor({
    required List<AttendanceEvent> memberEvents,
    required DateTime nowUtc,
    required bool importReliable,
  }) {
    if (!importReliable) {
      return const AttendanceDecline(
        hasEnoughData: false,
        explanation:
            'Attendance is stale or unavailable, so decline is not calculated.',
      );
    }
    final visits = memberEvents
        .where((e) => e.memberId != null)
        .map((e) => e.occurredAtUtc.toUtc())
        .toList();
    if (visits.length < 4) {
      return const AttendanceDecline(hasEnoughData: false);
    }
    final recentStart = nowUtc.subtract(const Duration(days: 14));
    final baselineStart = nowUtc.subtract(const Duration(days: 70));
    final recent = visits.where((d) => !d.isBefore(recentStart)).length;
    final baseline = visits
        .where((d) => !d.isBefore(baselineStart) && d.isBefore(recentStart))
        .length;
    if (baseline < 2) {
      return const AttendanceDecline(
        hasEnoughData: false,
        explanation: 'Not enough baseline visits to compare against.',
      );
    }
    final baselinePerWeek = baseline / 8;
    final recentPerWeek = recent / 2;
    final decline = baselinePerWeek <= 0
        ? 0
        : (((baselinePerWeek - recentPerWeek) / baselinePerWeek) * 100)
              .round()
              .clamp(0, 100);
    return AttendanceDecline(
      hasEnoughData: true,
      baselinePerWeek: baselinePerWeek,
      recentPerWeek: recentPerWeek,
      declinePercent: decline,
      explanation:
          'Recent ${recentPerWeek.toStringAsFixed(1)} visits/week vs baseline ${baselinePerWeek.toStringAsFixed(1)}.',
    );
  }

  MemberRisk scoreMember({
    required Member member,
    required List<Membership> memberships,
    required List<AttendanceEvent> memberEvents,
    required List<FollowUp> historyFollowUps,
    required RiskWeights weights,
    required LocationSetting settings,
    required DateTime nowUtc,
    required bool importReliable,
  }) {
    final decline = declineFor(
      memberEvents: memberEvents,
      nowUtc: nowUtc,
      importReliable: importReliable,
    );
    DateTime? lastVisit;
    for (final event in memberEvents) {
      if (lastVisit == null || event.occurredAtUtc.isAfter(lastVisit)) {
        lastVisit = event.occurredAtUtc;
      }
    }
    final daysSince = lastVisit == null
        ? null
        : nowUtc.difference(lastVisit.toUtc()).inDays;
    final current = _latestMembership(memberships);
    final daysUntilExpiry = current?.endAt.toUtc().difference(nowUtc).inDays;

    final factors = <RiskFactor>[
      RiskFactor(
        key: 'decline',
        label: decline.hasEnoughData
            ? 'Attendance decline ${decline.declinePercent}%'
            : 'Attendance decline (not enough data)',
        points: decline.hasEnoughData ? (decline.declinePercent ?? 0) : 0,
        weight: weights.decline,
        used: decline.hasEnoughData,
      ),
      RiskFactor(
        key: 'inactivity',
        label: daysSince == null
            ? 'Days since visit unknown'
            : 'No visit for $daysSince day(s)',
        points: _inactivityPoints(daysSince, settings),
        weight: weights.inactivity,
        used: importReliable && daysSince != null,
      ),
      RiskFactor(
        key: 'expiry',
        label: daysUntilExpiry == null
            ? 'No membership dates'
            : (daysUntilExpiry < 0
                  ? 'Membership expired'
                  : 'Expires in $daysUntilExpiry day(s)'),
        points: _expiryPoints(daysUntilExpiry),
        weight: weights.expiry,
        used: daysUntilExpiry != null,
      ),
      RiskFactor(
        key: 'engagement',
        label:
            '30-day visit count ${memberEvents.where((e) => e.occurredAtUtc.isAfter(nowUtc.subtract(const Duration(days: 30)))).length}',
        points: _engagementPoints(memberEvents, nowUtc),
        weight: weights.engagement,
        used: importReliable && memberEvents.isNotEmpty,
      ),
      RiskFactor(
        key: 'history',
        label: 'Prior lapse or inactivity follow-ups',
        points: _historyPoints(memberships, historyFollowUps, nowUtc),
        weight: weights.history,
        used: true,
      ),
    ];

    final usedWeight = factors
        .where((f) => f.used)
        .fold<int>(0, (sum, f) => sum + f.weight);
    if (usedWeight == 0) {
      return MemberRisk(
        memberId: member.id,
        memberName: '${member.firstName} ${member.lastName}'.trim(),
        score: 0,
        level: 'low',
        confidence: 0,
        factors: factors,
        enoughData: false,
        explanation: 'Low confidence — more data needed.',
        decline: decline,
      );
    }
    final weighted = factors
        .where((f) => f.used)
        .fold<double>(0, (sum, f) => sum + (f.points * f.weight));
    final score = (weighted / usedWeight).round().clamp(0, 100);
    final usedCount = factors.where((f) => f.used).length;
    final confidence =
        ((usedCount / factors.length) * (importReliable ? 1 : 0.5)).clamp(
          0.0,
          1.0,
        );
    final enough = usedCount >= 3 && confidence >= 0.4;
    return MemberRisk(
      memberId: member.id,
      memberName: '${member.firstName} ${member.lastName}'.trim(),
      score: score,
      level: riskLevelFor(score),
      confidence: confidence,
      factors: factors,
      enoughData: enough,
      explanation: enough
          ? 'Explainable weighted score. Not an AI prediction.'
          : 'Low confidence — more data needed.',
      decline: decline,
    );
  }

  static String riskLevelFor(int score) {
    if (score >= 80) return 'critical';
    if (score >= 60) return 'high';
    if (score >= 30) return 'moderate';
    return 'low';
  }

  int followUpPriorityFor(MemberRisk risk) {
    if (risk.level == 'critical') return 96;
    if (risk.level == 'high') return 82;
    if (risk.level == 'moderate') return 68;
    return 40;
  }

  Future<RetentionSnapshot> snapshot({
    required Workspace workspace,
    required AttendanceSourceHealth importHealth,
  }) async {
    final now = DateTime.now().toUtc();
    final members = await _members.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final memberships = await _memberships.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final events = importHealth.isDataReliable
        ? await _attendance.list(
            organizationId: workspace.organization.id,
            locationId: workspace.location.id,
          )
        : <AttendanceEvent>[];
    final followUps =
        await (_db.select(_db.followUps)..where(
              (t) =>
                  t.organizationId.equals(workspace.organization.id) &
                  t.locationId.equals(workspace.location.id),
            ))
            .get();
    final weights = RiskWeights.fromJson(workspace.settings.riskWeightsJson);
    final eventsByMember = <String, List<AttendanceEvent>>{};
    for (final event in events) {
      if (event.memberId == null) continue;
      eventsByMember.putIfAbsent(event.memberId!, () => []).add(event);
    }
    final membershipsByMember = <String, List<Membership>>{};
    for (final row in memberships) {
      membershipsByMember.putIfAbsent(row.memberId, () => []).add(row);
    }
    final followByMember = <String, List<FollowUp>>{};
    for (final row in followUps) {
      followByMember.putIfAbsent(row.memberId, () => []).add(row);
    }

    final risks = <MemberRisk>[];
    for (final member in members) {
      final risk = scoreMember(
        member: member,
        memberships: membershipsByMember[member.id] ?? const [],
        memberEvents: eventsByMember[member.id] ?? const [],
        historyFollowUps: followByMember[member.id] ?? const [],
        weights: weights,
        settings: workspace.settings,
        nowUtc: now,
        importReliable: importHealth.isDataReliable,
      );
      risks.add(risk);
      await _persistRisk(workspace, member, risk);
      await _syncRiskFollowUp(workspace, member, risk);
    }

    return RetentionSnapshot(
      risks: risks..sort((a, b) => b.score.compareTo(a.score)),
      renewal: renewalAnalytics(memberships: memberships, nowUtc: now),
      trials: await trialAnalytics(workspace: workspace, nowUtc: now),
      cancellations: await cancellationAnalytics(workspace: workspace),
    );
  }

  RenewalAnalytics renewalAnalytics({
    required List<Membership> memberships,
    required DateTime nowUtc,
  }) {
    final byMember = <String, List<Membership>>{};
    for (final row in memberships) {
      byMember.putIfAbsent(row.memberId, () => []).add(row);
    }
    var expiring7 = 0,
        expiring14 = 0,
        expiring30 = 0,
        renewed30 = 0,
        lapsed30 = 0;
    final windowStart = nowUtc.subtract(const Duration(days: 30));
    for (final rows in byMember.values) {
      rows.sort((a, b) => a.startAt.compareTo(b.startAt));
      final current = rows.last;
      if (current.status == 'active') {
        final days = current.endAt.toUtc().difference(nowUtc).inDays;
        if (days >= 0 && days <= 7) expiring7++;
        if (days >= 0 && days <= 14) expiring14++;
        if (days >= 0 && days <= 30) expiring30++;
      }
      for (var i = 1; i < rows.length; i++) {
        if (!rows[i].createdAt.toUtc().isBefore(windowStart) &&
            (rows[i].status == 'active' || rows[i].status == 'renewed')) {
          renewed30++;
        }
      }
      if (current.endAt.toUtc().isBefore(nowUtc) &&
          current.endAt.toUtc().isAfter(windowStart) &&
          current.status != 'active' &&
          current.status != 'renewed') {
        lapsed30++;
      } else if (current.status == 'active' &&
          current.endAt.toUtc().isBefore(nowUtc) &&
          current.endAt.toUtc().isAfter(windowStart)) {
        lapsed30++;
      }
    }
    final denom = renewed30 + lapsed30;
    return RenewalAnalytics(
      expiring7: expiring7,
      expiring14: expiring14,
      expiring30: expiring30,
      renewed30: renewed30,
      lapsed30: lapsed30,
      hasEnoughData: memberships.length >= 3,
      renewalPercent: denom == 0 ? null : ((renewed30 / denom) * 100).round(),
      explanation: denom == 0
          ? 'Not enough completed renewals or lapses in the last 30 days.'
          : 'Renewed $renewed30 and lapsed $lapsed30 in the last 30 days.',
    );
  }

  Future<TrialAnalytics> trialAnalytics({
    required Workspace workspace,
    required DateTime nowUtc,
  }) async {
    final rows =
        await (_db.select(_db.trials)..where(
              (t) =>
                  t.organizationId.equals(workspace.organization.id) &
                  t.locationId.equals(workspace.location.id),
            ))
            .get();
    var active = 0, converted = 0, expired = 0;
    for (final row in rows) {
      if (row.convertedAt != null || row.status == 'converted') {
        converted++;
      } else if (row.endsAt.toUtc().isAfter(nowUtc) && row.status == 'active') {
        active++;
      } else {
        expired++;
      }
    }
    final eligible = converted + expired;
    return TrialAnalytics(
      active: active,
      eligible: eligible,
      converted: converted,
      expired: expired,
      conversionPercent: eligible == 0
          ? null
          : ((converted / eligible) * 100).round(),
      explanation: eligible == 0
          ? 'No eligible trials yet. Start and complete trials to see conversion.'
          : 'Converted $converted of $eligible eligible trials.',
    );
  }

  Future<CancellationAnalytics> cancellationAnalytics({
    required Workspace workspace,
  }) async {
    final rows =
        await (_db.select(_db.cancellationEvents)..where(
              (t) =>
                  t.organizationId.equals(workspace.organization.id) &
                  t.locationId.equals(workspace.location.id),
            ))
            .get();
    final byReason = <String, int>{};
    for (final row in rows) {
      final label =
          CancellationReasons.defaults[row.reasonCode] ?? row.reasonCode;
      byReason[label] = (byReason[label] ?? 0) + 1;
    }
    return CancellationAnalytics(
      total: rows.length,
      byReason: byReason,
      explanation: rows.isEmpty
          ? 'No cancellations recorded.'
          : '${rows.length} cancellation(s) recorded.',
    );
  }

  Future<List<TimelineItem>> timeline({
    required Workspace workspace,
    required String memberId,
  }) async {
    final items = <TimelineItem>[];
    final events = await _attendance.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      memberId: memberId,
    );
    for (final event in events) {
      items.add(
        TimelineItem(
          at: event.occurredAtLocal,
          type: 'visit',
          title: 'Visit',
          detail: event.eventType,
        ),
      );
    }
    final memberships = await _memberships.list(
      organizationId: workspace.organization.id,
      memberId: memberId,
      locationId: workspace.location.id,
    );
    for (final row in memberships) {
      items.add(
        TimelineItem(
          at: row.startAt,
          type: 'membership',
          title: 'Membership ${row.status}',
          detail:
              '${row.startAt.toIso8601String().split('T').first} → ${row.endAt.toIso8601String().split('T').first}',
        ),
      );
    }
    final trials =
        await (_db.select(_db.trials)..where(
              (t) =>
                  t.organizationId.equals(workspace.organization.id) &
                  t.memberId.equals(memberId),
            ))
            .get();
    for (final row in trials) {
      items.add(
        TimelineItem(
          at: row.startedAt,
          type: 'trial',
          title: 'Trial ${row.status}',
          detail: row.convertedAt == null
              ? 'Ends ${row.endsAt.toIso8601String().split('T').first}'
              : 'Converted',
        ),
      );
    }
    final cancels =
        await (_db.select(_db.cancellationEvents)..where(
              (t) =>
                  t.organizationId.equals(workspace.organization.id) &
                  t.memberId.equals(memberId),
            ))
            .get();
    for (final row in cancels) {
      items.add(
        TimelineItem(
          at: row.occurredAt,
          type: 'cancellation',
          title: 'Cancelled',
          detail:
              CancellationReasons.defaults[row.reasonCode] ?? row.reasonCode,
        ),
      );
    }
    items.sort((a, b) => b.at.compareTo(a.at));
    return items;
  }

  Future<Trial> startTrial({
    required Workspace workspace,
    required String memberId,
    int? days,
  }) async {
    final member = await _members.get(
      organizationId: workspace.organization.id,
      id: memberId,
    );
    if (member == null) {
      throw AppException(
        code: AppErrorCodes.memberNotFound,
        message: 'Member was not found.',
      );
    }
    final existing =
        await (_db.select(_db.trials)..where(
              (t) =>
                  t.memberId.equals(memberId) &
                  t.status.equals('active') &
                  t.organizationId.equals(workspace.organization.id),
            ))
            .get();
    if (existing.isNotEmpty) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'This member already has an active trial.',
      );
    }
    final now = DateTime.now().toUtc();
    final length = days ?? workspace.settings.trialDefaultDays;
    final id = _uuid.v4();
    await _db
        .into(_db.trials)
        .insert(
          TrialsCompanion.insert(
            id: id,
            organizationId: workspace.organization.id,
            locationId: workspace.location.id,
            memberId: memberId,
            startedAt: now,
            endsAt: now.add(Duration(days: length)),
            status: 'active',
            source: const Value('owner'),
          ),
        );
    return (await (_db.select(
      _db.trials,
    )..where((t) => t.id.equals(id))).getSingle());
  }

  Future<Trial> convertTrial({
    required Workspace workspace,
    required String trialId,
  }) async {
    final trial =
        await (_db.select(_db.trials)..where(
              (t) =>
                  t.id.equals(trialId) &
                  t.organizationId.equals(workspace.organization.id),
            ))
            .getSingleOrNull();
    if (trial == null) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Trial was not found.',
      );
    }
    final now = DateTime.now().toUtc();
    await (_db.update(_db.trials)..where((t) => t.id.equals(trialId))).write(
      TrialsCompanion(
        status: const Value('converted'),
        convertedAt: Value(now),
      ),
    );
    await _memberships.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      memberId: trial.memberId,
      startAt: now,
      endAt: now.add(const Duration(days: 30)),
      status: 'active',
      currencyCode: workspace.location.currencyCode,
    );
    return (await (_db.select(
      _db.trials,
    )..where((t) => t.id.equals(trialId))).getSingle());
  }

  Future<CancellationEvent> recordCancellation({
    required Workspace workspace,
    required String memberId,
    required String reasonCode,
    String? reasonText,
  }) async {
    if (!CancellationReasons.defaults.containsKey(reasonCode)) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Choose a cancellation reason.',
      );
    }
    final member = await _members.get(
      organizationId: workspace.organization.id,
      id: memberId,
    );
    if (member == null) {
      throw AppException(
        code: AppErrorCodes.memberNotFound,
        message: 'Member was not found.',
      );
    }
    final now = DateTime.now().toUtc();
    final memberships = await _memberships.list(
      organizationId: workspace.organization.id,
      memberId: memberId,
      locationId: workspace.location.id,
    );
    final current = _latestMembership(memberships);
    if (current != null && current.status == 'active') {
      await _memberships.update(
        organizationId: workspace.organization.id,
        id: current.id,
        status: 'cancelled',
      );
    }
    final id = _uuid.v4();
    await _db
        .into(_db.cancellationEvents)
        .insert(
          CancellationEventsCompanion.insert(
            id: id,
            organizationId: workspace.organization.id,
            locationId: workspace.location.id,
            memberId: memberId,
            occurredAt: now,
            reasonCode: reasonCode,
            reasonText: Value(reasonText),
            source: const Value('owner'),
            createdAt: now,
          ),
        );
    return (await (_db.select(
      _db.cancellationEvents,
    )..where((t) => t.id.equals(id))).getSingle());
  }

  Future<Membership> renewExplicit({
    required Workspace workspace,
    required Membership current,
  }) async {
    await _memberships.update(
      organizationId: workspace.organization.id,
      id: current.id,
      status: 'renewed',
    );
    final now = DateTime.now().toUtc();
    return _memberships.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      memberId: current.memberId,
      startAt: now,
      endAt: now.add(const Duration(days: 30)),
      status: 'active',
      currencyCode: workspace.location.currencyCode,
    );
  }

  Future<Trial?> activeTrial({
    required Workspace workspace,
    required String memberId,
  }) {
    return (_db.select(_db.trials)..where(
          (t) =>
              t.organizationId.equals(workspace.organization.id) &
              t.memberId.equals(memberId) &
              t.status.equals('active'),
        ))
        .getSingleOrNull();
  }

  Membership? _latestMembership(List<Membership> rows) {
    if (rows.isEmpty) return null;
    final copy = [...rows]..sort((a, b) => b.endAt.compareTo(a.endAt));
    return copy.first;
  }

  int _inactivityPoints(int? days, LocationSetting settings) {
    if (days == null) return 0;
    if (days >= settings.inactivityCriticalDays) return 100;
    if (days >= settings.inactivityHighRiskDays) return 80;
    if (days >= settings.inactivityFollowUpDays) return 60;
    if (days >= settings.inactivityMonitorDays) return 35;
    return 10;
  }

  int _expiryPoints(int? days) {
    if (days == null) return 0;
    if (days < 0) return 100;
    if (days > 30) return 0;
    return (((30 - days) / 30) * 100).round();
  }

  int _engagementPoints(List<AttendanceEvent> events, DateTime nowUtc) {
    final recent = events
        .where(
          (e) => e.occurredAtUtc.isAfter(
            nowUtc.subtract(const Duration(days: 30)),
          ),
        )
        .length;
    if (recent >= 8) return 5;
    if (recent >= 4) return 25;
    if (recent >= 2) return 50;
    if (recent == 1) return 75;
    return 90;
  }

  int _historyPoints(
    List<Membership> memberships,
    List<FollowUp> followUps,
    DateTime nowUtc,
  ) {
    var points = 0;
    if (memberships.any(
      (m) => m.status == 'cancelled' || m.status == 'expired',
    )) {
      points += 50;
    }
    if (followUps.any((f) => f.type == 'inactivity')) points += 30;
    if (memberships.length >= 2) points += 10;
    return points.clamp(0, 100);
  }

  Future<void> _persistRisk(
    Workspace workspace,
    Member member,
    MemberRisk risk,
  ) async {
    await (_db.delete(_db.riskScores)..where(
          (t) =>
              t.organizationId.equals(workspace.organization.id) &
              t.memberId.equals(member.id),
        ))
        .go();
    await _db
        .into(_db.riskScores)
        .insert(
          RiskScoresCompanion.insert(
            id: _uuid.v4(),
            organizationId: workspace.organization.id,
            locationId: workspace.location.id,
            memberId: member.id,
            score: risk.score,
            riskLevel: risk.level,
            confidence: risk.confidence,
            calculatedAt: DateTime.now().toUtc(),
            factorsJson: Value(
              jsonEncode(
                risk.factors
                    .map(
                      (f) => {
                        'key': f.key,
                        'label': f.label,
                        'points': f.points,
                        'used': f.used,
                      },
                    )
                    .toList(),
              ),
            ),
          ),
        );
  }

  Future<void> _syncRiskFollowUp(
    Workspace workspace,
    Member member,
    MemberRisk risk,
  ) async {
    if (!risk.enoughData) return;
    if (risk.level != 'high' && risk.level != 'critical') return;
    final existing = await _followUps.openFor(
      organizationId: workspace.organization.id,
      memberId: member.id,
      type: 'risk',
    );
    if (existing != null) {
      await (_db.update(
        _db.followUps,
      )..where((t) => t.id.equals(existing.id))).write(
        FollowUpsCompanion(
          priority: Value(followUpPriorityFor(risk)),
          reason: Value(
            '${member.firstName} risk ${risk.score} (${risk.level}).',
          ),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return;
    }
    await _followUps.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      memberId: member.id,
      type: 'risk',
      reason: '${member.firstName} risk ${risk.score} (${risk.level}).',
      priority: followUpPriorityFor(risk),
      dueAt: DateTime.now().toUtc(),
    );
  }
}
