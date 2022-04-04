import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/account_management/domain/entity/sign_up_entity.dart';
import 'package:sparkz/feature/account_management/domain/repository/account_management_repository.dart';

class SignUpUserCase implements UserCase<bool, Params> {
  final AccountManagementRepository repository;

  SignUpUserCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.singUp(params.signUpEntity);
  }
}

class Params extends Equatable {
  Params(this.signUpEntity);
  final SigUpEntity signUpEntity;

  @override
  List<Object> get props => [];
}
