import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/app_exception.dart';
import '../../domain/repositories/membership_repository.dart';
import '../db/app_database.dart';

class LocalMembershipRepository implements MembershipRepository {
  LocalMembershipRepository({required AppDatabase db, Uuid? uuid})
    : _db = db,
      _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  @override
  Future<Membership> create({
    required String organizationId,
    required String locationId,
    required String memberId,
    required DateTime startAt,
    required DateTime endAt,
    required String status,
    String? planId,
    double? priceAmount,
    String? currencyCode,
  }) async {
    if (!endAt.isAfter(startAt)) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Membership end date must be after the start date.',
      );
    }
    final member =
        await (_db.select(_db.members)..where(
              (t) =>
                  t.id.equals(memberId) &
                  t.organizationId.equals(organizationId),
            ))
            .getSingleOrNull();
    if (member == null) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'Member was not found.',
      );
    }
    final now = DateTime.now().toUtc();
    final id = _uuid.v4();
    await _db
        .into(_db.memberships)
        .insert(
          MembershipsCompanion.insert(
            id: id,
            organizationId: organizationId,
            locationId: locationId,
            memberId: memberId,
            planId: Value(planId),
            startAt: startAt.toUtc(),
            endAt: endAt.toUtc(),
            status: status,
            priceAmount: Value(priceAmount),
            currencyCode: Value(currencyCode?.toUpperCase()),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (await get(organizationId: organizationId, id: id))!;
  }

  @override
  Future<Membership?> get({
    required String organizationId,
    required String id,
  }) {
    return (_db.select(_db.memberships)..where(
          (t) => t.id.equals(id) & t.organizationId.equals(organizationId),
        ))
        .getSingleOrNull();
  }

  @override
  Future<List<Membership>> list({
    required String organizationId,
    String? memberId,
    String? locationId,
  }) {
    final query = _db.select(_db.memberships)
      ..where((t) => t.organizationId.equals(organizationId));
    if (memberId != null) {
      query.where((t) => t.memberId.equals(memberId));
    }
    if (locationId != null) {
      query.where((t) => t.locationId.equals(locationId));
    }
    return query.get();
  }
}
