part of 'list_auction_bloc.dart';

@immutable
abstract class ListAuctionEvent {}

class ListAuctionInitialEvent extends ListAuctionEvent {}

class ListAuctionSentEvent extends ListAuctionEvent {
  ListAuctionSentEvent(this.pageNumber, this.pageSize);
  final int pageNumber;
  final int pageSize;
}
