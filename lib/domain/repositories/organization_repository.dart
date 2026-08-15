import '../../data/db/app_database.dart';

/// Local organization persistence. Future sync adapters implement the same contract.
abstract class OrganizationRepository {
  Future<Organization> create({
    required String name,
    required String countryCode,
    required String defaultCurrency,
  });

  Future<Organization?> get(String id);

  Future<List<Organization>> list();

  Future<Organization> update({
    required String id,
    String? name,
    String? countryCode,
    String? defaultCurrency,
  });
}
