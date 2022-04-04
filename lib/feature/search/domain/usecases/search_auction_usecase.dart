import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';

import 'package:sparkz/feature/search/domain/entity/add_unparked_entity.dart';
import 'package:sparkz/feature/search/domain/entity/add_unparked_response_entity.dart';
import 'package:sparkz/feature/search/domain/repository/search_repository.dart';

class AddUnparkedUseCase
    implements UserCase<AddUnparkedResponseEntity, Params> {
  AddUnparkedUseCase(this._repository);
  final SearchRepository _repository;

  @override
  Future<Either<Failure, AddUnparkedResponseEntity>> call(Params params) async {
    return await _repository.addUnparked(params.addUnparkedRequest);
  }
}

class Params extends Equatable {
  Params(this.addUnparkedRequest);
  final AddUnparkedEntity addUnparkedRequest;

  @override
  List<Object?> get props => [];
}
