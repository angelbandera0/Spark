part of 'delete_auction_bloc.dart';

@immutable
abstract class DeleteAuctionState {}

class DeleteAuctionInitialState extends DeleteAuctionState {}

class DeleteAuctionSentState extends DeleteAuctionState {}

class DeleteAuctionErrorState extends DeleteAuctionState {}

class DeleteAuctionSuccessState extends DeleteAuctionState {}
