import 'package:dartz/dartz.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/feature/account_management/domain/entity/avatar_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/avatar_response_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/log_in_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/recover_account_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/recover_password_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/refresh_validate_code_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/request_verification_code_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/sign_up_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/update_profile_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/validate_phone_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/validate_requested_code_entity.dart';

abstract class AccountManagementRepository {
  Future<Either<Failure, bool>> logIn(LogInEntity logInEntity);
  Future<Either<Failure, bool>> logInCredential();
  Future<Either<Failure, bool>> singUp(SigUpEntity signUpEntity);
  Future<Either<Failure, bool>> recoverAccount(
      RecoverAccountEntity recoverAccountEntity);
  Future<Either<Failure, bool>> validatePhone(
      ValidatePhoneEntity validatePhoneEntity);
  Future<Either<Failure, bool>> refreshValidateCode(
      RefreshValidateCodeEntity refreshValidateCodeEntity);
  Future<Either<Failure, bool>> recoverPassword(
      RecoverPasswordEntity recoverPasswordEntity);
  Future<Either<Failure, bool>> logOut();
  Future<Either<Failure, bool>> updateProfile(
      UpdateProfileEntity updateProfileEntity);
  Future<Either<Failure, bool>> requestVerificationCode(
      RequestVerificationCodeEntity requestVerificationCode);
  Future<Either<Failure, AvatarResponseEntity>> uploadAvatar(
      AvatarEntity avatarEntity);
  Future<Either<Failure, bool>> validateRequestedCode(
      ValidateRequestedCodeEntity codeEntity);
}
