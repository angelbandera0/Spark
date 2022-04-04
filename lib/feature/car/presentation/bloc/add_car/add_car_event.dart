part of 'add_car_bloc.dart';

@immutable
abstract class AddCarEvent {}

class AddCardInitialEvent extends AddCarEvent {}

class AddCarSentEvent extends AddCarEvent {
  AddCarSentEvent(
      this.brand, this.color, this.model, this.plateNumber, this.sizeType);

  final String brand;
  final String color;
  final String model;
  final String plateNumber;
  final int sizeType;
}
