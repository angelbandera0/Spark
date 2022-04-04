part of 'edit_car_bloc.dart';

@immutable
abstract class EditCarState {}

class EditCarInitialState extends EditCarState {}

class EditCarSentState extends EditCarState {}

class EditCarErrorState extends EditCarState {}

class EditCarSuccessState extends EditCarState {}
