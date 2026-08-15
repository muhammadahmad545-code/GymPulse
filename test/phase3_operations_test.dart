import 'package:flutter_test/flutter_test.dart';
import 'package:gympulse/core/logging/app_logger.dart';
import 'package:gympulse/data/db/app_database.dart';
import 'package:gympulse/data/repositories/local_attendance_repository.dart';
import 'package:gympulse/data/repositories/local_follow_up_repository.dart';
import 'package:gympulse/data/repositories/local_location_repository.dart';
import 'package:gympulse/data/repositories/local_member_repository.dart';
import 'package:gympulse/domain/attendance/adapter_catalog.dart';
import 'package:gympulse/domain/attendance/json_import_adapter.dart';
import 'package:gympulse/domain/services/attendance_ingest_service.dart';
import 'package:gympulse/domain/services/operations_service.dart';
import 'package:gympulse/domain/services/workspace_service.dart';
import 'package:gympulse/data/repositories/local_organization_repository.dart';
import 'package:timezone/data/latest.dart' as tzdata;

void main() {
  tzdata.initializeTimeZones();

  late AppDatabase db;
  late WorkspaceService workspaceService;
  late AttendanceIngestService ingest;
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
    ingest = AttendanceIngestService(
      attendance: attendance,
      members: members,
      logger: AppLogger(sink: (_, __, {error, stackTrace}) {}),
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
      organizationName: 'Iron Hall',
      locationName: 'Downtown',
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
      organizationName: 'Iron Hall',
      locationName: 'Downtown',
      countryCode: 'PK',
      timezone: 'Asia/Karachi',
      currencyCode: 'PKR',
      capacity: 2,
    );
    await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Sara',
      externalMemberId: 'M-1',
    );
    const csv =
        'external_event_id,external_member_id,occurred_at,event_type\n'
        'e1,M-1,2026-08-16T13:10:00Z,check_in\n'
        'e2,M-1,2026-08-16T13:20:00Z,check_in\n'
        'e3,M-1,2026-08-16T13:30:00Z,check_in\n';
    await ingest.importCsv(workspace: workspace, csv: csv);
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

  test('locations do not mix organization data', () async {
    final first = await workspaceService.setup(
      organizationName: 'Iron Hall',
      locationName: 'Downtown',
      countryCode: 'PK',
      timezone: 'Asia/Karachi',
      currencyCode: 'PKR',
    );
    await members.create(
      organizationId: first.organization.id,
      locationId: first.location.id,
      firstName: 'Sara',
      externalMemberId: 'M-1',
    );
    await ingest.importCsv(
      workspace: first,
      csv:
          'external_event_id,external_member_id,occurred_at,event_type\ne1,M-1,2026-08-16T10:00:00Z,check_in\n',
    );
    final second = await workspaceService.addLocation(name: 'Gulberg');
    await members.create(
      organizationId: second.organization.id,
      locationId: second.location.id,
      firstName: 'Omar',
      externalMemberId: 'M-2',
    );
    final health = await ingest.importHealth(second);
    final rows = await operations.compareLocations(
      workspace: second,
      nowUtc: DateTime.utc(2026, 8, 16),
      importHealth: health,
    );
    expect(rows.length, 2);
    final gulberg = rows.firstWhere((r) => r.name == 'Gulberg');
    expect(gulberg.visits, isNull);
    expect(gulberg.explanation, contains('not shown as zero'));
  });

  test('reconciliation reports missing source events', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Iron Hall',
      locationName: 'Downtown',
      countryCode: 'US',
      timezone: 'UTC',
      currencyCode: 'USD',
    );
    await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Sara',
      externalMemberId: 'M-1',
    );
    await ingest.importCsv(
      workspace: workspace,
      csv:
          'external_event_id,external_member_id,occurred_at,event_type\ne1,M-1,2026-08-16T10:00:00Z,check_in\n',
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

  test('JSON adapter parses normalized events only', () {
    const raw = '''
{"events":[{"external_member_id":"M-1","occurred_at":"2026-08-16T18:00:00+05:00","event_type":"check_in","external_event_id":"j1"}]}
''';
    final events = JsonImportAdapter().parse(raw);
    expect(events, hasLength(1));
    expect(events.single.externalMemberId, 'M-1');
    expect(events.single.occurredAt.toUtc(), DateTime.utc(2026, 8, 16, 13));
  });

  test('pending vendor adapters stay disabled', () async {
    final adapter = const AdapterCatalog().pending('vendor-sdk');
    final health = await adapter.health();
    expect(health.status.toString(), contains('disabled'));
    expect(health.message, contains('official'));
  });

  test('daily summary date is consumed once', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Iron Hall',
      locationName: 'Downtown',
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
