import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/search/domain/entity/delete_unparked_request_entity.dart';
import 'package:sparkz/feature/search/domain/repository/search_repository.dart';

class DeleteUnparkedUseCase implements UserCase<bool, Params> {
  DeleteUnparkedUseCase(this._repository);
  final SearchRepository _repository;

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await _repository.deleteUnparked(params.entity);
  }
}

class Params extends Equatable {
  Params(this.entity);
  final DeleteUnparkedRequestEntity entity;

  @override
  List<Object?> get props => [];
}
