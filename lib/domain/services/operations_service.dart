import 'package:drift/drift.dart';

import '../../core/time/location_clock.dart';
import '../../data/db/app_database.dart';
import '../../data/repositories/local_attendance_repository.dart';
import '../../data/repositories/local_follow_up_repository.dart';
import '../../data/repositories/local_location_repository.dart';
import '../../data/repositories/local_member_repository.dart';
import '../attendance/attendance_source.dart' hide AttendanceEvent;
import '../models/workspace.dart';

class PeakSlot {
  const PeakSlot({
    required this.weekday,
    required this.hour,
    required this.visits,
    required this.average,
    required this.max,
    required this.p90,
    required this.rollingAverage,
    required this.label,
  });

  final int weekday;
  final int hour;
  final int visits;
  final double average;
  final int max;
  final int p90;
  final double rollingAverage;
  final String label;
}

class PeakWindow {
  const PeakWindow({
    required this.weekday,
    required this.startHour,
    required this.endHour,
    required this.visits,
    required this.label,
  });

  final int weekday;
  final int startHour;
  final int endHour;
  final int visits;
  final String label;
}

class CapacitySnapshot {
  const CapacitySnapshot({
    required this.reliable,
    required this.hasCapacity,
    required this.explanation,
    this.capacity,
    this.threshold,
    this.peakVisits,
    this.utilizationPercent,
  });

  final bool reliable;
  final bool hasCapacity;
  final int? capacity;
  final int? threshold;
  final int? peakVisits;
  final int? utilizationPercent;
  final String explanation;
}

class LocationOpsRow {
  const LocationOpsRow({
    required this.locationId,
    required this.name,
    required this.reliable,
    required this.unmatched,
    required this.activeMembers,
    required this.explanation,
    this.visits,
    this.uniqueVisitors,
  });

  final String locationId;
  final String name;
  final bool reliable;
  final int? visits;
  final int? uniqueVisitors;
  final int unmatched;
  final int activeMembers;
  final String explanation;
}

class ReconciliationReport {
  const ReconciliationReport({
    required this.expected,
    required this.actual,
    required this.unmatched,
    required this.difference,
    required this.explanation,
  });

  final int expected;
  final int actual;
  final int unmatched;
  final int difference;
  final String explanation;
}

class DailyOpsReport {
  const DailyOpsReport({
    required this.reliable,
    required this.openFollowUps,
    required this.highRisk,
    required this.expiring7,
    required this.explanation,
    this.visits,
    this.uniqueVisitors,
    this.peakLabel,
  });

  final bool reliable;
  final int? visits;
  final int? uniqueVisitors;
  final int openFollowUps;
  final int highRisk;
  final int expiring7;
  final String? peakLabel;
  final String explanation;
}

class OperationsSnapshot {
  const OperationsSnapshot({
    required this.peakHours,
    required this.peakWindows,
    required this.capacity,
    required this.locations,
    required this.daily,
    required this.explanation,
  });

  final List<PeakSlot> peakHours;
  final List<PeakWindow> peakWindows;
  final CapacitySnapshot capacity;
  final List<LocationOpsRow> locations;
  final DailyOpsReport daily;
  final String explanation;
}

class OpsNotifyKeys {
  static const dailySummary = 'daily_summary';
  static const importStale = 'import_stale';
  static const highRisk = 'high_risk';
  static const expiryQueue = 'expiry_queue';
  static const feeReminders = 'fee_reminders';
  static const all = [
    dailySummary,
    importStale,
    highRisk,
    expiryQueue,
    feeReminders,
  ];
}

/// On-device operations intelligence. Missing attendance is never treated as zero.
class OperationsService {
  OperationsService({
    required AppDatabase db,
    required LocalAttendanceRepository attendance,
    required LocalLocationRepository locations,
    required LocalMemberRepository members,
    required LocalFollowUpRepository followUps,
    LocationClock? clock,
  }) : _db = db,
       _attendance = attendance,
       _locations = locations,
       _members = members,
       _followUps = followUps,
       _clock = clock ?? const LocationClock();

