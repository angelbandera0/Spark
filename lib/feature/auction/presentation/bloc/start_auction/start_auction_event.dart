part of 'start_auction_bloc.dart';

@immutable
abstract class StartAuctionEvent {}

class StartAuctionInitialEvent extends StartAuctionEvent {}

class StartAuctionSentEvent extends StartAuctionEvent {
  StartAuctionSentEvent(this.id);
  final int id;
}
