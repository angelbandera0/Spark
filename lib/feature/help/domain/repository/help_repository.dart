import 'package:dartz/dartz.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/feature/help/domain/entity/contact_us_request_entity.dart';
import 'package:sparkz/feature/help/domain/entity/contact_us_response_entity.dart';

abstract class HelpRepository {
  Future<Either<Failure, ContactUsResponseEntity>> contactUs(
      ContactUsRequestEntity contactUs);
}