  final AppDatabase _db;
  final LocalAttendanceRepository _attendance;
  final LocalLocationRepository _locations;
  final LocalMemberRepository _members;
  final LocalFollowUpRepository _followUps;
  final LocationClock _clock;

  static const _ownerUserId = 'local-owner';
  static const _activeLocationKey = 'active_location_id';
  static const _lastSummaryKey = 'last_daily_summary_date';

  Future<OperationsSnapshot> snapshot({
    required Workspace workspace,
    required AttendanceSourceHealth importHealth,
    DateTime? nowUtc,
    int lookbackDays = 28,
  }) async {
    final now = nowUtc ?? DateTime.now().toUtc();
    final events = importHealth.isDataReliable
        ? await _attendance.list(
            organizationId: workspace.organization.id,
            locationId: workspace.location.id,
            sinceUtc: now.subtract(Duration(days: lookbackDays)),
          )
        : <AttendanceEvent>[];
    final peaks = peakAnalysis(
      events: events,
      workspace: workspace,
      nowUtc: now,
      importReliable: importHealth.isDataReliable,
    );
    return OperationsSnapshot(
      peakHours: peaks.slots,
      peakWindows: peaks.windows,
      capacity: capacityUtilization(
        events: events,
        workspace: workspace,
        nowUtc: now,
        importReliable: importHealth.isDataReliable,
      ),
      locations: await compareLocations(
        workspace: workspace,
        nowUtc: now,
        importHealth: importHealth,
      ),
      daily: await dailyReport(
        workspace: workspace,
        importHealth: importHealth,
        nowUtc: now,
        peakSlots: peaks.slots,
      ),
      explanation: importHealth.isDataReliable
          ? 'On-device operations from the last $lookbackDays days. Not an AI prediction.'
          : 'Attendance is stale or unavailable, so peak and utilization counts are not shown as zero.',
    );
  }

  ({List<PeakSlot> slots, List<PeakWindow> windows}) peakAnalysis({
    required List<AttendanceEvent> events,
    required Workspace workspace,
    required DateTime nowUtc,
    required bool importReliable,
  }) {
    if (!importReliable || events.isEmpty) {
      return (slots: const <PeakSlot>[], windows: const <PeakWindow>[]);
    }
    final tz = workspace.location.timezone;
    final dailyHour = <String, int>{};
    final hourDays = <int, List<int>>{};
    final rollingHourDays = <int, List<int>>{};
    final weekdayHour = <String, List<int>>{};
    final rollingStart = nowUtc.subtract(const Duration(days: 7));

    for (final event in events) {
      final local = _clock.toLocation(event.occurredAtUtc, tz);
      final dateKey =
          '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
      final bucket = '$dateKey|${local.hour}';
      dailyHour[bucket] = (dailyHour[bucket] ?? 0) + 1;
    }

    for (final entry in dailyHour.entries) {
      final parts = entry.key.split('|');
      final date = DateTime.parse(parts[0]);
      final hour = int.parse(parts[1]);
      final weekday = date.weekday;
      hourDays.putIfAbsent(hour, () => []).add(entry.value);
      weekdayHour.putIfAbsent('$weekday|$hour', () => []).add(entry.value);
      final asUtc = DateTime.utc(date.year, date.month, date.day);
      if (!asUtc.isBefore(
        DateTime.utc(rollingStart.year, rollingStart.month, rollingStart.day),
      )) {
        rollingHourDays.putIfAbsent(hour, () => []).add(entry.value);
      }
    }

    final capacity = workspace.location.capacity;
    final threshold = workspace.settings.peakHighAttendance;
    final slots = <PeakSlot>[];
    for (final entry in weekdayHour.entries) {
      final parts = entry.key.split('|');
      final weekday = int.parse(parts[0]);
      final hour = int.parse(parts[1]);
      final values = entry.value;
      final hourValues = hourDays[hour] ?? values;
      final rolling = rollingHourDays[hour] ?? const <int>[];
      final visits = values.fold<int>(0, (sum, v) => sum + v);
      slots.add(
        PeakSlot(
          weekday: weekday,
          hour: hour,
          visits: visits,
          average: _average(values),
          max: values.reduce((a, b) => a > b ? a : b),
          p90: _percentile(hourValues, 90),
          rollingAverage: rolling.isEmpty
              ? _average(values)
              : _average(rolling),
          label: crowdLabel(
            visits: values.reduce((a, b) => a > b ? a : b),
            capacity: capacity,
            threshold: threshold,
          ),
        ),
      );
    }
    slots.sort((a, b) {
      final byVisits = b.visits.compareTo(a.visits);
      if (byVisits != 0) return byVisits;
      return a.hour.compareTo(b.hour);
    });

    final averages = slots.map((s) => s.average).toList()..sort();
    final cutoff = averages.isEmpty
        ? 0.0
        : averages[(averages.length * 0.75).floor().clamp(
            0,
            averages.length - 1,
          )];
    final windows = <PeakWindow>[];
    for (var weekday = 1; weekday <= 7; weekday++) {
      final daySlots = slots.where((s) => s.weekday == weekday).toList()
        ..sort((a, b) => a.hour.compareTo(b.hour));
      var start = -1;
      var visits = 0;
      String label = 'High attendance';
      for (final slot in daySlots) {
        final hot = slot.average >= cutoff && cutoff > 0;
        if (hot) {
          if (start < 0) {
            start = slot.hour;
            visits = 0;
            label = slot.label;
          }
          visits += slot.visits;
          if (slot.label == 'Crowded') label = 'Crowded';
        } else if (start >= 0) {
          windows.add(
            PeakWindow(
              weekday: weekday,
              startHour: start,
              endHour: slot.hour,
              visits: visits,
              label: label,
            ),
          );
          start = -1;
        }
      }
      if (start >= 0 && daySlots.isNotEmpty) {
        windows.add(
          PeakWindow(
            weekday: weekday,
            startHour: start,
            endHour: daySlots.last.hour + 1,
            visits: visits,
            label: label,
          ),
        );
      }
    }
    windows.sort((a, b) => b.visits.compareTo(a.visits));
    return (slots: slots, windows: windows);
  }

