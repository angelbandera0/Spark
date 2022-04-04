part of 'start_auction_bloc.dart';

@immutable
abstract class StartAuctionState {}

class StartAuctionInitialState extends StartAuctionState {}

class StartAuctionSentState extends StartAuctionState {}

class StartAuctionErrorState extends StartAuctionState {}

class StartAuctionSuccessState extends StartAuctionState {}
