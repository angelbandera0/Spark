part of 'list_car_bloc.dart';

@immutable
abstract class ListCarState {}

class ListCarInitialState extends ListCarState {}

class ListCarSentState extends ListCarState {}

class ListCarErrorState extends ListCarState {}

class ListCarSuccessState extends ListCarState {}

