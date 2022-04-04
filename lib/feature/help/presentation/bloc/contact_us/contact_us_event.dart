part of 'contact_us_bloc.dart';

@immutable
abstract class ContactUsEvent {}

class ContactUsInitialEvent extends ContactUsEvent {}

class ContactUsSentEvent extends ContactUsEvent {
  ContactUsSentEvent(this.body);

  final String body;
}
