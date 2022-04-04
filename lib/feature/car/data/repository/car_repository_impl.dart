import 'package:sparkz/core/failure/exception.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sparkz/core/platform/connectivity.dart';
import 'package:sparkz/feature/car/data/datasource/card_remote_api.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity_activate.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity_list.dart';
import 'package:sparkz/feature/car/domain/entity/card_entity_add.dart';
import 'package:sparkz/feature/car/domain/entity/delete_car_request_entity.dart';
import 'package:sparkz/feature/car/domain/entity/list_card_request_entity.dart';
import 'package:sparkz/feature/car/domain/repository/car_repository.dart';

class CardRepositoryImpl extends CarRepository {
  CardRepositoryImpl(this.connectivityService, this._api);
  final ConnectivityService connectivityService;
  final CardRemoteApi _api;

  @override
  Future<Either<Failure, List<CarEntityList>>> listCars(
      ListCardRequstEntity request) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }
      final res = await _api.listCards(request);
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
  Future<Either<Failure, bool>> addCar(CarEntityAdd car) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }

      await _api.addCar(car);
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
  Future<Either<Failure, bool>> editCar(CarEntityList car) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }

      await _api.editCar(car);
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
  Future<Either<Failure, bool>> deleteCar(DeleteCarRequestEntity car) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }
      await _api.deleteCar(car);
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
  Future<Either<Failure, bool>> activateCar(CarEntityActivate car) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }

      await _api.activateCar(car);
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
  Future<Either<Failure, CarEntity>> getActiveCar() async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }
      final res = await _api.getActiveCar();
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
