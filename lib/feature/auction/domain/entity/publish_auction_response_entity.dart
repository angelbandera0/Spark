import 'package:equatable/equatable.dart';
import 'package:sparkz/feature/auction/data/model/list_auction_response_model.dart';

class PublishAuctionResponseEntity extends Equatable {
  PublishAuctionResponseEntity(this.response);
  final ListAuctionResponseModel response;
  @override
  List<Object?> get props => [];
}
