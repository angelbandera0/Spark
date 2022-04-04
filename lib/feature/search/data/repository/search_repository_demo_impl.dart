import 'package:dartz/dartz.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/feature/search/domain/entity/add_unparked_entity.dart';
import 'package:sparkz/feature/search/domain/entity/add_unparked_response_entity.dart';
import 'package:sparkz/feature/search/domain/entity/delete_unparked_request_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_compatible_spots_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_compatible_spots_response_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_unparked_request_entity.dart';
import 'package:sparkz/feature/search/domain/entity/submit_bid_request_entity.dart';
import 'package:sparkz/feature/search/domain/entity/submit_bid_response_entity.dart';

import 'package:sparkz/feature/search/domain/repository/search_repository.dart';

class SearchRepositoryDemoImpl extends SearchRepository {
  @override
  Future<Either<Failure, AddUnparkedResponseEntity>> addUnparked(
      AddUnparkedEntity request) async {
    return Future.delayed(Duration(microseconds: 1000), () {
      return Right(AddUnparkedResponseEntity(0));
    });
  }

  @override
  Future<Either<Failure, List<ListCompatibleSpotsResponseEntity>>>
      listCompatibleSpots(ListCompatibleSpotsEntity request) {
    // TODO: implement listCompatibleSpots
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteUnparked(
      DeleteUnparkedRequestEntity request) {
    // TODO: implement deleteUnparked
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<AddUnparkedEntity>>> listUnparked(
      ListUnparkedRequestEntity request) {
    // TODO: implement listUnparked
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, SubmitBidResponseEntity>> submitBid(
      SubmitBidRequestEntity request) {
    // TODO: implement submitBid
    throw UnimplementedError();
  }
}
