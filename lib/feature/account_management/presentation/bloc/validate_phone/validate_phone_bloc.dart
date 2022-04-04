import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/utils/index.dart';

/* ENTITY*/
import 'package:sparkz/feature/account_management/domain/entity/refresh_validate_code_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/update_profile_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/validate_phone_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/validate_requested_code_entity.dart';

/* USE CASE*/
import 'package:sparkz/feature/account_management/domain/usercases/validate_phone_usecase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/validate_phone_usecase.dart'
    as validateParam;
import 'package:sparkz/feature/account_management/domain/usercases/refresh_validate_code_usecase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/refresh_validate_code_usecase.dart'
    as refrehParam;
import 'package:sparkz/feature/account_management/domain/usercases/update_profile_usecase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/update_profile_usecase.dart'
    as updateProfileParams;
import 'package:sparkz/feature/account_management/domain/usercases/validate_requested_code_usecase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/validate_requested_code_usecase.dart'
    as requestedCodeParams;

part 'validate_phone_event.dart';
part 'validate_phone_state.dart';

class ValidatePhoneBloc extends Bloc<ValidatePhoneEvent, ValidatePhoneState>
    with Utils {
  ValidatePhoneBloc(
    this._validatePhoneUseCase,
    this._refreshValidateCodeUseCase,
    this._updateProfileUseCase,
    this._validateRequestedCodeUseCase,
  ) : super(ValidatePhoneInitialState());

  final ValidatePhoneUseCase _validatePhoneUseCase;
  final RefreshValidateCodeUseCase _refreshValidateCodeUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final ValidateRequestedCodeUseCase _validateRequestedCodeUseCase;

  @override
  Stream<ValidatePhoneState> mapEventToState(ValidatePhoneEvent event) async* {
    if (event is ValidatePhoneInitialEvent) {
      yield ValidatePhoneInitialState();
    }

    if (event is ValidatePhoneSentEvent) {
      yield ValidatePhoneSentState();
      final resp = await _validatePhoneUseCase(
          validateParam.Params(ValidatePhoneEntity(event.email, event.code)));

      yield resp.fold((l) {
        if (l is ServerFailure) {
          showException(message: l.message);
        }
        return ValidatePhoneErrorState();
      }, (r) => ValidatePhoneSuccessState());
    }

    if (event is RefreshValidateCodeSentEvent) {
      yield RefreshValidateCodeSentState();
      final resp = await _refreshValidateCodeUseCase(
          refrehParam.Params(RefreshValidateCodeEntity(event.email)));
      resp.fold((l) {
        showException(message: l.message);
      }, (r) {});
    }

    if (event is UpdateUserProfileSentEvent) {
      yield UpdateUserProfileSentState();

      final resp = await _updateProfileUseCase(updateProfileParams.Params(
          UpdateProfileEntity(
              name: event.name,
              email: event.email,
              number: event.number,
              country: event.country)));

      yield resp.fold((l) {
        showException(message: l.message);
        return UpdateUserProfileErrorState();
      }, (r) {
        showMessage(message: 'User information has been updated');
        return UpdateUserProfileSuccessState();
      });
    }


    if (event is ValidateCodeRequestSentEvent) {
      yield ValidateCodeRequestSentState();

      final resp = await _validateRequestedCodeUseCase(
          requestedCodeParams.Params(
              ValidateRequestedCodeEntity(event.phoneNumber, event.code)));

      yield resp.fold((l) {
        if (l is ServerFailure) {
          showException(message: l.message);
        }
        return ValidateCodeRequestErrorState();
      }, (r) => ValidateCodeRequestSuccessState());
    }
  }
}
