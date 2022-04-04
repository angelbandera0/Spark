import 'package:dartz/dartz.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/account_management/domain/repository/account_management_repository.dart';

class LogInRememberUseCase implements UserCase<bool, NoParams> {
  LogInRememberUseCase(this.repository);
  final AccountManagementRepository repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.logInCredential();
  }
}
