import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AddUnparkedEntity extends Equatable {
  AddUnparkedEntity({
    this.id,
    required this.size,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.state,
    required this.locality,
    required this.timePeriodFrom,
    required this.timePeriodTo,
    required this.brand,
    required this.color,
    required this.model,
    required this.plateNumber,
  });
  int? id;
  final String size;
  final String latitude;
  final String longitude;
  final String country;
  final String state;
  final String locality;
  final String timePeriodFrom;
  final String? timePeriodTo;
  final String brand;
  final String color;
  final String model;
  final String plateNumber;

  Map<String, dynamic> toJson() => {
        "desiredTimeFrom": timePeriodFrom,
        "desiredTimeTo": timePeriodTo,
        "desiredSize": size,
        "location": {
          "latitude": latitude,
          "longitude": longitude,
          "country": country,
          "state": state,
          "locality": locality
        },
        "brand": brand,
        "color": color,
        "model": model,
        "plateNumber": plateNumber
      };

  factory AddUnparkedEntity.fromJson(Map<String, dynamic> json) {
    return AddUnparkedEntity(
        id: json['id'] ?? '',
        brand: json['brand'] as String,
        color: json['color'] as String,
        country: json['location']['country'] ?? '',
        latitude: json['location']['latitude'] ?? '',
        locality: json['location']['locality'] ?? '',
        longitude: json['location']['longitude'] ?? '',
        model: json['model'] as String,
        plateNumber: json['plateNumber'] as String,
        size: json['desiredSize'] as String,
        state: json['location']['state'] ?? '',
        timePeriodFrom: json['desiredTimeFrom'] as String,
        timePeriodTo: json['desiredTimeTo'] ?? '');
  }

  @override
  List<Object?> get props => [];
}
