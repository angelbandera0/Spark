part of 'edit_car_bloc.dart';

@immutable
abstract class EditCarEvent {}

class EditCarInitialEvent extends EditCarEvent {}

class EditCarSentEvent extends EditCarEvent {
  EditCarSentEvent(
      this.id, this.brand, this.color, this.model, this.plateNumber, this.sizeType);

  final int id; 
  final String brand;
  final String color;
  final String model;
  final String plateNumber;
  final int sizeType;
}
