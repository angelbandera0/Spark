import 'package:equatable/equatable.dart';

class CarEntityAdd extends Equatable {
  final String brand;
  final String color;
  final String model;
  final String plateNumber;
  final int? sizeType;

  CarEntityAdd(
      this.brand, this.color, this.model, this.plateNumber, this.sizeType);

  Map<String, dynamic> toJson() => {
        'brand': brand,
        'color': color,
        'model': model,
        'plateNumber': plateNumber,
        'sizeType': sizeType
      };

  @override
  List<Object?> get props => [];
}
