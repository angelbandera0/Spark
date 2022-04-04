part of 'edit_auction_bloc.dart';

@immutable
abstract class EditAuctionEvent {}

class EditAuctionInitialEvent extends EditAuctionEvent {}

class EditAuctionSentEvent extends EditAuctionEvent {
  EditAuctionSentEvent(
    this.id,
    this.locationId,
    this.size,
    this.waitTime,
    this.minimunBid,
    this.isActive,
    this.latitude,
    this.longitude,
    this.country,
    this.state,
    this.locality,
  );

  final int id;
  final int locationId;
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
