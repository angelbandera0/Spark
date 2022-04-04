import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/account_management/domain/entity/avatar_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/avatar_response_entity.dart';
import 'package:sparkz/feature/account_management/domain/repository/account_management_repository.dart';

class UpdateAvatarUseCase implements UserCase<AvatarResponseEntity, Params> {
  UpdateAvatarUseCase(this._repository);
  final AccountManagementRepository _repository;

  @override
  Future<Either<Failure, AvatarResponseEntity>> call(Params params) async {
    return await _repository.uploadAvatar(params.entity);
  }
}

class Params extends Equatable {
  Params(this.entity);
  final AvatarEntity entity;

  @override
  List<Object?> get props => [];
}
