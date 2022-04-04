import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  LocationEntity(
    this.id,
    this.latitude,
    this.longitude,
    this.country,
    this.state,
    this.locality,
  );
  final int? id;
  final String latitude;
  final String longitude;
  final String country;
  final String state;
  final String locality;

  factory LocationEntity.fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      (json['id'] as num).toInt(),
      json['latitude'] as String,
      json['longitude'] as String,
      json['country'] as String,
      json['state'] as String,
      json['locality'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'Latitude': latitude,
        'longitude': longitude,
        'country': country,
        'state': state,
        'locality': locality
      };

  @override
  List<Object?> get props => [];
}
