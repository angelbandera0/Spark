import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity_activate.dart';
import 'package:sparkz/feature/car/domain/repository/car_repository.dart';

class ActivateCarUseCase implements UserCase<bool, Params> {
  ActivateCarUseCase(this._repository);
  final CarRepository _repository;

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await _repository.activateCar(params.car);
  }
}

class Params extends Equatable {
  Params(this.car);
  final CarEntityActivate car;

  @override
  List<Object?> get props => [];
}
