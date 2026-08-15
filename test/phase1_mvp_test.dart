import 'package:flutter_test/flutter_test.dart';
import 'package:gympulse/core/errors/app_exception.dart';
import 'package:gympulse/core/logging/app_logger.dart';
import 'package:gympulse/core/time/location_clock.dart';
import 'package:gympulse/data/db/app_database.dart';
import 'package:gympulse/data/repositories/local_attendance_repository.dart';
import 'package:gympulse/data/repositories/local_follow_up_repository.dart';
import 'package:gympulse/data/repositories/local_location_repository.dart';
import 'package:gympulse/data/repositories/local_member_repository.dart';
import 'package:gympulse/data/repositories/local_membership_repository.dart';
import 'package:gympulse/data/repositories/local_organization_repository.dart';
import 'package:gympulse/domain/attendance/attendance_source.dart';
import 'package:gympulse/domain/attendance/csv_import_adapter.dart';
import 'package:gympulse/domain/services/attendance_ingest_service.dart';
import 'package:gympulse/domain/services/intelligence_service.dart';
import 'package:gympulse/domain/services/workspace_service.dart';
import 'package:timezone/data/latest.dart' as tzdata;

void main() {
  tzdata.initializeTimeZones();

  late AppDatabase db;
  late WorkspaceService workspaceService;
  late AttendanceIngestService ingest;
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
    ingest = AttendanceIngestService(
      attendance: attendance,
      members: members,
      logger: AppLogger(sink: (_, __, {error, stackTrace}) {}),
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
      organizationName: 'Iron Hall',
      locationName: 'Downtown',
      countryCode: 'PK',
      timezone: 'Asia/Karachi',
      currencyCode: 'PKR',
    );
    expect(workspace.organization.countryCode, 'PK');
    expect(workspace.location.timezone, 'Asia/Karachi');
    expect(workspace.location.currencyCode, 'PKR');
  });

  test('CSV import matches members and keeps unmatched events', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Iron Hall',
      locationName: 'Downtown',
      countryCode: 'US',
      timezone: 'America/New_York',
      currencyCode: 'USD',
    );
    await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Ada',
      externalMemberId: 'M-100',
    );
    const csv = '''
external_event_id,external_member_id,occurred_at,event_type
e1,M-100,2026-08-01T10:00:00Z,check_in
e2,UNKNOWN,2026-08-01T11:00:00Z,check_in
e1,M-100,2026-08-01T10:00:00Z,check_in
''';
    final report = await ingest.importCsv(workspace: workspace, csv: csv);
    expect(report.created, 2);
    expect(report.skipped, 1);
    expect(report.unmatched, 1);
    final health = await ingest.importHealth(workspace);
    expect(health.isDataReliable, isTrue);
  });

  test('duplicate CSV re-import does not create extra visits', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Iron Hall',
      locationName: 'Downtown',
      countryCode: 'US',
      timezone: 'UTC',
      currencyCode: 'USD',
    );
    const csv =
        'external_event_id,external_member_id,occurred_at,event_type\ne1,M-1,2026-08-01T10:00:00Z,check_in\n';
    await ingest.importCsv(workspace: workspace, csv: csv);
    final second = await ingest.importCsv(workspace: workspace, csv: csv);
    expect(second.created, 0);
    expect(second.skipped, 1);
  });

  test('missing attendance source is not treated as reliable zero', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Iron Hall',
      locationName: 'Downtown',
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

  test('inactivity is not flagged when import is unavailable', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Iron Hall',
      locationName: 'Downtown',
      countryCode: 'US',
      timezone: 'UTC',
      currencyCode: 'USD',
    );
    final member = await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Ada',
    );
    await memberships.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      memberId: member.id,
      startAt: DateTime.utc(2026, 1, 1),
      endAt: DateTime.utc(2026, 12, 31),
      status: 'active',
    );
    final health = const AttendanceSourceHealth(
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
        organizationName: 'Iron Hall',
        locationName: 'Downtown',
        countryCode: 'US',
        timezone: 'UTC',
        currencyCode: 'USD',
      );
      final member = await members.create(
        organizationId: workspace.organization.id,
        locationId: workspace.location.id,
        firstName: 'Ada',
      );
      await memberships.create(
        organizationId: workspace.organization.id,
        locationId: workspace.location.id,
        memberId: member.id,
        startAt: DateTime.now().toUtc().subtract(const Duration(days: 20)),
        endAt: DateTime.now().toUtc().add(const Duration(days: 5)),
        status: 'active',
      );
      final health = const AttendanceSourceHealth(
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

  test('CSV adapter rejects files without required columns', () {
    expect(
      () => CsvImportAdapter().parse('name,date\nAda,2026-01-01\n'),
      throwsA(isA<FormatException>()),
    );
  });

  test('invalid membership dates are rejected', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Iron Hall',
      locationName: 'Downtown',
      countryCode: 'US',
      timezone: 'UTC',
      currencyCode: 'USD',
    );
    final member = await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Ada',
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
