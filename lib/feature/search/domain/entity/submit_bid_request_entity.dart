import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class SubmitBidRequestEntity extends Equatable {
  SubmitBidRequestEntity(
      {required this.parkedId, required this.unparkedId, required this.bid});
  final int parkedId;
  final int unparkedId;
  final double bid;

  Map<String, dynamic> toJson() =>
      {"parkedId": parkedId, "unParkedId": unparkedId, "bid": bid};

  @override
  List<Object?> get props => [];
}
