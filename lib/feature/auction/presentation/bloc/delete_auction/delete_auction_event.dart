part of 'delete_auction_bloc.dart';

@immutable
abstract class DeleteAuctionEvent {}

class DeleteAuctionInitialEvent extends DeleteAuctionEvent {}

class DeleteAuctionSentEvent extends DeleteAuctionEvent {
  DeleteAuctionSentEvent(this.id);
  final int id;
}
