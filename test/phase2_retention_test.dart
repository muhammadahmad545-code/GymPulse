import 'package:drift/drift.dart' hide isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:gympulse/core/logging/app_logger.dart';
import 'package:gympulse/data/db/app_database.dart';
import 'package:gympulse/data/repositories/local_attendance_repository.dart';
import 'package:gympulse/data/repositories/local_follow_up_repository.dart';
import 'package:gympulse/data/repositories/local_location_repository.dart';
import 'package:gympulse/data/repositories/local_member_repository.dart';
import 'package:gympulse/data/repositories/local_membership_repository.dart';
import 'package:gympulse/data/repositories/local_organization_repository.dart';
import 'package:gympulse/domain/services/attendance_ingest_service.dart';
import 'package:gympulse/domain/services/retention_service.dart';
import 'package:gympulse/domain/services/workspace_service.dart';
import 'package:timezone/data/latest.dart' as tzdata;

void main() {
  tzdata.initializeTimeZones();

  late AppDatabase db;
  late WorkspaceService workspaceService;
  late AttendanceIngestService ingest;
  late RetentionService retention;
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
    );
    retention = RetentionService(
      db: db,
      members: members,
      memberships: memberships,
      attendance: attendance,
      followUps: LocalFollowUpRepository(db: db),
    );
  });

  tearDown(() => db.close());

  test('unreliable attendance does not invent a decline of zero', () {
    final decline = retention.declineFor(
      memberEvents: const [],
      nowUtc: DateTime.utc(2026, 8, 15),
      importReliable: false,
    );
    expect(decline.hasEnoughData, isFalse);
    expect(decline.declinePercent, isNull);
  });

  test('personal decline compares recent weeks to baseline', () async {
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
      externalMemberId: 'M-1',
    );
    final rows = StringBuffer(
      'external_event_id,external_member_id,occurred_at,event_type\n',
    );
    var n = 0;
    for (var week = 10; week >= 3; week--) {
      for (var visit = 0; visit < 4; visit++) {
        n++;
        final day = DateTime.utc(
          2026,
          8,
          15,
        ).subtract(Duration(days: week * 7 - visit));
        rows.writeln('e$n,M-1,${day.toIso8601String()},check_in');
      }
    }
    rows.writeln('e-recent,M-1,2026-08-14T10:00:00Z,check_in');
    await ingest.importCsv(workspace: workspace, csv: rows.toString());
    final events = await LocalAttendanceRepository(
      db: db,
    ).list(organizationId: workspace.organization.id, memberId: member.id);
    final decline = retention.declineFor(
      memberEvents: events,
      nowUtc: DateTime.utc(2026, 8, 15),
      importReliable: true,
    );
    expect(decline.hasEnoughData, isTrue);
    expect(decline.declinePercent, greaterThan(40));
  });

  test('risk score is explainable and not treated as AI', () async {
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
      externalMemberId: 'M-2',
    );
    await memberships.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      memberId: member.id,
      startAt: DateTime.utc(2026, 7, 20),
      endAt: DateTime.utc(2026, 8, 20),
      status: 'active',
    );
    const csv =
        'external_event_id,external_member_id,occurred_at,event_type\ne1,M-2,2026-07-01T10:00:00Z,check_in\n';
    await ingest.importCsv(workspace: workspace, csv: csv);
    final events = await LocalAttendanceRepository(
      db: db,
    ).list(organizationId: workspace.organization.id, memberId: member.id);
    final risk = retention.scoreMember(
      member: member,
      memberships: await memberships.list(
        organizationId: workspace.organization.id,
        memberId: member.id,
      ),
      memberEvents: events,
      historyFollowUps: const [],
      weights: const RiskWeights(),
      settings: workspace.settings,
      nowUtc: DateTime.utc(2026, 8, 15),
      importReliable: true,
    );
    expect(risk.factors, isNotEmpty);
    expect(risk.explanation, contains('Not an AI'));
    expect(['low', 'moderate', 'high', 'critical'], contains(risk.level));
  });

  test('trial conversion uses eligible trials only', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Iron Hall',
      locationName: 'Downtown',
      countryCode: 'US',
      timezone: 'UTC',
      currencyCode: 'USD',
    );
    final a = await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Ada',
    );
    final b = await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Ben',
    );
    final trial = await retention.startTrial(
      workspace: workspace,
      memberId: a.id,
    );
    await retention.convertTrial(workspace: workspace, trialId: trial.id);
    await retention.startTrial(workspace: workspace, memberId: b.id);
    await (db.update(db.trials)..where((t) => t.memberId.equals(b.id))).write(
      TrialsCompanion(
        status: const Value('expired'),
        endsAt: Value(DateTime.utc(2026, 8, 1)),
      ),
    );
    final stats = await retention.trialAnalytics(
      workspace: workspace,
      nowUtc: DateTime.utc(2026, 8, 15),
    );
    expect(stats.eligible, 2);
    expect(stats.converted, 1);
    expect(stats.conversionPercent, 50);
  });

  test('cancellation analytics group by reason', () async {
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
      startAt: DateTime.utc(2026, 7, 1),
      endAt: DateTime.utc(2026, 8, 31),
      status: 'active',
    );
    await retention.recordCancellation(
      workspace: workspace,
      memberId: member.id,
      reasonCode: 'price',
    );
    final stats = await retention.cancellationAnalytics(workspace: workspace);
    expect(stats.total, 1);
    expect(stats.byReason['Price'], 1);
  });

  test('high risk creates a prioritized follow-up', () async {
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
      externalMemberId: 'M-9',
    );
    await memberships.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      memberId: member.id,
      startAt: DateTime.utc(2026, 7, 20),
      endAt: DateTime.utc(2026, 8, 16),
      status: 'active',
    );
    final rows = StringBuffer(
      'external_event_id,external_member_id,occurred_at,event_type\n',
    );
    var n = 0;
    for (var week = 10; week >= 3; week--) {
      for (var visit = 0; visit < 4; visit++) {
        n++;
        final day = DateTime.utc(
          2026,
          8,
          15,
        ).subtract(Duration(days: week * 7));
        rows.writeln('r$n,M-9,${day.toIso8601String()},check_in');
      }
    }
    await ingest.importCsv(workspace: workspace, csv: rows.toString());
    final health = await ingest.importHealth(workspace);
    final snap = await retention.snapshot(
      workspace: workspace,
      importHealth: health,
    );
    expect(snap.risks, isNotEmpty);
    final open = await LocalFollowUpRepository(db: db).listOpen(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    expect(open.any((f) => f.type == 'risk' || f.priority >= 60), isTrue);
  });

  test('explicit renew creates a new membership row', () async {
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
    final first = await memberships.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      memberId: member.id,
      startAt: DateTime.utc(2026, 6, 1),
      endAt: DateTime.utc(2026, 7, 1),
      status: 'active',
    );
    await retention.renewExplicit(workspace: workspace, current: first);
    final all = await memberships.list(
      organizationId: workspace.organization.id,
      memberId: member.id,
    );
    expect(all.length, 2);
    expect(all.where((m) => m.status == 'renewed').length, 1);
    expect(all.where((m) => m.status == 'active').length, 1);
  });
}
