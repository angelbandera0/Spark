part of 'list_compatible_spots_bloc.dart';

@immutable
abstract class ListCompatibleSpotsState {}

class ListCompatibleSpotsInitialState extends ListCompatibleSpotsState {}

class ListCompatibleSpotsSentState extends ListCompatibleSpotsState {}

class ListCompatibleSpotsErrorState extends ListCompatibleSpotsState {}

class ListCompatibleSpotsSuccessState extends ListCompatibleSpotsState {}

class ListCompatibleSpotsEmptyState extends ListCompatibleSpotsState {}
