import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/auction/domain/entity/delete_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/repository/auction_repository.dart';

class DeleteAuctionUseCase implements UserCase<bool, Params> {
  DeleteAuctionUseCase(this._repository);
  final AuctionRepository _repository;

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await _repository.deleteAuction(params.entity);
  }
}

class Params extends Equatable {
  Params(this.entity);
  final DeleteAuctionRequestEntity entity;

  @override
  List<Object?> get props => [];
}
