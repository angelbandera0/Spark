import 'package:sparkz/core/failure/exception.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sparkz/core/platform/connectivity.dart';
import 'package:sparkz/feature/auction/data/datasource/auction_remote_api.dart';
import 'package:sparkz/feature/auction/data/model/list_auction_response_model.dart';
import 'package:sparkz/feature/auction/domain/entity/delete_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/list_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/start_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/repository/auction_repository.dart';

class AuctionRepositoryImpl extends AuctionRepository {
  AuctionRepositoryImpl(this.connectivityService, this._api);
  final ConnectivityService connectivityService;
  final AuctionRemoteApi _api;

  @override
  Future<Either<Failure, List<ListAuctionResponseModel>>> listAuction(
      ListAuctionRequesEntity request) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }

      final res = await _api.listAuction(request);
      return Right(res);
    } catch (ex) {
      if (ex is ServerException) {
        return Left(ServerFailure(ex.message));
      } else {
        return Left(OtherFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> addAuction(ParkedEntity parkedEntity) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }

      await _api.addAuction(parkedEntity);
      return Right(true);
    } catch (ex) {
      if (ex is ServerException) {
        return Left(ServerFailure(ex.message));
      } else {
        return Left(OtherFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> editAuction(ParkedEntity parkedEntity) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }

      await _api.editAuction(parkedEntity);
      return Right(true);
    } catch (ex) {
      if (ex is ServerException) {
        return Left(ServerFailure(ex.message));
      } else {
        return Left(OtherFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAuction(
      DeleteAuctionRequestEntity entity) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }

      await _api.deleteAuction(entity);
      return Right(true);
    } catch (ex) {
      if (ex is ServerException) {
        return Left(ServerFailure(ex.message));
      } else {
        return Left(OtherFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> startAuction(
      StartAuctionRequestEntity entity) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }

      await _api.startAuction(entity);
      return Right(true);
    } catch (ex) {
      if (ex is ServerException) {
        return Left(ServerFailure(ex.message));
      } else {
        return Left(OtherFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ListAuctionResponseModel>> publishAuction(
      ParkedEntity parkedEntity) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }

      final res = await _api.publishAuction(parkedEntity);
      return Right(res);
    } catch (ex) {
      if (ex is ServerException) {
        return Left(ServerFailure(ex.message));
      } else if (ex is PublishAuctionException) {
        return Left(PublishAuctionFailure(ex.message));
      } else {
        return Left(OtherFailure());
      }
    }
  }
}
