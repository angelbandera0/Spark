import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/account_management/domain/entity/log_in_entity.dart';
import 'package:sparkz/feature/account_management/domain/repository/account_management_repository.dart';

class LogInUserCase implements UserCase<bool, Params> {
  final AccountManagementRepository repository;

  LogInUserCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.logIn(params.logInEntity);
  }
}

class Params extends Equatable {
  final LogInEntity logInEntity;

  Params(this.logInEntity);

  @override
  List<Object> get props => [];
}
