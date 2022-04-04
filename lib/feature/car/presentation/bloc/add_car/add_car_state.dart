part of 'add_car_bloc.dart';

@immutable
abstract class AddCarState {}

class AddCarInitialState extends AddCarState {}

class AddCarSentState extends AddCarState {}

class AddCarErrorState extends AddCarState {}

class AddCarSuccessState extends AddCarState {}
