import 'package:flutter_test/flutter_test.dart';
import 'package:mr_gym/data/db/app_database.dart';
import 'package:mr_gym/data/repositories/local_attendance_repository.dart';
import 'package:mr_gym/data/repositories/local_follow_up_repository.dart';
import 'package:mr_gym/data/repositories/local_location_repository.dart';
import 'package:mr_gym/data/repositories/local_member_repository.dart';
import 'package:mr_gym/data/repositories/local_membership_repository.dart';
import 'package:mr_gym/data/repositories/local_organization_repository.dart';
import 'package:mr_gym/domain/services/gym_ops_service.dart';
import 'package:mr_gym/domain/services/operations_service.dart';
import 'package:mr_gym/domain/services/workspace_service.dart';
import 'package:timezone/data/latest.dart' as tzdata;

void main() {
  tzdata.initializeTimeZones();

  late AppDatabase db;
  late WorkspaceService workspaceService;
  late GymOpsService ops;
  late OperationsService operations;
  late LocalMemberRepository members;
  late LocalLocationRepository locations;

  setUp(() {
    db = AppDatabase.memory();
    members = LocalMemberRepository(db: db);
    locations = LocalLocationRepository(db: db);
    final attendance = LocalAttendanceRepository(db: db);
    workspaceService = WorkspaceService(
      db: db,
      organizations: LocalOrganizationRepository(db: db),
      locations: locations,
    );
    ops = GymOpsService(
      db: db,
      members: members,
      memberships: LocalMembershipRepository(db: db),
      attendance: attendance,
      followUps: LocalFollowUpRepository(db: db),
    );
    operations = OperationsService(
      db: db,
      attendance: attendance,
      locations: locations,
      members: members,
      followUps: LocalFollowUpRepository(db: db),
    );
  });

  tearDown(() => db.close());

  test('unreliable attendance does not invent zero utilization', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Mr. Gym',
      locationName: 'Main',
      countryCode: 'US',
      timezone: 'UTC',
      currencyCode: 'USD',
      capacity: 40,
    );
    final capacity = operations.capacityUtilization(
      events: const [],
      workspace: workspace,
      nowUtc: DateTime.utc(2026, 8, 16),
      importReliable: false,
    );
    expect(capacity.reliable, isFalse);
    expect(capacity.utilizationPercent, isNull);
    expect(capacity.peakVisits, isNull);
    expect(capacity.explanation, contains('not shown as zero'));
  });

  test('crowded label requires capacity or a threshold', () {
    expect(
      operations.crowdLabel(visits: 40, capacity: null, threshold: null),
      'High attendance',
    );
    expect(
      operations.crowdLabel(visits: 40, capacity: 30, threshold: null),
      'Crowded',
    );
    expect(
      operations.crowdLabel(visits: 12, capacity: 30, threshold: 20),
      'High attendance',
    );
  });

  test('peak hours use location timezone and stay explainable', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Mr. Gym',
      locationName: 'Main',
      countryCode: 'PK',
      timezone: 'Asia/Karachi',
      currencyCode: 'PKR',
      capacity: 2,
    );
    final member = await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Sara',
      phone: '03001234567',
    );
    for (var i = 0; i < 3; i++) {
      await ops.markAttendance(
        workspace: workspace,
        memberId: member.id,
        nowUtc: DateTime.utc(2026, 8, 16, 13, 10 + i * 10),
        allowDuplicate: i > 0,
      );
    }
    final events = await LocalAttendanceRepository(db: db).list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final peaks = operations.peakAnalysis(
      events: events,
      workspace: workspace,
      nowUtc: DateTime.utc(2026, 8, 16, 20),
      importReliable: true,
    );
    expect(peaks.slots, isNotEmpty);
    expect(peaks.slots.first.hour, 18);
    expect(peaks.slots.first.label, 'Crowded');
  });

  test('reconciliation reports missing source events', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Mr. Gym',
      locationName: 'Main',
      countryCode: 'US',
      timezone: 'UTC',
      currencyCode: 'USD',
    );
    final member = await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Sara',
      phone: '03001234567',
    );
    await ops.markAttendance(
      workspace: workspace,
      memberId: member.id,
      nowUtc: DateTime.utc(2026, 8, 16, 10),
    );
    final events = await LocalAttendanceRepository(db: db).list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final report = operations.reconcile(
      events: events,
      fromUtc: DateTime.utc(2026, 8, 16),
      toUtc: DateTime.utc(2026, 8, 16, 23, 59),
      expected: 5,
    );
    expect(report.actual, 1);
    expect(report.difference, -4);
    expect(report.explanation, contains('fewer'));
  });

  test('daily summary date is consumed once', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Mr. Gym',
      locationName: 'Main',
      countryCode: 'US',
      timezone: 'UTC',
      currencyCode: 'USD',
    );
    final first = await operations.consumeDailySummaryDate(
      workspace: workspace,
      nowUtc: DateTime.utc(2026, 8, 16, 9),
    );
    final second = await operations.consumeDailySummaryDate(
      workspace: workspace,
      nowUtc: DateTime.utc(2026, 8, 16, 18),
    );
    expect(first, '2026-08-16');
    expect(second, isNull);
  });
}
