import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/app_exception.dart';
import '../../domain/repositories/location_repository.dart';
import '../db/app_database.dart';

class LocalLocationRepository implements LocationRepository {
  LocalLocationRepository({required AppDatabase db, Uuid? uuid})
    : _db = db,
      _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  @override
  Future<Location> create({
    required String organizationId,
    required String name,
    required String timezone,
    required String countryCode,
    required String currencyCode,
    String? addressJson,
    int? capacity,
  }) async {
    await _requireOrganization(organizationId);
    if (name.trim().isEmpty) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Location name is required.',
      );
    }
    if (timezone.trim().isEmpty) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Timezone is required.',
      );
    }
    final now = DateTime.now().toUtc();
    final id = _uuid.v4();
    await _db
        .into(_db.locations)
        .insert(
          LocationsCompanion.insert(
            id: id,
            organizationId: organizationId,
            name: name.trim(),
            timezone: Value(timezone.trim()),
            countryCode: Value(countryCode.trim().toUpperCase()),
            currencyCode: Value(currencyCode.trim().toUpperCase()),
            addressJson: Value(addressJson),
            capacity: Value(capacity),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (await get(organizationId: organizationId, id: id))!;
  }

  @override
  Future<Location?> get({required String organizationId, required String id}) {
    return (_db.select(_db.locations)..where(
          (t) => t.id.equals(id) & t.organizationId.equals(organizationId),
        ))
        .getSingleOrNull();
  }

  @override
  Future<List<Location>> list(String organizationId) {
    return (_db.select(
      _db.locations,
    )..where((t) => t.organizationId.equals(organizationId))).get();
  }

  @override
  Future<Location> update({
    required String organizationId,
    required String id,
    String? name,
    String? timezone,
    String? countryCode,
    String? currencyCode,
    String? addressJson,
    int? capacity,
  }) async {
    final existing = await get(organizationId: organizationId, id: id);
    if (existing == null) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Location was not found.',
      );
    }
    await (_db.update(_db.locations)..where(
          (t) => t.id.equals(id) & t.organizationId.equals(organizationId),
        ))
        .write(
          LocationsCompanion(
            name: name == null ? const Value.absent() : Value(name.trim()),
            timezone: timezone == null
                ? const Value.absent()
                : Value(timezone.trim()),
            countryCode: countryCode == null
                ? const Value.absent()
                : Value(countryCode.trim().toUpperCase()),
            currencyCode: currencyCode == null
                ? const Value.absent()
                : Value(currencyCode.trim().toUpperCase()),
            addressJson: addressJson == null
                ? const Value.absent()
                : Value(addressJson),
            capacity: capacity == null ? const Value.absent() : Value(capacity),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );
    return (await get(organizationId: organizationId, id: id))!;
  }

  Future<void> _requireOrganization(String organizationId) async {
    final org = await (_db.select(
      _db.organizations,
    )..where((t) => t.id.equals(organizationId))).getSingleOrNull();
    if (org == null) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Organization was not found.',
      );
    }
  }
}
