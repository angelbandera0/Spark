import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/search/domain/entity/add_unparked_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_unparked_request_entity.dart';
import 'package:sparkz/feature/search/domain/repository/search_repository.dart';

class ListUnparkedUseCase implements UserCase<List<AddUnparkedEntity>, Params> {
  ListUnparkedUseCase(this._repository);
  final SearchRepository _repository;

  @override
  Future<Either<Failure, List<AddUnparkedEntity>>> call(Params params) async {
    return await _repository.listUnparked(params.listUnparkedRequest);
  }
}

class Params extends Equatable {
  Params(this.listUnparkedRequest);
  final ListUnparkedRequestEntity listUnparkedRequest;

  @override
  List<Object?> get props => [];
}
