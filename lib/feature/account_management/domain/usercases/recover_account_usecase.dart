import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/account_management/domain/entity/recover_account_entity.dart';
import 'package:sparkz/feature/account_management/domain/repository/account_management_repository.dart';

class RecoverAccountUseCase implements UserCase<bool, Params> {
  final AccountManagementRepository _repository;

  RecoverAccountUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await _repository.recoverAccount(params.recoverAccountEntity);
  }
}

class Params extends Equatable {
  Params(this.recoverAccountEntity);
  final RecoverAccountEntity recoverAccountEntity;

  @override
  List<Object> get props => [];
}
