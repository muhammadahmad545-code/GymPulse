import 'package:flutter_test/flutter_test.dart';
import 'package:gympulse/core/errors/app_exception.dart';
import 'package:gympulse/data/db/app_database.dart';
import 'package:gympulse/data/repositories/local_attendance_repository.dart';
import 'package:gympulse/data/repositories/local_follow_up_repository.dart';
import 'package:gympulse/data/repositories/local_location_repository.dart';
import 'package:gympulse/data/repositories/local_member_repository.dart';
import 'package:gympulse/data/repositories/local_membership_repository.dart';
import 'package:gympulse/data/repositories/local_organization_repository.dart';
import 'package:gympulse/domain/services/fee_cycle.dart';
import 'package:gympulse/domain/services/gym_ops_service.dart';
import 'package:gympulse/domain/services/retention_service.dart';
import 'package:gympulse/domain/services/workspace_service.dart';
import 'package:timezone/data/latest.dart' as tzdata;

void main() {
  tzdata.initializeTimeZones();

  late AppDatabase db;
  late WorkspaceService workspaceService;
  late LocalMemberRepository members;
  late LocalMembershipRepository memberships;
  late GymOpsService ops;

  setUp(() {
    db = AppDatabase.memory();
    members = LocalMemberRepository(db: db);
    memberships = LocalMembershipRepository(db: db);
    workspaceService = WorkspaceService(
      db: db,
      organizations: LocalOrganizationRepository(db: db),
      locations: LocalLocationRepository(db: db),
    );
    ops = GymOpsService(
      db: db,
      members: members,
      memberships: memberships,
      attendance: LocalAttendanceRepository(db: db),
      followUps: LocalFollowUpRepository(db: db),
    );
  });

  tearDown(() => db.close());

  group('FeeCycle calendar months', () {
    const fees = FeeCycle();

    test('adds one calendar month, not 30 days', () {
      expect(
        fees.addCalendarMonths(DateTime(2026, 8, 10), 1),
        DateTime(2026, 9, 10),
      );
      expect(
        fees.addCalendarMonths(DateTime(2026, 1, 31), 1),
        DateTime(2026, 2, 28),
      );
      expect(
        fees.addCalendarMonths(DateTime(2024, 1, 31), 1),
        DateTime(2024, 2, 29),
      );
      expect(
        fees.addCalendarMonths(DateTime(2026, 12, 31), 1),
        DateTime(2027, 1, 31),
      );
    });

    test('next fee date uses same day when possible', () {
      expect(
        fees.nextFeeDate(
          joinedAt: DateTime(2026, 8, 10),
          today: DateTime(2026, 8, 16),
        ),
        DateTime(2026, 9, 10),
      );
      expect(
        fees.nextFeeDate(
          joinedAt: DateTime(2026, 8, 10),
          today: DateTime(2026, 9, 10),
        ),
        DateTime(2026, 9, 10),
      );
    });

    test('month-end joining date clamps to last valid day', () {
      expect(
        fees.nextFeeDate(
          joinedAt: DateTime(2026, 1, 31),
          today: DateTime(2026, 2, 1),
        ),
        DateTime(2026, 2, 28),
      );
    });
  });

  test('duplicate member names are allowed and identified by id', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Mr. Gym',
      locationName: 'Main',
      countryCode: 'PK',
      timezone: 'Asia/Karachi',
      currencyCode: 'PKR',
    );
    final a = await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Ali',
      phone: '03001234567',
    );
    final b = await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Ali',
      phone: '03007654321',
    );
    expect(a.id, isNot(b.id));
    expect(a.firstName, b.firstName);
  });

  test('empty name and short WhatsApp number are rejected', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Mr. Gym',
      locationName: 'Main',
      countryCode: 'PK',
      timezone: 'Asia/Karachi',
      currencyCode: 'PKR',
    );
    expect(
      () => members.create(
        organizationId: workspace.organization.id,
        locationId: workspace.location.id,
        firstName: '  ',
        phone: '03001234567',
      ),
      throwsA(isA<AppException>()),
    );
    expect(
      () => members.create(
        organizationId: workspace.organization.id,
        locationId: workspace.location.id,
        firstName: 'Sara',
        phone: '123',
      ),
      throwsA(isA<AppException>()),
    );
  });

  test(
    'mark attendance persists and blocks a silent same-day duplicate',
    () async {
      final workspace = await workspaceService.setup(
        organizationName: 'Mr. Gym',
        locationName: 'Main',
        countryCode: 'PK',
        timezone: 'UTC',
        currencyCode: 'PKR',
      );
      final member = await members.create(
        organizationId: workspace.organization.id,
        locationId: workspace.location.id,
        firstName: 'Ali',
        phone: '03001234567',
      );
      final now = DateTime.utc(2026, 8, 16, 10);
      final first = await ops.markAttendance(
        workspace: workspace,
        memberId: member.id,
        nowUtc: now,
      );
      expect(first.alreadyMarked, isFalse);
      expect(first.event.isManual, isTrue);
      expect(first.event.localDate, '2026-08-16');

      expect(
        () => ops.markAttendance(
          workspace: workspace,
          memberId: member.id,
          nowUtc: now.add(const Duration(hours: 2)),
        ),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.attendanceDuplicateEvent,
          ),
        ),
      );

      final today = await ops.todaysAttendance(
        workspace: workspace,
        memberId: member.id,
        nowUtc: now,
      );
      expect(today, isNotNull);
      expect(today!.id, first.event.id);

      final second = await ops.markAttendance(
        workspace: workspace,
        memberId: member.id,
        nowUtc: now.add(const Duration(hours: 3)),
        allowDuplicate: true,
      );
      expect(second.alreadyMarked, isTrue);
      final events = await db.select(db.attendanceEvents).get();
      expect(events, hasLength(2));
    },
  );

  test('fee reminders generate once per member, cycle, and type', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Mr. Gym',
      locationName: 'Main',
      countryCode: 'PK',
      timezone: 'UTC',
      currencyCode: 'PKR',
    );
    await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Ali',
      phone: '03001234567',
      joinedAt: DateTime(2026, 8, 10),
    );
    final dueSoon = DateTime.utc(2026, 9, 7, 9);
    final first = await ops.generateDueReminders(
      workspace: workspace,
      nowUtc: dueSoon,
    );
    final second = await ops.generateDueReminders(
      workspace: workspace,
      nowUtc: dueSoon,
    );
    expect(first, hasLength(1));
    expect(first.single.reminderType, GymOpsService.reminderDueSoon);
    expect(second, isEmpty);

    final dueToday = await ops.generateDueReminders(
      workspace: workspace,
      nowUtc: DateTime.utc(2026, 9, 10, 9),
    );
    expect(dueToday, hasLength(1));
    expect(dueToday.single.reminderType, GymOpsService.reminderDueToday);
    expect(dueToday.single.status, 'pending');

    await ops.markReminderOpened(dueToday.single.id);
    final opened = await ops.remindersForMember(
      workspace: workspace,
      memberId: dueToday.single.memberId,
    );
    expect(opened.any((r) => r.status == 'opened'), isTrue);
    expect(opened.any((r) => r.status == 'sent'), isFalse);
  });

  test('WhatsApp templates never claim a message was sent', () {
    final soon = ops.feeWhatsAppMessage(
      memberName: 'Ali',
      feeDate: DateTime(2026, 9, 10),
      type: GymOpsService.reminderDueSoon,
    );
    final today = ops.feeWhatsAppMessage(
      memberName: 'Ali',
      feeDate: DateTime(2026, 9, 10),
      type: GymOpsService.reminderDueToday,
    );
    expect(soon, contains('due in 3 days, on 2026-09-10'));
    expect(today, contains('due on 2026-09-10'));
    expect(soon.toLowerCase(), isNot(contains('sent')));
    expect(today, contains('Mr. Gym'));
  });

  test('search finds members, phones, and follow-ups', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Mr. Gym',
      locationName: 'Main',
      countryCode: 'PK',
      timezone: 'UTC',
      currencyCode: 'PKR',
    );
    final member = await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Hassan',
      lastName: 'Khan',
      phone: '03111222333',
    );
    await LocalFollowUpRepository(db: db).create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      memberId: member.id,
      type: 'fee',
      reason: 'Call about September fee',
      priority: 50,
    );
    final byName = await ops.search(workspace: workspace, query: 'hassan');
    final byPhone = await ops.search(workspace: workspace, query: '0311122');
    final byFollow = await ops.search(workspace: workspace, query: 'september');
    expect(byName.any((h) => h.memberId == member.id), isTrue);
    expect(byPhone.any((h) => h.kind == 'member'), isTrue);
    expect(byFollow.any((h) => h.kind == 'follow_up'), isTrue);
  });

  test('custom cancellation reasons can be added and deactivated', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Mr. Gym',
      locationName: 'Main',
      countryCode: 'PK',
      timezone: 'UTC',
      currencyCode: 'PKR',
    );
    await ops.seedDefaultReasons(workspace.organization.id);
    final added = await ops.addReason(
      organizationId: workspace.organization.id,
      label: 'Shift timing',
    );
    expect(added.active, isTrue);
    await ops.setReasonActive(
      organizationId: workspace.organization.id,
      id: added.id,
      active: false,
    );
    final rows = await ops.listReasons(workspace.organization.id);
    expect(rows.any((r) => r.id == added.id && !r.active), isTrue);
    expect(rows.where((r) => r.code == 'price'), isNotEmpty);
  });

  test('renewal keeps the previous membership row', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Mr. Gym',
      locationName: 'Main',
      countryCode: 'PK',
      timezone: 'UTC',
      currencyCode: 'PKR',
    );
    final member = await members.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      firstName: 'Noor',
      phone: '03220001111',
    );
    final start = DateTime.utc(2026, 8, 10);
    final first = await memberships.create(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
      memberId: member.id,
      startAt: start,
      endAt: DateTime.utc(2026, 9, 10, 23, 59, 59),
      status: 'active',
    );
    final retention = RetentionService(
      db: db,
      members: members,
      memberships: memberships,
      attendance: LocalAttendanceRepository(db: db),
      followUps: LocalFollowUpRepository(db: db),
    );
    await retention.renewExplicit(workspace: workspace, current: first);
    final all = await memberships.list(
      organizationId: workspace.organization.id,
      memberId: member.id,
    );
    expect(all, hasLength(2));
    expect(all.where((m) => m.status == 'renewed'), hasLength(1));
    expect(all.where((m) => m.status == 'active'), hasLength(1));
  });

  test('directory and dashboard stay responsive with 200 members', () async {
    final workspace = await workspaceService.setup(
      organizationName: 'Mr. Gym',
      locationName: 'Main',
      countryCode: 'PK',
      timezone: 'UTC',
      currencyCode: 'PKR',
    );
    for (var i = 0; i < 200; i++) {
      await members.create(
        organizationId: workspace.organization.id,
        locationId: workspace.location.id,
        firstName: 'Member',
        lastName: '$i',
        phone: '0300${(1000000 + i).toString().padLeft(7, '0')}',
        joinedAt: DateTime(2026, 1, (i % 28) + 1),
      );
    }
    final sw = Stopwatch()..start();
    final rows = await ops.directory(workspace: workspace);
    final dash = await ops.dashboard(
      workspace: workspace,
      nowUtc: DateTime.utc(2026, 8, 16),
    );
    sw.stop();
    expect(rows, hasLength(200));
    expect(dash.activeMembers, 200);
    expect(sw.elapsedMilliseconds, lessThan(4000));
  });
}
