import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/account_management/domain/entity/refresh_validate_code_entity.dart';
import 'package:sparkz/feature/account_management/domain/repository/account_management_repository.dart';

class RefreshValidateCodeUseCase implements UserCase<bool, Params> {
  RefreshValidateCodeUseCase(this._repository);
  final AccountManagementRepository _repository;

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await _repository.refreshValidateCode(params.entity);
  }
}

class Params extends Equatable {
  Params(this.entity);
  final RefreshValidateCodeEntity entity;

  @override
  List<Object?> get props => [];
}
