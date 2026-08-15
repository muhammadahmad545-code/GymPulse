import '../../data/db/app_database.dart';

abstract class MembershipRepository {
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
  });

  Future<Membership?> get({required String organizationId, required String id});

  Future<List<Membership>> list({
    required String organizationId,
    String? memberId,
    String? locationId,
  });
}
