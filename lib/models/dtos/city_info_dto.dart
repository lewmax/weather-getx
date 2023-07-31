import '../city_info.dart';

class CityInfoDto {
  const CityInfoDto._({
    required this.id,
    required this.displayName,
    required this.lat,
    required this.lon,
  });

  final int id;
  final String displayName;
  final double lat;
  final double lon;

  factory CityInfoDto.fromJson(Map<String, dynamic> json) {
    return CityInfoDto._(
      id: json['place_id'],
      displayName: json['display_name'],
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'lat': lat,
      'lon': lon,
    };
  }

  factory CityInfoDto.fromDomain(CityInfo domain) {
    return CityInfoDto._(
      id: domain.id,
      displayName: domain.displayName,
      lat: domain.lat,
      lon: domain.lon,
    );
  }

  CityInfo toDomain() {
    return CityInfo(id: id, displayName: displayName, lat: lat, lon: lon);
  }
}
