import 'package:equatable/equatable.dart';

class ListCompatibleSpotsEntity extends Equatable {
  final String? orderBy;
  final String? orderDirection;
  final int? pageNumber;
  final int? pageSize;
  final String desiredTimeFrom;
  final String desiredTimeTo;
  final String desiredSize;
  final String latitude;
  final String longitude;
  final String country;
  final String state;
  final String locality;
  final String brand;
  final String color;
  final String model;
  final String plateNumber;

  ListCompatibleSpotsEntity(
      {required this.desiredSize,
      required this.brand,
      required this.color,
      required this.model,
      required this.plateNumber,
      this.orderBy,
      this.orderDirection,
      this.pageNumber,
      this.pageSize,
      required this.desiredTimeFrom,
      required this.desiredTimeTo,
      required this.latitude,
      required this.longitude,
      required this.country,
      required this.state,
      required this.locality});

  @override
  List<Object?> get props => [];
}
