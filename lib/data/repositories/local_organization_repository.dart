import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/app_exception.dart';
import '../../domain/repositories/organization_repository.dart';
import '../db/app_database.dart';

class LocalOrganizationRepository implements OrganizationRepository {
  LocalOrganizationRepository({required AppDatabase db, Uuid? uuid})
    : _db = db,
      _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  @override
  Future<Organization> create({
    required String name,
    required String countryCode,
    required String defaultCurrency,
  }) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Organization name is required.',
      );
    }
    final now = DateTime.now().toUtc();
    final id = _uuid.v4();
    await _db
        .into(_db.organizations)
        .insert(
          OrganizationsCompanion.insert(
            id: id,
            name: trimmed,
            countryCode: Value(countryCode.trim().toUpperCase()),
            defaultCurrency: Value(defaultCurrency.trim().toUpperCase()),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (await get(id))!;
  }

  @override
  Future<Organization?> get(String id) {
    return (_db.select(
      _db.organizations,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<List<Organization>> list() {
    return _db.select(_db.organizations).get();
  }

  @override
  Future<Organization> update({
    required String id,
    String? name,
    String? countryCode,
    String? defaultCurrency,
  }) async {
    final existing = await get(id);
    if (existing == null) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Organization was not found.',
      );
    }
    await (_db.update(_db.organizations)..where((t) => t.id.equals(id))).write(
      OrganizationsCompanion(
        name: name == null ? const Value.absent() : Value(name.trim()),
        countryCode: countryCode == null
            ? const Value.absent()
            : Value(countryCode.trim().toUpperCase()),
        defaultCurrency: defaultCurrency == null
            ? const Value.absent()
            : Value(defaultCurrency.trim().toUpperCase()),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
    return (await get(id))!;
  }
}
