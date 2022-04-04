import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/search/domain/entity/submit_bid_request_entity.dart';
import 'package:sparkz/feature/search/domain/entity/submit_bid_response_entity.dart';
import 'package:sparkz/feature/search/domain/repository/search_repository.dart';

class SubmitBidUseCase implements UserCase<SubmitBidResponseEntity, Params> {
  SubmitBidUseCase(this._repository);
  final SearchRepository _repository;

  @override
  Future<Either<Failure, SubmitBidResponseEntity>> call(Params params) async {
    return await _repository.submitBid(params.submitBid);
  }
}

class Params extends Equatable {
  Params(this.submitBid);
  final SubmitBidRequestEntity submitBid;

  @override
  List<Object?> get props => [];
}
