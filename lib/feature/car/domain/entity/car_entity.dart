import 'package:equatable/equatable.dart';

class CarEntity extends Equatable {
  final String brand;
  final String model;
  final String parkingSpotSize;
  final String plateNumber;
  final String color;

  CarEntity(this.brand, this.model, this.parkingSpotSize, this.plateNumber,
      this.color);

  factory CarEntity.fromJson(Map<String, dynamic> json) {
    return CarEntity(
      json['brand'] as String,
      json['model'] as String,
      json['parkingSpotSize'] as String,
      json['plateNumber'] as String,
      json['color'] as String,
    );
  }

  @override
  List<Object> get props => [];
}
