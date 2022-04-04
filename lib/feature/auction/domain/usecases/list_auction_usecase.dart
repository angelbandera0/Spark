import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/auction/data/model/list_auction_response_model.dart';
import 'package:sparkz/feature/auction/domain/entity/list_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/repository/auction_repository.dart';

class ListAuctionUseCase
    implements UserCase<List<ListAuctionResponseModel>, Params> {
  ListAuctionUseCase(this._repository);
  final AuctionRepository _repository;

  @override
  Future<Either<Failure, List<ListAuctionResponseModel>>> call(
      Params params) async {
    return await _repository.listAuction(params.listAuctionRequest);
  }
}

class Params extends Equatable {
  Params(this.listAuctionRequest);
  final ListAuctionRequesEntity listAuctionRequest;

  @override
  List<Object?> get props => [];
}
