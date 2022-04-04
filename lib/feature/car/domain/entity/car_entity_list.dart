import 'package:equatable/equatable.dart';

class CarEntityList extends Equatable {
  final int id;
  final int userId;
  final String brand;
  final String color;
  final String model;
  final String plateNumber;
  final int sizeType;
  final bool isActive;
  final String createdAt;
  final String modifiedAt;

  CarEntityList(
      this.id,
      this.userId,
      this.brand,
      this.color,
      this.model,
      this.plateNumber,
      this.sizeType,
      this.isActive,
      this.createdAt,
      this.modifiedAt);

  int get carId => id;
  String get carBrand => brand;
  String get carColor => color;
  String get carModel => model;
  int get carSizeType => sizeType;
  String get carPlateNumber => plateNumber;

  factory CarEntityList.fromJson(Map<String, dynamic> json) {
    return CarEntityList(
        (json['id'] as num).toInt(),
        (json['userId'] as num).toInt(),
        json['brand'] as String,
        json['color'] as String,
        json['model'] as String,
        json['plateNumber'] as String,
        (json['sizeType'] as num).toInt(),
        json['isActive'] as bool,
        json['createdAt'] as String,
        json['modifiedAt'] as String);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'brand': brand,
        'color': color,
        'model': model,
        'plateNumber': plateNumber,
        'sizeType': sizeType,
        'isActive': isActive,
        'createdAt': createdAt,
        'modifiedAt': modifiedAt
      };

  @override
  List<Object?> get props => [];
}
