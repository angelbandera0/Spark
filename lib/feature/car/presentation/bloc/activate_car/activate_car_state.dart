part of 'activate_car_bloc.dart';

@immutable
abstract class ActivateCarState {}

class ActivateCarInitialState extends ActivateCarState {}

class ActivateCarSentState extends ActivateCarState {}

class ActivateCarErrorState extends ActivateCarState {}

class ActivateCarSuccessState extends ActivateCarState {}
