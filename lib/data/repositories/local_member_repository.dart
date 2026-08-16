import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/app_exception.dart';
import '../../domain/repositories/member_repository.dart';
import '../db/app_database.dart';

class LocalMemberRepository implements MemberRepository {
  LocalMemberRepository({required AppDatabase db, Uuid? uuid})
    : _db = db,
      _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  @override
  Future<Member> create({
    required String organizationId,
    required String locationId,
    required String firstName,
    String lastName = '',
    String? externalMemberId,
    String? phone,
    String? email,
    String status = 'active',
    DateTime? joinedAt,
    int? feeDay,
    String? gender,
    String? notes,
    bool whatsappEnabled = true,
  }) async {
    if (firstName.trim().isEmpty) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Full name is required.',
      );
    }
    if (whatsappEnabled && phone != null && _digits(phone).length < 10) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'WhatsApp number is required (at least 10 digits).',
      );
    }
    final join = joinedAt ?? DateTime.now();
    await _requireLocation(organizationId, locationId);
    final now = DateTime.now().toUtc();
    final id = _uuid.v4();
    await _db
        .into(_db.members)
        .insert(
          MembersCompanion.insert(
            id: id,
            organizationId: organizationId,
            locationId: locationId,
            firstName: firstName.trim(),
            lastName: Value(lastName.trim()),
            externalMemberId: Value(_emptyToNull(externalMemberId)),
            phone: Value(_emptyToNull(phone)),
            email: Value(_emptyToNull(email)),
            status: Value(status),
            joinedAt: Value(join.toUtc()),
            feeDay: Value(feeDay ?? join.day),
            gender: Value(_emptyToNull(gender)),
            notes: Value(_emptyToNull(notes)),
            whatsappEnabled: Value(whatsappEnabled),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (await get(organizationId: organizationId, id: id))!;
  }

  @override
  Future<Member?> get({required String organizationId, required String id}) {
    return (_db.select(_db.members)..where(
          (t) => t.id.equals(id) & t.organizationId.equals(organizationId),
        ))
        .getSingleOrNull();
  }

  @override
  Future<List<Member>> list({
    required String organizationId,
    String? locationId,
  }) {
    final query = _db.select(_db.members)
      ..where((t) => t.organizationId.equals(organizationId));
    if (locationId != null) {
      query.where((t) => t.locationId.equals(locationId));
    }
    return query.get();
  }

  @override
  Future<Member> update({
    required String organizationId,
    required String id,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? status,
    String? externalMemberId,
    DateTime? joinedAt,
    int? feeDay,
    String? gender,
    String? notes,
    bool? whatsappEnabled,
  }) async {
    final existing = await get(organizationId: organizationId, id: id);
    if (existing == null) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Member was not found.',
      );
    }
    await (_db.update(_db.members)..where(
          (t) => t.id.equals(id) & t.organizationId.equals(organizationId),
        ))
        .write(
          MembersCompanion(
            firstName: firstName == null
                ? const Value.absent()
                : Value(firstName.trim()),
            lastName: lastName == null
                ? const Value.absent()
                : Value(lastName.trim()),
            phone: phone == null
                ? const Value.absent()
                : Value(_emptyToNull(phone)),
            email: email == null
                ? const Value.absent()
                : Value(_emptyToNull(email)),
            status: status == null ? const Value.absent() : Value(status),
            externalMemberId: externalMemberId == null
                ? const Value.absent()
                : Value(_emptyToNull(externalMemberId)),
            joinedAt: joinedAt == null
                ? const Value.absent()
                : Value(joinedAt.toUtc()),
            feeDay: feeDay == null ? const Value.absent() : Value(feeDay),
            gender: gender == null
                ? const Value.absent()
                : Value(_emptyToNull(gender)),
            notes: notes == null
                ? const Value.absent()
                : Value(_emptyToNull(notes)),
            whatsappEnabled: whatsappEnabled == null
                ? const Value.absent()
                : Value(whatsappEnabled),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );
    return (await get(organizationId: organizationId, id: id))!;
  }

  Future<void> _requireLocation(
    String organizationId,
    String locationId,
  ) async {
    final location =
        await (_db.select(_db.locations)..where(
              (t) =>
                  t.id.equals(locationId) &
                  t.organizationId.equals(organizationId),
            ))
            .getSingleOrNull();
    if (location == null) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Location was not found for this organization.',
      );
    }
  }

  String _digits(String? value) =>
      (value ?? '').replaceAll(RegExp(r'[^\d]'), '');

  String? _emptyToNull(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
