import 'package:equatable/equatable.dart';

class ListCompatibleSpotsResponseEntity extends Equatable {
  ListCompatibleSpotsResponseEntity({
    required this.id,
    required this.locationId,
    required this.size,
    required this.waitTime,
    required this.minimunBid,
    required this.isActive,
    required this.location,
  });

  final int id;
  final int locationId;
  final String size;
  final int waitTime;
  final double minimunBid;
  final bool isActive;
  final Location location;

  factory ListCompatibleSpotsResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      ListCompatibleSpotsResponseEntity(
        id: json["id"],
        locationId: json["locationId"],
        size: json["size"],
        waitTime: json["waitTime"],
        minimunBid: json["minimunBid"],
        isActive: json["isActive"],
        location: Location.fromJson(json["location"]),
      );

  @override
  List<Object?> get props => [];
}

class Location {
  Location({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.state,
    required this.locality,
  });

  int id;
  String latitude;
  String longitude;
  String country;
  String state;
  String locality;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        country: json["country"],
        state: json["state"],
        locality: json["locality"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "country": country,
        "state": state,
        "locality": locality,
      };
}
