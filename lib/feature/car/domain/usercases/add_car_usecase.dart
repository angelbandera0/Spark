import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/car/domain/entity/card_entity_add.dart';
import 'package:sparkz/feature/car/domain/repository/car_repository.dart';

class AddCarUseCase implements UserCase<bool, Params> {
  AddCarUseCase(this._repository);
  final CarRepository _repository;

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await _repository.addCar(params.carAdd);
  }
}

class Params extends Equatable {
  Params(this.carAdd);
  final CarEntityAdd carAdd;

  @override
  List<Object?> get props => [];
}
