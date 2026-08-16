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

  static const _activeLocationKey = 'active_location_id';

  Future<Workspace?> current() async {
    final orgs = await _organizations.list();
    if (orgs.isEmpty) return null;
    final org = orgs.first;
    final locs = await _locations.list(org.id);
    if (locs.isEmpty) return null;
    final selectedId = await _meta(_activeLocationKey);
    final location = locs.cast<Location?>().firstWhere(
      (l) => l?.id == selectedId,
      orElse: () => locs.first,
    )!;
    final settings = await _settingsFor(location.id);
    return Workspace(organization: org, location: location, settings: settings);
  }

  Future<List<Location>> listLocations() async {
    final workspace = await current();
    if (workspace == null) return const [];
    return _locations.list(workspace.organization.id);
  }

  Future<Workspace> switchLocation(String locationId) async {
    final workspace = await current();
    if (workspace == null) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Set up a gym before switching locations.',
      );
    }
    final location = await _locations.get(
      organizationId: workspace.organization.id,
      id: locationId,
    );
    if (location == null) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Location was not found in this organization.',
      );
    }
    await _setMeta(_activeLocationKey, locationId);
    return (await current())!;
  }

  Future<Workspace> addLocation({
    required String name,
    String? timezone,
    int? capacity,
  }) async {
    final workspace = await current();
    if (workspace == null) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Set up a gym before adding a location.',
      );
    }
    final location = await _locations.create(
      organizationId: workspace.organization.id,
      name: name,
      timezone: timezone?.trim().isNotEmpty == true
          ? timezone!.trim()
          : workspace.location.timezone,
      countryCode: workspace.location.countryCode,
      currencyCode: workspace.location.currencyCode,
      capacity: capacity,
    );
    final now = DateTime.now().toUtc();
    await _db
        .into(_db.locationSettings)
        .insert(
          LocationSettingsCompanion.insert(
            locationId: location.id,
            updatedAt: now,
          ),
        );
    await _seedTemplates(workspace.organization.id, location.id, now);
    await _setMeta(_activeLocationKey, location.id);
    return (await current())!;
  }

  Future<void> updateLocationCapacity({
    required String locationId,
    int? capacity,
  }) async {
    final workspace = await current();
    if (workspace == null) return;
    await _locations.update(
      organizationId: workspace.organization.id,
      id: locationId,
      capacity: capacity,
    );
  }

  Future<String?> _meta(String key) async {
    final row = await (_db.select(
      _db.appMetaEntries,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> _setMeta(String key, String value) async {
    await _db
        .into(_db.appMetaEntries)
        .insertOnConflictUpdate(
          AppMetaEntriesCompanion.insert(
            key: key,
            value: value,
            updatedAt: DateTime.now().toUtc(),
          ),
        );
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
    final gymName = organizationName.trim().isEmpty
        ? 'Mr. Gym'
        : organizationName.trim();
    final siteName = locationName.trim().isEmpty ? 'Main' : locationName.trim();
    if (gymName.isEmpty) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Gym name is required.',
      );
    }
    if (await current() != null) {
      throw AppException(
        code: AppErrorCodes.authForbidden,
        message: 'A gym is already set up on this device.',
      );
    }
    final org = await _organizations.create(
      name: gymName,
      countryCode: countryCode,
      defaultCurrency: currencyCode,
    );
    final location = await _locations.create(
      organizationId: org.id,
      name: siteName,
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
    await _seedCancellationReasons(org.id, now);
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
          'Assalam-o-Alaikum {{member_name}},\n\nThis is a friendly reminder from Mr. Gym that your monthly gym fee is due on {{expiry_date}}.\n\nThank you,\nMr. Gym',
      'fee_due_soon':
          'Assalam-o-Alaikum {{member_name}},\n\nThis is a friendly reminder from Mr. Gym that your monthly gym fee is due in 3 days, on {{expiry_date}}.\n\nThank you,\nMr. Gym',
      'inactivity':
          'Assalam-o-Alaikum {{member_name}}, we have not seen you at Mr. Gym for {{days_since_visit}} days. We would love to welcome you back.\n\nThank you,\nMr. Gym',
      'trial':
          'Assalam-o-Alaikum {{member_name}}, your trial at Mr. Gym is ending soon. Ask the front desk about joining.\n\nThank you,\nMr. Gym',
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

  Future<void> _seedCancellationReasons(
    String organizationId,
    DateTime now,
  ) async {
    const defaults = {
      'price': 'Too expensive',
      'moving': 'Moving away',
      'schedule': 'Not enough time',
      'health': 'Health/personal reasons',
      'not_satisfied': 'Not satisfied',
      'equipment': 'Equipment',
      'trainer': 'Trainer',
      'another_gym': 'Found another gym',
      'other': 'Other',
    };
    for (final entry in defaults.entries) {
      await _db
          .into(_db.cancellationReasons)
          .insert(
            CancellationReasonsCompanion.insert(
              id: _uuid.v4(),
              organizationId: organizationId,
              code: entry.key,
              label: entry.value,
              createdAt: now,
              updatedAt: now,
            ),
          );
    }
  }
}
