import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/car/domain/entity/delete_car_request_entity.dart';
import 'package:sparkz/feature/car/domain/repository/car_repository.dart';

class DeleteCarUseCase implements UserCase<bool, Params> {
  DeleteCarUseCase(this._repository);
  final CarRepository _repository;

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await _repository.deleteCar(params.entity);
  }
}

class Params extends Equatable {
  Params(this.entity);
  final DeleteCarRequestEntity entity;

  @override
  List<Object?> get props => [];
}
