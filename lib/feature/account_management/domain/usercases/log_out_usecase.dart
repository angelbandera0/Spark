import 'package:sparkz/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/account_management/domain/repository/account_management_repository.dart';

class LogOutUseCase implements UserCase<bool, NoParams> {
  LogOutUseCase(this._repository);
  final AccountManagementRepository _repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await _repository.logOut();
  }
}
