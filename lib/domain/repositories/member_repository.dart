import '../../data/db/app_database.dart';

abstract class MemberRepository {
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
  });

  Future<Member?> get({required String organizationId, required String id});

  Future<List<Member>> list({
    required String organizationId,
    String? locationId,
  });

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
  });
}
