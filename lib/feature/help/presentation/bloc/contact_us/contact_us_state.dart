part of 'contact_us_bloc.dart';

@immutable
abstract class ContactUsState {}

class ContactUsInitialState extends ContactUsState {}

class ContactUsSentState extends ContactUsState {}

class ContactUsErrorState extends ContactUsState {}

class ContactUsSuccessState extends ContactUsState {}
