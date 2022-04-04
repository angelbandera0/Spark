import 'package:dartz/dartz.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/feature/auction/data/model/list_auction_response_model.dart';
import 'package:sparkz/feature/auction/domain/entity/delete_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/list_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/start_auction_request_entity.dart';

abstract class AuctionRepository {
  Future<Either<Failure, List<ListAuctionResponseModel>>> listAuction(
      ListAuctionRequesEntity request);
  Future<Either<Failure, bool>> addAuction(ParkedEntity parkedEntity);
  Future<Either<Failure, bool>> editAuction(ParkedEntity parkedEntity);
  Future<Either<Failure, bool>> deleteAuction(
      DeleteAuctionRequestEntity entity);
  Future<Either<Failure, bool>> startAuction(StartAuctionRequestEntity entity);
  Future<Either<Failure, ListAuctionResponseModel>> publishAuction(
      ParkedEntity parkedEntity);
}
