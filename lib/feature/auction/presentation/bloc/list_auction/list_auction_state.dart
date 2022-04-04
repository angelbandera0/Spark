part of 'list_auction_bloc.dart';

@immutable
abstract class ListAuctionState {}

class ListAuctionInitialState extends ListAuctionState {}

class ListAuctionSentState extends ListAuctionState {}

class ListAuctionErrorState extends ListAuctionState {}

class ListAuctionSuccessState extends ListAuctionState {}
