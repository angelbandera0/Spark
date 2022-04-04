import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/feature/help/domain/entity/contact_us_request_entity.dart';
import 'package:sparkz/feature/help/domain/entity/contact_us_response_entity.dart';
import 'package:sparkz/feature/help/domain/repository/help_repository.dart';

class ContactUsUseCase implements UserCase<ContactUsResponseEntity, Params> {
  ContactUsUseCase(this._repository);
  final HelpRepository _repository;

  @override
  Future<Either<Failure, ContactUsResponseEntity>> call(Params params) async {
    return await _repository.contactUs(params.contactUs);
  }
}

class Params extends Equatable {
  Params(this.contactUs);
  final ContactUsRequestEntity contactUs;

  @override
  List<Object?> get props => [];
}
