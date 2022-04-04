part of 'add_auction_bloc.dart';

@immutable
abstract class AddAuctionState {}

class AddAuctionInitialState extends AddAuctionState {}

class AddAuctionSentState extends AddAuctionState {}

class AddAuctionErrorState extends AddAuctionState {}

class AddAuctionSuccessState extends AddAuctionState {}