  CapacitySnapshot capacityUtilization({
    required List<AttendanceEvent> events,
    required Workspace workspace,
    required DateTime nowUtc,
    required bool importReliable,
  }) {
    final capacity = workspace.location.capacity;
    final threshold = workspace.settings.peakHighAttendance;
    if (!importReliable) {
      return CapacitySnapshot(
        reliable: false,
        hasCapacity: capacity != null,
        capacity: capacity,
        threshold: threshold,
        explanation:
            'Attendance is stale or unavailable, so utilization is not shown as zero.',
      );
    }
    if (events.isEmpty) {
      return CapacitySnapshot(
        reliable: true,
        hasCapacity: capacity != null,
        capacity: capacity,
        threshold: threshold,
        explanation: 'Not enough attendance history to judge utilization.',
      );
    }
    final tz = workspace.location.timezone;
    final dailyHour = <String, int>{};
    final recent = nowUtc.subtract(const Duration(days: 7));
    for (final event in events) {
      if (event.occurredAtUtc.isBefore(recent)) continue;
      final local = _clock.toLocation(event.occurredAtUtc, tz);
      final key = '${local.year}-${local.month}-${local.day}|${local.hour}';
      dailyHour[key] = (dailyHour[key] ?? 0) + 1;
    }
    if (dailyHour.isEmpty) {
      return CapacitySnapshot(
        reliable: true,
        hasCapacity: capacity != null,
        capacity: capacity,
        threshold: threshold,
        explanation: 'No visits in the last 7 days to judge utilization.',
      );
    }
    final peak = dailyHour.values.reduce((a, b) => a > b ? a : b);
    if (capacity == null && threshold == null) {
      return CapacitySnapshot(
        reliable: true,
        hasCapacity: false,
        peakVisits: peak,
        explanation:
            'Peak $peak visits/hour. Set gym capacity or a high-attendance threshold to judge crowding.',
      );
    }
    final denom = capacity ?? threshold!;
    final percent = ((peak / denom) * 100).round();
    return CapacitySnapshot(
      reliable: true,
      hasCapacity: capacity != null,
      capacity: capacity,
      threshold: threshold,
      peakVisits: peak,
      utilizationPercent: percent,
      explanation: capacity != null
          ? 'Peak $peak of $capacity capacity ($percent%). ${crowdLabel(visits: peak, capacity: capacity, threshold: threshold)}.'
          : 'Peak $peak vs high-attendance threshold $threshold. ${crowdLabel(visits: peak, capacity: capacity, threshold: threshold)}.',
    );
  }

