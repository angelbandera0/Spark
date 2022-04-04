part of 'add_auction_bloc.dart';

@immutable
abstract class AddAuctionEvent {}

class AddAuctionInitialEvent extends AddAuctionEvent {}

class AddAuctionSentEvent extends AddAuctionEvent {
  AddAuctionSentEvent(this.size, this.waitTime, this.minimunBid, this.isActive,
      this.latitude, this.longitude, this.country, this.state, this.locality);

  final String size;
  final int waitTime;
  final double minimunBid;
  final bool isActive;
  final String latitude;
  final String longitude;
  final String country;
  final String state;
  final String locality;
}
