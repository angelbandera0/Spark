import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/search/domain/entity/list_compatible_spots_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_compatible_spots_response_entity.dart';
import 'package:sparkz/feature/search/domain/repository/search_repository.dart';

class ListCompatibleSpotsUseCase
    implements UserCase<List<ListCompatibleSpotsResponseEntity>, Params> {
  ListCompatibleSpotsUseCase(this._repository);
  final SearchRepository _repository;

  @override
  Future<Either<Failure, List<ListCompatibleSpotsResponseEntity>>> call(
      Params params) async {
    return await _repository
        .listCompatibleSpots(params.listCompatibleSpotsEntity);
  }
}

class Params extends Equatable {
  Params(this.listCompatibleSpotsEntity);
  final ListCompatibleSpotsEntity listCompatibleSpotsEntity;

  @override
  List<Object?> get props => [];
}
