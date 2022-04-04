import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/account_management/domain/entity/validate_phone_entity.dart';
import 'package:sparkz/feature/account_management/domain/repository/account_management_repository.dart';

class ValidatePhoneUseCase implements UserCase<bool, Params> {
  ValidatePhoneUseCase(this._repository);
  final AccountManagementRepository _repository;

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await _repository.validatePhone(params.entity);
  }
}

class Params extends Equatable {
  Params(this.entity);
  final ValidatePhoneEntity entity;

  @override
  List<Object?> get props => [];
}
