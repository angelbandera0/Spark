part of 'delete_car_bloc.dart';

@immutable
abstract class DeleteCarState {}

class DeleteCarInitialState extends DeleteCarState {}

class DeleteCarSentState extends DeleteCarState {}

class DeleteCarErrorState extends DeleteCarState {}

class DeleteCarSuccessState extends DeleteCarState {}
