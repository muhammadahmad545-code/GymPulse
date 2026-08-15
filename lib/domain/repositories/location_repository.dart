import '../../data/db/app_database.dart';

abstract class LocationRepository {
  Future<Location> create({
    required String organizationId,
    required String name,
    required String timezone,
    required String countryCode,
    required String currencyCode,
    String? addressJson,
    int? capacity,
  });

  Future<Location?> get({required String organizationId, required String id});

  Future<List<Location>> list(String organizationId);

  Future<Location> update({
    required String organizationId,
    required String id,
    String? name,
    String? timezone,
    String? countryCode,
    String? currencyCode,
    String? addressJson,
    int? capacity,
  });
}
