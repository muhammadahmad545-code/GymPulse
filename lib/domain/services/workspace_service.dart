import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/app_exception.dart';
import '../../data/db/app_database.dart';
import '../../data/repositories/local_location_repository.dart';
import '../../data/repositories/local_organization_repository.dart';
import '../models/workspace.dart';

class WorkspaceService {
  WorkspaceService({
    required AppDatabase db,
    required LocalOrganizationRepository organizations,
    required LocalLocationRepository locations,
    Uuid? uuid,
  }) : _db = db,
       _organizations = organizations,
       _locations = locations,
       _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final LocalOrganizationRepository _organizations;
  final LocalLocationRepository _locations;
  final Uuid _uuid;

  Future<Workspace?> current() async {
    final orgs = await _organizations.list();
    if (orgs.isEmpty) return null;
    final org = orgs.first;
    final locs = await _locations.list(org.id);
    if (locs.isEmpty) return null;
    final location = locs.first;
    final settings = await _settingsFor(location.id);
    return Workspace(organization: org, location: location, settings: settings);
  }

  Future<Workspace> setup({
    required String organizationName,
    required String locationName,
    required String countryCode,
    required String timezone,
    required String currencyCode,
    int? capacity,
    String? gymPhone,
  }) async {
    if (organizationName.trim().isEmpty || locationName.trim().isEmpty) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Gym name and location name are required.',
      );
    }
    if (await current() != null) {
      throw AppException(
        code: AppErrorCodes.authForbidden,
        message: 'A gym is already set up on this device.',
      );
    }
    final org = await _organizations.create(
      name: organizationName.trim(),
      countryCode: countryCode,
      defaultCurrency: currencyCode,
    );
    final location = await _locations.create(
      organizationId: org.id,
      name: locationName.trim(),
      timezone: timezone,
      countryCode: countryCode,
      currencyCode: currencyCode,
      capacity: capacity,
    );
    final now = DateTime.now().toUtc();
    await _db
        .into(_db.locationSettings)
        .insert(
          LocationSettingsCompanion.insert(
            locationId: location.id,
            gymPhone: Value(gymPhone?.trim().isEmpty == true ? null : gymPhone),
            updatedAt: now,
          ),
        );
    await _seedTemplates(org.id, location.id, now);
    await _db
        .into(_db.membershipPlans)
        .insert(
          MembershipPlansCompanion.insert(
            id: _uuid.v4(),
            organizationId: org.id,
            locationId: Value(location.id),
            name: 'Monthly',
            durationDays: 30,
            currencyCode: Value(currencyCode),
          ),
        );
    return (await current())!;
  }

  Future<LocationSetting> updateSettings({
    required String locationId,
    int? inactivityMonitorDays,
    int? inactivityFollowUpDays,
    int? inactivityHighRiskDays,
    int? inactivityCriticalDays,
    int? staleImportHours,
    String? gymPhone,
    int? peakHighAttendance,
    String? closureDatesJson,
    String? riskWeightsJson,
    int? trialDefaultDays,
  }) async {
    await _db
        .into(_db.locationSettings)
        .insertOnConflictUpdate(
          LocationSettingsCompanion.insert(
            locationId: locationId,
            inactivityMonitorDays: inactivityMonitorDays == null
                ? const Value.absent()
                : Value(inactivityMonitorDays),
            inactivityFollowUpDays: inactivityFollowUpDays == null
                ? const Value.absent()
                : Value(inactivityFollowUpDays),
            inactivityHighRiskDays: inactivityHighRiskDays == null
                ? const Value.absent()
                : Value(inactivityHighRiskDays),
            inactivityCriticalDays: inactivityCriticalDays == null
                ? const Value.absent()
                : Value(inactivityCriticalDays),
            staleImportHours: staleImportHours == null
                ? const Value.absent()
                : Value(staleImportHours),
            gymPhone: gymPhone == null ? const Value.absent() : Value(gymPhone),
            peakHighAttendance: peakHighAttendance == null
                ? const Value.absent()
                : Value(peakHighAttendance),
            closureDatesJson: closureDatesJson == null
                ? const Value.absent()
                : Value(closureDatesJson),
            riskWeightsJson: riskWeightsJson == null
                ? const Value.absent()
                : Value(riskWeightsJson),
            trialDefaultDays: trialDefaultDays == null
                ? const Value.absent()
                : Value(trialDefaultDays),
            updatedAt: DateTime.now().toUtc(),
          ),
        );
    return _settingsFor(locationId);
  }

  Future<LocationSetting> _settingsFor(String locationId) async {
    final existing = await (_db.select(
      _db.locationSettings,
    )..where((t) => t.locationId.equals(locationId))).getSingleOrNull();
    if (existing != null) return existing;
    await _db
        .into(_db.locationSettings)
        .insert(
          LocationSettingsCompanion.insert(
            locationId: locationId,
            updatedAt: DateTime.now().toUtc(),
          ),
        );
    return (await (_db.select(
      _db.locationSettings,
    )..where((t) => t.locationId.equals(locationId))).getSingle());
  }

  Future<void> _seedTemplates(
    String organizationId,
    String locationId,
    DateTime now,
  ) async {
    const templates = {
      'expiry':
          'Hi {{member_name}}, your membership at {{gym_name}} expires on {{expiry_date}}. Reply if you would like to renew.',
      'inactivity':
          'Hi {{member_name}}, we have not seen you at {{gym_name}} for {{days_since_visit}} days. We would love to welcome you back.',
      'trial':
          'Hi {{member_name}}, your trial at {{gym_name}} is ending soon. Ask the front desk about joining.',
    };
    for (final entry in templates.entries) {
      await _db
          .into(_db.messageTemplates)
          .insert(
            MessageTemplatesCompanion.insert(
              id: _uuid.v4(),
              organizationId: organizationId,
              locationId: Value(locationId),
              key: entry.key,
              body: entry.value,
              createdAt: now,
              updatedAt: now,
            ),
          );
    }
  }
}
