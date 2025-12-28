import 'data/beni_suef_data.dart';
import 'data/cairo_data.dart';
import 'data/giza_data.dart';
import 'data/alexandria_data.dart';
import 'data/delta_governorates_data.dart';

/// Main Egyptian Locations API
/// Provides access to 3-level hierarchy: Governorate -> City -> Neighborhood
class EgyptianLocations {
  /// Complete locations map - aggregates all regional data
  static final Map<String, Map<String, List<String>>> locations = {
    ...BeniSuefData.locations,
    ...CairoData.locations,
    ...GizaData.locations,
    ...AlexandriaData.locations,
    ...DeltaGovernoratesData.locations,
  };

  /// Get all governorates
  static List<String> getGovernorates() {
    return locations.keys.toList()..sort();
  }

  /// Get cities/centers for a governorate
  static List<String> getCities(String governorate) {
    return locations[governorate]?.keys.toList() ?? [];
  }

  /// Get neighborhoods for a city
  static List<String> getNeighborhoods(String governorate, String city) {
    return locations[governorate]?[city] ?? [];
  }

  /// Get counts
  static int getGovernoratesCount() => locations.length;

  static int getCitiesCount(String governorate) {
    return locations[governorate]?.length ?? 0;
  }

  static int getNeighborhoodsCount(String governorate, String city) {
    return locations[governorate]?[city]?.length ?? 0;
  }

  /// Check if location exists
  static bool hasGovernorate(String governorate) {
    return locations.containsKey(governorate);
  }

  static bool hasCity(String governorate, String city) {
    return locations[governorate]?.containsKey(city) ?? false;
  }

  /// Get full location path as string
  static String getFullLocation(
    String governorate,
    String city,
    String neighborhood,
  ) {
    return '$neighborhood، $city، $governorate';
  }
}
