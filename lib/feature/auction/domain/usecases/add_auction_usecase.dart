import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';
import 'package:sparkz/feature/auction/domain/repository/auction_repository.dart';

class AddAuctionUseCase implements UserCase<bool, Params> {
  AddAuctionUseCase(this._repository);
  final AuctionRepository _repository;

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await _repository.addAuction(params.parkedEntity);
  }
}

class Params extends Equatable {
  Params(this.parkedEntity);
  final ParkedEntity parkedEntity;

  @override
  List<Object?> get props => [];
}
