part of 'list_unparked_bloc.dart';

@immutable
abstract class ListUnparkedState {}

class ListUnparkedInitialState extends ListUnparkedState {}

class ListUnparkedSentState extends ListUnparkedState {}

class ListUnparkedErrorState extends ListUnparkedState {}

class ListUnparkedSuccessState extends ListUnparkedState {}

class ListUnparkedEmptyState extends ListUnparkedState {}
