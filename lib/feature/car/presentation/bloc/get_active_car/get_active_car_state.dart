part of 'get_active_car_bloc.dart';

@immutable
abstract class GetActiveCarState {}

class GetActiveCarInitialState extends GetActiveCarState {}

class GetActiveCarSentState extends GetActiveCarState {}

class GetActiveCarErrorState extends GetActiveCarState {}

class GetActiveCarSuccessState extends GetActiveCarState {}

class GetNoActiveCarState extends GetActiveCarState {}
