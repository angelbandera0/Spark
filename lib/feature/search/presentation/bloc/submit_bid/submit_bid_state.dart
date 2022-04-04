part of 'submit_bid_bloc.dart';

@immutable
abstract class SubmitBidState {}

class SubmitBidInitialState extends SubmitBidState {}

class SubmitBidSentState extends SubmitBidState {}

class SubmitBidErrorState extends SubmitBidState {}

class SubmitBidSuccessState extends SubmitBidState {}
