import 'package:sparkz/core/failure/exception.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sparkz/core/platform/connectivity.dart';
import 'package:sparkz/feature/help/data/datasource/help_remote_api.dart';
import 'package:sparkz/feature/help/domain/entity/contact_us_request_entity.dart';
import 'package:sparkz/feature/help/domain/entity/contact_us_response_entity.dart';
import 'package:sparkz/feature/help/domain/repository/help_repository.dart';

class HelpRepositoryImpl extends HelpRepository {
  HelpRepositoryImpl(this.connectivityService, this._api);
  final ConnectivityService connectivityService;
  final HelpRemoteApi _api;

  @override
  Future<Either<Failure, ContactUsResponseEntity>> contactUs(
      ContactUsRequestEntity contactUs) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }

      await _api.contactUs(contactUs);
      return Right(ContactUsResponseEntity(true));
    } catch (ex) {
      if (ex is ServerException) {
        return Left(ServerFailure(ex.message));
      } else {
        return Left(OtherFailure());
      }
    }
  }
}