  String crowdLabel({required int visits, int? capacity, int? threshold}) {
    if ((capacity != null && visits >= capacity) ||
        (threshold != null && visits >= threshold)) {
      return 'Crowded';
    }
    return 'High attendance';
  }

  Future<List<LocationOpsRow>> compareLocations({
    required Workspace workspace,
    required DateTime nowUtc,
    required AttendanceSourceHealth importHealth,
  }) async {
    final locations = await _locations.list(workspace.organization.id);
    final rows = <LocationOpsRow>[];
    for (final location in locations) {
      final source = await _attendance.sourceFor(
        organizationId: workspace.organization.id,
        locationId: location.id,
      );
      final reliable = location.id == workspace.location.id
          ? importHealth.isDataReliable
          : source?.lastSuccessAt != null && source?.status != 'error';
      final members = await _members.list(
        organizationId: workspace.organization.id,
        locationId: location.id,
      );
      final unmatched = await _attendance.unmatchedCount(
        organizationId: workspace.organization.id,
        locationId: location.id,
      );
      if (!reliable) {
        rows.add(
          LocationOpsRow(
            locationId: location.id,
            name: location.name,
            reliable: false,
            unmatched: unmatched,
            activeMembers: members.where((m) => m.status == 'active').length,
            explanation:
                'Attendance is stale or unavailable at this location. Counts are not shown as zero.',
          ),
        );
        continue;
      }
      final events = await _attendance.list(
        organizationId: workspace.organization.id,
        locationId: location.id,
        sinceUtc: nowUtc.subtract(const Duration(days: 7)),
      );
      rows.add(
        LocationOpsRow(
          locationId: location.id,
          name: location.name,
          reliable: true,
          visits: events.length,
          uniqueVisitors: events.map((e) => e.externalMemberId).toSet().length,
          unmatched: unmatched,
          activeMembers: members.where((m) => m.status == 'active').length,
          explanation: '${events.length} visits in the last 7 days.',
        ),
      );
    }
    return rows;
  }

  Future<DailyOpsReport> dailyReport({
    required Workspace workspace,
    required AttendanceSourceHealth importHealth,
    required DateTime nowUtc,
    List<PeakSlot> peakSlots = const [],
  }) async {
    final open = await _followUps.listOpen(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final risks =
        await (_db.select(_db.riskScores)..where(
              (t) =>
                  t.organizationId.equals(workspace.organization.id) &
                  t.locationId.equals(workspace.location.id),
            ))
            .get();
    final highRisk = risks
        .where((r) => r.riskLevel == 'high' || r.riskLevel == 'critical')
        .length;
    final memberships =
        await (_db.select(_db.memberships)..where(
              (t) =>
                  t.organizationId.equals(workspace.organization.id) &
                  t.locationId.equals(workspace.location.id) &
                  t.status.equals('active'),
            ))
            .get();
    final expiring7 = memberships.where((m) {
      final days = m.endAt.toUtc().difference(nowUtc).inDays;
      return days >= 0 && days <= 7;
    }).length;
    if (!importHealth.isDataReliable) {
      return DailyOpsReport(
        reliable: false,
        openFollowUps: open.length,
        highRisk: highRisk,
        expiring7: expiring7,
        explanation:
            'Attendance is stale or unavailable, so today\'s visit count is not shown as zero.',
      );
    }
    final start = _clock.startOfDayUtc(nowUtc, workspace.location.timezone);
    final events = await _attendance.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      sinceUtc: start,
    );
    final top = peakSlots.isEmpty ? null : peakSlots.first;
    final peakLabel = top == null
        ? null
        : '${_weekdayName(top.weekday)} ${top.hour.toString().padLeft(2, '0')}:00 · ${top.label}';
    return DailyOpsReport(
      reliable: true,
      visits: events.length,
      uniqueVisitors: events.map((e) => e.externalMemberId).toSet().length,
      openFollowUps: open.length,
      highRisk: highRisk,
      expiring7: expiring7,
      peakLabel: peakLabel,
      explanation:
          '${events.length} visits today · ${open.length} open actions · $highRisk high-risk · $expiring7 expiring in 7 days.',
    );
  }

