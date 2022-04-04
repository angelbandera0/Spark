part of 'submit_bid_bloc.dart';

@immutable
abstract class SubmitBidEvent {}

class SubmitBidInitialEvent extends SubmitBidEvent {}

class SubmitBidSentEvent extends SubmitBidEvent {
  SubmitBidSentEvent(this.parkedId, this.unparkedId, this.bid);

  final int parkedId;
  final int unparkedId;
  final double bid;
}
