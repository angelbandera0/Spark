import 'package:dartz/dartz.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity.dart';
import 'package:sparkz/feature/car/domain/repository/car_repository.dart';

class GetActiveCarUseCase implements UserCase<CarEntity, NoParams> {
  GetActiveCarUseCase(this._repository);
  final CarRepository _repository;

  @override
  Future<Either<Failure, CarEntity>> call(NoParams params) async {
    return await _repository.getActiveCar();
  }
}
