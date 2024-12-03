class LocationModel {
  final String name;
  final String placeId;
  final double latitude;
  final double longitude;

  LocationModel({
    required this.name,
    required this.placeId,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      placeId: json['placeId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
