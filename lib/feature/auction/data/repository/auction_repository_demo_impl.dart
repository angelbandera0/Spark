import 'package:sparkz/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sparkz/feature/auction/data/model/list_auction_response_model.dart';
import 'package:sparkz/feature/auction/domain/entity/delete_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/list_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/location_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/start_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/repository/auction_repository.dart';

class AuctionRepositoryDemoImpl extends AuctionRepository {
  @override
  Future<Either<Failure, List<ListAuctionResponseModel>>> listAuction(
      ListAuctionRequesEntity request) async {
    return Future.delayed(Duration(microseconds: 1000), () {
      return Right(List<ListAuctionResponseModel>.filled(
          1,
          ListAuctionResponseModel(0, 0, "MidSize", 0, 10, true,
              LocationEntity(0, "10", "10", "test", "test", "test"))));
    });
  }

  @override
  Future<Either<Failure, bool>> addAuction(ParkedEntity parkedEntity) {
    return Future.delayed(Duration(microseconds: 1000), () {
      return Right(true);
    });
  }

  @override
  Future<Either<Failure, bool>> editAuction(ParkedEntity parkedEntity) {
    return Future.delayed(Duration(microseconds: 1000), () {
      return Right(true);
    });
  }

  @override
  Future<Either<Failure, bool>> deleteAuction(
      DeleteAuctionRequestEntity entity) {
    return Future.delayed(Duration(microseconds: 1000), () {
      return Right(true);
    });
  }

  @override
  Future<Either<Failure, bool>> startAuction(StartAuctionRequestEntity entity) {
    return Future.delayed(Duration(microseconds: 1000), () {
      return Right(true);
    });
  }

  @override
  Future<Either<Failure, ListAuctionResponseModel>> publishAuction(
      ParkedEntity parkedEntity) {
    return Future.delayed(Duration(microseconds: 1000), () {
      return Right(ListAuctionResponseModel(0, 0, "MidSize", 0, 10, true,
          LocationEntity(0, "10", "10", "test", "test", "test")));
    });
  }
}
