part of 'get_active_car_bloc.dart';

@immutable
abstract class GetActiveCarEvent {}

class GetActiveCarInitialEvent extends GetActiveCarEvent {}

class GetActiveCarSentEvent extends GetActiveCarEvent {
  GetActiveCarSentEvent();
}
