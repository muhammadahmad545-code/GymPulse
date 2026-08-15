import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Organizations extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get countryCode => text().withDefault(const Constant(''))();
  TextColumn get defaultCurrency => text().withDefault(const Constant('USD'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Locations extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text().references(Organizations, #id)();
  TextColumn get name => text()();
  TextColumn get timezone => text().withDefault(const Constant('UTC'))();
  TextColumn get countryCode => text().withDefault(const Constant(''))();
  TextColumn get currencyCode => text().withDefault(const Constant('USD'))();
  TextColumn get addressJson => text().nullable()();
  IntColumn get capacity => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalUsers extends Table {
  TextColumn get id => text()();
  TextColumn get displayName => text()();
  TextColumn get roleDefault => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class OrganizationMembers extends Table {
  TextColumn get organizationId => text().references(Organizations, #id)();
  TextColumn get userId => text().references(LocalUsers, #id)();
  TextColumn get role => text()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {organizationId, userId};
}

class LocationAccess extends Table {
  TextColumn get organizationId => text()();
  TextColumn get locationId => text()();
  TextColumn get userId => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {organizationId, locationId, userId};
}

@TableIndex(
  name: 'members_org_external_uidx',
  columns: {#organizationId, #externalMemberId},
  unique: true,
)
@TableIndex(
  name: 'members_org_location_idx',
  columns: {#organizationId, #locationId},
)
class Members extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text()();
  TextColumn get locationId => text()();
  TextColumn get externalMemberId => text().nullable()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text().withDefault(const Constant(''))();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class MembershipPlans extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text()();
  TextColumn get locationId => text().nullable()();
  TextColumn get name => text()();
  IntColumn get durationDays => integer()();
  RealColumn get priceAmount => real().withDefault(const Constant(0))();
  TextColumn get currencyCode => text().withDefault(const Constant('USD'))();
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Memberships extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text()();
  TextColumn get locationId => text()();
  TextColumn get memberId => text()();
  TextColumn get planId => text().nullable()();
  DateTimeColumn get startAt => dateTime()();
  DateTimeColumn get endAt => dateTime()();
  TextColumn get status => text()();
  RealColumn get priceAmount => real().nullable()();
  TextColumn get currencyCode => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class AttendanceSources extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text()();
  TextColumn get locationId => text()();
  TextColumn get type => text()();
  TextColumn get vendor => text().nullable()();
  TextColumn get externalSourceId => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('ready'))();
  DateTimeColumn get lastSuccessAt => dateTime().nullable()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  TextColumn get metadataJson => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'attendance_source_event_uidx',
  columns: {#sourceId, #externalEventId},
  unique: true,
)
@TableIndex(
  name: 'attendance_org_location_time_idx',
  columns: {#organizationId, #locationId, #occurredAtUtc},
)
class AttendanceEvents extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text()();
  TextColumn get locationId => text()();
  TextColumn get memberId => text().nullable()();
  TextColumn get externalMemberId => text()();
  TextColumn get sourceId => text()();
  DateTimeColumn get occurredAtUtc => dateTime()();
  DateTimeColumn get occurredAtLocal => dateTime()();
  TextColumn get eventType => text()();
  TextColumn get externalEventId => text().nullable()();
  TextColumn get rawPayloadJson => text().nullable()();
  DateTimeColumn get ingestedAt => dateTime()();
  TextColumn get matchStatus =>
      text().withDefault(const Constant('unmatched'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocationSettings extends Table {
  TextColumn get locationId => text()();
  IntColumn get inactivityMonitorDays =>
      integer().withDefault(const Constant(7))();
  IntColumn get inactivityFollowUpDays =>
      integer().withDefault(const Constant(14))();
  IntColumn get inactivityHighRiskDays =>
      integer().withDefault(const Constant(21))();
  IntColumn get inactivityCriticalDays =>
      integer().withDefault(const Constant(30))();
  IntColumn get staleImportHours => integer().withDefault(const Constant(24))();
  TextColumn get gymPhone => text().nullable()();
  IntColumn get peakHighAttendance => integer().nullable()();
  TextColumn get closureDatesJson => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {locationId};
}

class Trials extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text()();
  TextColumn get locationId => text()();
  TextColumn get memberId => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endsAt => dateTime()();
  DateTimeColumn get convertedAt => dateTime().nullable()();
  TextColumn get status => text()();
  TextColumn get source => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class FollowUps extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text()();
  TextColumn get locationId => text()();
  TextColumn get memberId => text()();
  TextColumn get type => text()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  TextColumn get reason => text()();
  TextColumn get status => text()();
  DateTimeColumn get dueAt => dateTime().nullable()();
  TextColumn get assignedTo => text().nullable()();
  TextColumn get contactChannel => text().nullable()();
  TextColumn get messageTemplateId => text().nullable()();
  TextColumn get resolutionNote => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class MessageTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text()();
  TextColumn get locationId => text().nullable()();
  TextColumn get key => text()();
  TextColumn get body => text()();
  TextColumn get channel => text().withDefault(const Constant('whatsapp'))();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CancellationEvents extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text()();
  TextColumn get locationId => text()();
  TextColumn get memberId => text()();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get reasonCode => text()();
  TextColumn get reasonText => text().nullable()();
  TextColumn get source => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class RiskScores extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text()();
  TextColumn get locationId => text()();
  TextColumn get memberId => text()();
  IntColumn get score => integer()();
  TextColumn get riskLevel => text()();
  RealColumn get confidence => real()();
  DateTimeColumn get calculatedAt => dateTime()();
  TextColumn get factorsJson => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DailyMemberMetrics extends Table {
  TextColumn get organizationId => text()();
  TextColumn get locationId => text()();
  TextColumn get memberId => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get visits => integer().withDefault(const Constant(0))();
  IntColumn get daysSinceLastVisit => integer().nullable()();
  RealColumn get rolling7dVisits => real().nullable()();
  RealColumn get rolling30dVisits => real().nullable()();
  RealColumn get attendanceChange => real().nullable()();
  IntColumn get membershipDaysRemaining => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {
    organizationId,
    locationId,
    memberId,
    date,
  };
}

class GymDailyMetrics extends Table {
  TextColumn get organizationId => text()();
  TextColumn get locationId => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get activeMembers => integer().withDefault(const Constant(0))();
  IntColumn get visits => integer().withDefault(const Constant(0))();
  IntColumn get uniqueVisitors => integer().withDefault(const Constant(0))();
  IntColumn get trials => integer().withDefault(const Constant(0))();
  IntColumn get trialConversions => integer().withDefault(const Constant(0))();
  IntColumn get renewals => integer().withDefault(const Constant(0))();
  IntColumn get cancellations => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {organizationId, locationId, date};
}

class IntegrationSyncRuns extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text()();
  TextColumn get locationId => text()();
  TextColumn get sourceId => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get status => text()();
  IntColumn get recordsRead => integer().withDefault(const Constant(0))();
  IntColumn get recordsCreated => integer().withDefault(const Constant(0))();
  IntColumn get recordsUpdated => integer().withDefault(const Constant(0))();
  IntColumn get recordsSkipped => integer().withDefault(const Constant(0))();
  IntColumn get errorCount => integer().withDefault(const Constant(0))();
  TextColumn get errorSummary => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class NotificationPreferences extends Table {
  TextColumn get organizationId => text()();
  TextColumn get userId => text()();
  TextColumn get key => text()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {organizationId, userId, key};
}

class AuditLogs extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text().nullable()();
  TextColumn get userId => text().nullable()();
  TextColumn get action => text()();
  TextColumn get entityType => text().nullable()();
  TextColumn get entityId => text().nullable()();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get metadataJson => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class AppMetaEntries extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

/// Singleton-style security state (one logical row id = 'default').
class SecurityStates extends Table {
  TextColumn get id => text()();
  TextColumn get pinHash => text()();
  TextColumn get pinSalt => text()();
  TextColumn get pinAlgo => text()();
  IntColumn get failedAttempts => integer().withDefault(const Constant(0))();
  DateTimeColumn get lockoutUntilUtc => dateTime().nullable()();
  BoolColumn get biometricUnlockEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get autoLockSeconds => integer().withDefault(const Constant(120))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class BackupRuns extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get direction => text()();
  TextColumn get status => text()();
  TextColumn get fileName => text().nullable()();
  TextColumn get formatVersion => text().nullable()();
  TextColumn get checksum => text().nullable()();
  TextColumn get appVersion => text().nullable()();
  TextColumn get errorCode => text().nullable()();
  TextColumn get errorSummary => text().nullable()();
  TextColumn get createdByUserId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class BackupReminderSettings extends Table {
  TextColumn get organizationId => text()();
  IntColumn get intervalDays => integer().withDefault(const Constant(7))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastRemindedAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {organizationId};
}

@DriftDatabase(
  tables: [
    Organizations,
    Locations,
    LocalUsers,
    OrganizationMembers,
    LocationAccess,
    Members,
    MembershipPlans,
    Memberships,
    AttendanceSources,
    AttendanceEvents,
    Trials,
    FollowUps,
    MessageTemplates,
    CancellationEvents,
    RiskScores,
    DailyMemberMetrics,
    GymDailyMetrics,
    IntegrationSyncRuns,
    NotificationPreferences,
    AuditLogs,
    AppMetaEntries,
    SecurityStates,
    BackupRuns,
    BackupReminderSettings,
    LocationSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(attendanceEvents, attendanceEvents.matchStatus);
        await m.createTable(locationSettings);
      }
    },
  );

  static Future<AppDatabase> open() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'gympulse.sqlite'));
    return AppDatabase(NativeDatabase.createInBackground(file));
  }

  static AppDatabase memory() => AppDatabase(NativeDatabase.memory());
}
