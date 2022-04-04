part of 'delete_unparked_bloc.dart';

@immutable
abstract class DeleteUnparkedEvent {}

class DeleteUnparkedInitialEvent extends DeleteUnparkedEvent {}

class DeleteUnparkedSentEvent extends DeleteUnparkedEvent {
  DeleteUnparkedSentEvent(this.id);
  final int id;
}
