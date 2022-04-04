import 'package:dartz/dartz.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity_activate.dart';
import 'package:sparkz/feature/car/domain/entity/card_entity_add.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity_list.dart';
import 'package:sparkz/feature/car/domain/entity/delete_car_request_entity.dart';
import 'package:sparkz/feature/car/domain/entity/list_card_request_entity.dart';

abstract class CarRepository {
  Future<Either<Failure, List<CarEntityList>>> listCars(
      ListCardRequstEntity request);
  Future<Either<Failure, bool>> addCar(CarEntityAdd car);
  Future<Either<Failure, bool>> editCar(CarEntityList car);
  Future<Either<Failure, bool>> deleteCar(DeleteCarRequestEntity car);
  Future<Either<Failure, bool>> activateCar(CarEntityActivate car);
  Future<Either<Failure, CarEntity>> getActiveCar();
}
