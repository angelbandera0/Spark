part of 'list_unparked_bloc.dart';

@immutable
abstract class ListUnparkedEvent {}

class ListUnparkedInitialEvent extends ListUnparkedEvent {}

class ListUnparkedSentEvent extends ListUnparkedEvent {
  ListUnparkedSentEvent(
      this.orderBy, this.orderDirection, this.pageNumber, this.pageSize);
  final String orderBy;
  final String orderDirection;
  final int pageNumber;
  final int pageSize;
}