  ReconciliationReport reconcile({
    required List<AttendanceEvent> events,
    required DateTime fromUtc,
    required DateTime toUtc,
    required int expected,
  }) {
    final inRange = events.where((e) {
      final at = e.occurredAtUtc.toUtc();
      return !at.isBefore(fromUtc) && !at.isAfter(toUtc);
    }).toList();
    final unmatched = inRange.where((e) => e.matchStatus == 'unmatched').length;
    final actual = inRange.length;
    final difference = actual - expected;
    final explanation = difference == 0
        ? 'GymPulse count matches the source count for this range.'
        : difference < 0
        ? 'GymPulse has ${-difference} fewer event(s) than the source count. Re-export and import the missing days.'
        : 'GymPulse has $difference extra event(s). Check for duplicate source files.';
    return ReconciliationReport(
      expected: expected,
      actual: actual,
      unmatched: unmatched,
      difference: difference,
      explanation: explanation,
    );
  }

  Future<Map<String, bool>> notificationPrefs(String organizationId) async {
    final rows =
        await (_db.select(_db.notificationPreferences)..where(
              (t) =>
                  t.organizationId.equals(organizationId) &
                  t.userId.equals(_ownerUserId),
            ))
            .get();
    final map = {for (final key in OpsNotifyKeys.all) key: true};
    for (final row in rows) {
      map[row.key] = row.enabled;
    }
    return map;
  }

  Future<void> setNotificationPref({
    required String organizationId,
    required String key,
    required bool enabled,
  }) async {
    await _db
        .into(_db.notificationPreferences)
        .insertOnConflictUpdate(
          NotificationPreferencesCompanion.insert(
            organizationId: organizationId,
            userId: _ownerUserId,
            key: key,
            enabled: Value(enabled),
            updatedAt: DateTime.now().toUtc(),
          ),
        );
  }

  Future<String?> consumeDailySummaryDate({
    required Workspace workspace,
    required DateTime nowUtc,
  }) async {
    final local = _clock.toLocation(nowUtc, workspace.location.timezone);
    final today =
        '${local.year.toString().padLeft(4, '0')}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
    final existing = await (_db.select(
      _db.appMetaEntries,
    )..where((t) => t.key.equals(_lastSummaryKey))).getSingleOrNull();
    if (existing?.value == today) return null;
    await _db
        .into(_db.appMetaEntries)
        .insertOnConflictUpdate(
          AppMetaEntriesCompanion.insert(
            key: _lastSummaryKey,
            value: today,
            updatedAt: DateTime.now().toUtc(),
          ),
        );
    return today;
  }

  Future<String?> activeLocationId() async {
    final row = await (_db.select(
      _db.appMetaEntries,
    )..where((t) => t.key.equals(_activeLocationKey))).getSingleOrNull();
    return row?.value;
  }

  Future<void> setActiveLocationId(String locationId) async {
    await _db
        .into(_db.appMetaEntries)
        .insertOnConflictUpdate(
          AppMetaEntriesCompanion.insert(
            key: _activeLocationKey,
            value: locationId,
            updatedAt: DateTime.now().toUtc(),
          ),
        );
  }

  static String weekdayName(int weekday) => _weekdayName(weekday);

  static String _weekdayName(int weekday) {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (weekday < 1 || weekday > 7) return '?';
    return names[weekday - 1];
  }

  double _average(List<int> values) {
    if (values.isEmpty) return 0;
    return values.fold<int>(0, (sum, v) => sum + v) / values.length;
  }

  int _percentile(List<int> values, int percentile) {
    if (values.isEmpty) return 0;
    final sorted = [...values]..sort();
    final index = ((percentile / 100) * (sorted.length - 1)).round().clamp(
      0,
      sorted.length - 1,
    );
    return sorted[index];
  }
}
