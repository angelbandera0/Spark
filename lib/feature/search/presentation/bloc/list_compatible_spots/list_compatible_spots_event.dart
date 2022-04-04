part of 'list_compatible_spots_bloc.dart';

@immutable
abstract class ListCompatibleSpotsEvent {}

class ListCompatibleSpotsInitialEvent extends ListCompatibleSpotsEvent {}

class ListCompatibleSpotsSentEvent extends ListCompatibleSpotsEvent {
  ListCompatibleSpotsSentEvent(
      {required this.orderBy,
      required this.orderDirection,
      required this.pageNumber,
      required this.pageSize,
      required this.desiredTimeFrom,
      required this.desiredTimeTo,
      required this.desiredSize,
      required this.latitude,
      required this.longitude,
      required this.country,
      required this.state,
      required this.locality,
      required this.brand,
      required this.color,
      required this.model,
      required this.plateNumber});

  final String orderBy;
  final String orderDirection;
  final int pageNumber;
  final int pageSize;
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
}
