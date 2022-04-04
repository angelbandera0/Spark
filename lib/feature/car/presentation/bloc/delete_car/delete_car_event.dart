part of 'delete_car_bloc.dart';

@immutable
abstract class DeleteCarEvent {}

class DeleteCarInitialEvent extends DeleteCarEvent {}

class DeleteCarSentEvent extends DeleteCarEvent {
  DeleteCarSentEvent(this.id);
  final int id;
}
