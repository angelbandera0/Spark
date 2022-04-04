part of 'activate_car_bloc.dart';

@immutable
abstract class ActivateCarEvent {}

class ActivateCarInitialEvent extends ActivateCarEvent {}

class ActivateCarSentEvent extends ActivateCarEvent {
  ActivateCarSentEvent(this.id, this.active);

  final int id;
  final bool active;
}
