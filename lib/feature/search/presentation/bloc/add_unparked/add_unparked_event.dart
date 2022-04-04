part of 'add_unparked_bloc.dart';

@immutable
abstract class AddUnparkedEvent {}

class AddUnparkedInitialEvent extends AddUnparkedEvent {}

class AddUnparkedSentEvent extends AddUnparkedEvent {
  AddUnparkedSentEvent(
      this.size,
      this.latitude,
      this.longitude,
      this.country,
      this.state,
      this.locality,
      this.fromDate,
      this.toDate,
      this.brand,
      this.color,
      this.model,
      this.plateNumber);
  final String size;

  final String latitude;
  final String longitude;
  final String country;
  final String state;
  final String locality;
  final String fromDate;
  final String toDate;
  final String brand;
  final String color;
  final String model;
  final String plateNumber;
}
