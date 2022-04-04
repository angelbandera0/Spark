part of 'publish_auction_bloc.dart';

@immutable
abstract class PublishAuctionState {}

class PublishAuctionInitialState extends PublishAuctionState {}

class PublishAuctionSentState extends PublishAuctionState {}

class PublishAuctionErrorState extends PublishAuctionState {}

class PublishAuctionSuccessState extends PublishAuctionState {}
