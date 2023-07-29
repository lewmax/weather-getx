class CityInfo {
  CityInfo({
    required this.id,
    required this.displayName,
    required this.lat,
    required this.lon,
  });

  final int id;
  final String displayName;
  final double lat;
  final double lon;

  String get name => displayName.split(',').first.trim();
  String get descr =>
      displayName.split(',').sublist(1).map((part) => part.trim()).join(', ');

  factory CityInfo.fromJson(Map<String, dynamic> json) {
    return CityInfo(
      id: json['place_id'],
      displayName: json['display_name'],
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
    );
  }
}
