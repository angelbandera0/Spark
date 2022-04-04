import 'package:dartz/dartz.dart';
import 'package:sparkz/core/failure/exception.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/platform/connectivity.dart';
import 'package:sparkz/feature/search/data/datasource/search_remote_api.dart';

import 'package:sparkz/feature/search/domain/entity/add_unparked_entity.dart';
import 'package:sparkz/feature/search/domain/entity/add_unparked_response_entity.dart';
import 'package:sparkz/feature/search/domain/entity/delete_unparked_request_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_compatible_spots_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_compatible_spots_response_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_unparked_request_entity.dart';
import 'package:sparkz/feature/search/domain/entity/submit_bid_request_entity.dart';
import 'package:sparkz/feature/search/domain/entity/submit_bid_response_entity.dart';
import 'package:sparkz/feature/search/domain/repository/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  SearchRepositoryImpl(this.connectivityService, this._api);
  final ConnectivityService connectivityService;
  final SearchRemoteApi _api;

  @override
  Future<Either<Failure, AddUnparkedResponseEntity>> addUnparked(
      AddUnparkedEntity request) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }
      final res = await _api.addUnparked(request);
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
  Future<Either<Failure, List<AddUnparkedEntity>>> listUnparked(
      ListUnparkedRequestEntity request) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }
      final res = await _api.listUnparked(request);
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
  Future<Either<Failure, List<ListCompatibleSpotsResponseEntity>>>
      listCompatibleSpots(ListCompatibleSpotsEntity request) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }
      final res = await _api.listCompatibleSpots(request);
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
  Future<Either<Failure, bool>> deleteUnparked(
      DeleteUnparkedRequestEntity unparked) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }
      await _api.deleteUnparked(unparked);
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
  Future<Either<Failure, SubmitBidResponseEntity>> submitBid(
      SubmitBidRequestEntity request) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }
      final res = await _api.submitBid(request);
      return Right(res);
    } catch (ex) {
      if (ex is ServerException) {
        return Left(ServerFailure(ex.message));
      } else {
        return Left(OtherFailure());
      }
    }
  }
}
