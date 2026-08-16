import 'package:flutter_test/flutter_test.dart';
import 'package:mr_gym/core/errors/app_exception.dart';
import 'package:mr_gym/core/time/location_clock.dart';
import 'package:mr_gym/data/db/app_database.dart';
import 'package:mr_gym/data/repositories/local_attendance_repository.dart';
import 'package:mr_gym/data/repositories/local_follow_up_repository.dart';
import 'package:mr_gym/data/repositories/local_location_repository.dart';
import 'package:mr_gym/data/repositories/local_member_repository.dart';
import 'package:mr_gym/data/repositories/local_membership_repository.dart';
import 'package:mr_gym/data/repositories/local_organization_repository.dart';
import 'package:mr_gym/domain/attendance/attendance_source.dart';
import 'package:mr_gym/domain/services/attendance_ingest_service.dart';
import 'package:mr_gym/domain/services/gym_ops_service.dart';
import 'package:mr_gym/domain/services/intelligence_service.dart';
import 'package:mr_gym/domain/services/workspace_service.dart';
import 'package:timezone/data/latest.dart' as tzdata;

void main() {
  tzdata.initializeTimeZones();

  late AppDatabase db;
  late WorkspaceService workspaceService;
  late AttendanceIngestService ingest;
  late GymOpsService ops;
  late IntelligenceService intelligence;
  late LocalMemberRepository members;
  late LocalMembershipRepository memberships;

  setUp(() {
    db = AppDatabase.memory();
    members = LocalMemberRepository(db: db);
    memberships = LocalMembershipRepository(db: db);
    final attendance = LocalAttendanceRepository(db: db);
    workspaceService = WorkspaceService(
      db: db,
      organizations: LocalOrganizationRepository(db: db),
      locations: LocalLocationRepository(db: db),
    );
    ingest = AttendanceIngestService(attendance: attendance);
    ops = GymOpsService(
      db: db,
      members: members,
      memberships: memberships,
      attendance: attendance,
      followUps: LocalFollowUpRepository(db: db),
      clock: const LocationClock(),
    );
    intelligence = IntelligenceService(
      db: db,
      members: members,
      memberships: memberships,
      attendance: attendance,
      followUps: LocalFollowUpRepository(db: db),
      clock: const LocationClock(),
    );
  });

  tearDown(() => db.close());

  test('org setup stores country timezone and currency', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Mr. Gym',
      locationName: 'Main',
      countryCode: 'PK',
      timezone: 'Asia/Karachi',
      currencyCode: 'PKR',
    );
    expect(workspace.organization.countryCode, 'PK');
    expect(workspace.location.timezone, 'Asia/Karachi');
    expect(workspace.location.currencyCode, 'PKR');
  });

  test('in-app attendance makes health reliable', () async {
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
      firstName: 'Ada',
      phone: '03001234567',
    );
    await ops.markAttendance(
      workspace: workspace,
      memberId: member.id,
      nowUtc: DateTime.utc(2026, 8, 1, 10),
    );
    final health = await ingest.importHealth(workspace);
    expect(health.isDataReliable, isTrue);
  });

  test('missing attendance source is not treated as reliable zero', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Mr. Gym',
      locationName: 'Main',
      countryCode: 'US',
      timezone: 'UTC',
      currencyCode: 'USD',
    );
    final health = await ingest.importHealth(workspace);
    expect(health.status, AttendanceSourceHealthStatus.unavailable);
    expect(health.isDataReliable, isFalse);
    final dash = await intelligence.dashboard(
      workspace: workspace,
      importHealth: health,
    );
    expect(dash.healthScore.hasEnoughData, isFalse);
    expect(dash.attendance.reliable, isFalse);
  });

  test('inactivity is not flagged when attendance is unavailable', () async {
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
      firstName: 'Ada',
      phone: '03001234567',
    );
    await memberships.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      memberId: member.id,
      startAt: DateTime.utc(2026, 1, 1),
      endAt: DateTime.utc(2026, 12, 31),
      status: 'active',
    );
    const health = AttendanceSourceHealth(
      status: AttendanceSourceHealthStatus.unavailable,
      message: 'offline',
    );
    final insights = await intelligence.memberInsights(
      workspace: workspace,
      importHealth: health,
    );
    expect(insights.single.inactivityLevel, InactivityLevel.none);
  });

  test(
    'expiry window and follow-up are created from membership dates',
    () async {
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
        firstName: 'Ada',
        phone: '03001234567',
      );
      await memberships.create(
        organizationId: workspace.organization.id,
        locationId: workspace.location.id,
        memberId: member.id,
        startAt: DateTime.now().toUtc().subtract(const Duration(days: 20)),
        endAt: DateTime.now().toUtc().add(const Duration(days: 5)),
        status: 'active',
      );
      const health = AttendanceSourceHealth(
        status: AttendanceSourceHealthStatus.ready,
      );
      final dash = await intelligence.dashboard(
        workspace: workspace,
        importHealth: health,
      );
      expect(dash.expiring, isNotEmpty);
      expect(dash.openFollowUps, greaterThan(0));
    },
  );

  test('invalid membership dates are rejected', () async {
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
      firstName: 'Ada',
      phone: '03001234567',
    );
    expect(
      () => memberships.create(
        organizationId: workspace.organization.id,
        locationId: workspace.location.id,
        memberId: member.id,
        startAt: DateTime.utc(2026, 2, 1),
        endAt: DateTime.utc(2026, 1, 1),
        status: 'active',
      ),
      throwsA(
        isA<AppException>().having(
          (e) => e.code,
          'code',
          AppErrorCodes.validationInvalidField,
        ),
      ),
    );
  });
}
