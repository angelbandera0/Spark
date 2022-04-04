part of 'edit_auction_bloc.dart';

@immutable
abstract class EditAuctionState {}

class EditAuctionInitialState extends EditAuctionState {}

class EditAuctionSentState extends EditAuctionState {}

class EditAuctionErrorState extends EditAuctionState {}

class EditAuctionSuccessState extends EditAuctionState {}
