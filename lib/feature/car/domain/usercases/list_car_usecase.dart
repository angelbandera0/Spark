import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity_list.dart';
import 'package:sparkz/feature/car/domain/entity/list_card_request_entity.dart';
import 'package:sparkz/feature/car/domain/repository/car_repository.dart';

class ListCarUseCase implements UserCase<List<CarEntityList>, Params> {
  ListCarUseCase(this._repository);
  final CarRepository _repository;

  @override
  Future<Either<Failure, List<CarEntityList>>> call(Params params) async {
    return await _repository.listCars(params.listCarRequest);
  }
}

class Params extends Equatable {
  Params(this.listCarRequest);
  final ListCardRequstEntity listCarRequest;

  @override
  List<Object?> get props => [];
}
