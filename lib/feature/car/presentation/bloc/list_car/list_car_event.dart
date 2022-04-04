part of 'list_car_bloc.dart';

@immutable
abstract class ListCarEvent {}

class ListCarInitialEvent extends ListCarEvent {}

class ListCarSentEvent extends ListCarEvent {
  ListCarSentEvent(
      this.orderBy, this.orderDirection, this.pageNumber, this.pageSize);
  final String orderBy;
  final String orderDirection;
  final int pageNumber;
  final int pageSize;
}



