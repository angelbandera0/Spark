import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import 'package:sparkz/core/global/data/user_profile.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/account_management/domain/entity/avatar_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/request_verification_code_entity.dart';
import 'package:sparkz/feature/account_management/domain/entity/update_profile_entity.dart';
import 'package:sparkz/feature/account_management/domain/usercases/request_verification_code_usecase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/update_profile_usecase.dart';

import 'package:sparkz/feature/account_management/domain/usercases/request_verification_code_usecase.dart'
    as VerificationCode;
import 'package:sparkz/feature/account_management/domain/usercases/update_profile_usecase.dart'
    as UpdateProfile;
import 'package:sparkz/feature/account_management/domain/usercases/upload_avatar_usecase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/upload_avatar_usecase.dart'
    as AvatarUpload;

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState>
    with Utils {
  UpdateProfileBloc(
    this._updateProfileUseCase,
    this._requestVerificationCodeUseCase,
    this._avatarUseCase,
    this._userProfile,
  ) : super(UpdateProfileInitialState());

  final UpdateProfileUseCase _updateProfileUseCase;
  final RequestVerificationCodeUseCase _requestVerificationCodeUseCase;
  final UpdateAvatarUseCase _avatarUseCase;
  final UserProfile _userProfile;

  @override
  Stream<UpdateProfileState> mapEventToState(UpdateProfileEvent event) async* {
    if (event is UpdateProfileInitialEvent) {
      yield UpdateProfileInitialState();
    }

    if (event is UpdateProfileSentEvent) {
      yield UpdateProfileSentState();

      final resp = await _updateProfileUseCase(UpdateProfile.Params(
          UpdateProfileEntity(name: event.name, email: event.email)));

      yield resp.fold((l) {
        showException(message: l.message);
        return UpdateProfileErrorState();
      }, (r) {
        return UpdateProfileSuccessState();
      });
    }

    if (event is RequestVerificationCodeSentEvent) {
      yield RequestVerificationCodeSentState();

      final resp = await _requestVerificationCodeUseCase(
          VerificationCode.Params(
              RequestVerificationCodeEntity(event.phoneNumber)));

      yield resp.fold((l) {
        showException(message: l.message);
        return RequestVerificationCodeErrorState();
      }, (r) {
        return RequestVerificationCodeSuccessState();
      });
    }

    if (event is UpdateImageEvent) {
      yield UploadAvatarSentState();

      final picked = await pickImage(event.source);
      if (picked != null) {
        final resp = await _avatarUseCase(AvatarUpload.Params(AvatarEntity(
            picked.readAsBytes().asStream(), picked.lengthSync())));

        yield resp.fold((l) {
          showException(message: l.message);
          return UpdateProfileErrorState();
        }, (r) {
          _userProfile.setAvatar(r.avatar);
          _userProfile.setAvatarMimeType(r.avatarMimeType);
          return UploadAvatarSuccessState();
        });
      } else {
        yield UpdateProfileErrorState();
      }
    }
    if (event is UpdateImageEventCamera) {
      yield UploadAvatarSentState();

      final resp = await _avatarUseCase(AvatarUpload.Params(AvatarEntity(
          event.source.readAsBytes().asStream(), event.source.lengthSync())));

      yield resp.fold((l) {
        showException(message: l.message);
        return UpdateProfileErrorState();
      }, (r) {
        _userProfile.setAvatar(r.avatar);
        _userProfile.setAvatarMimeType(r.avatarMimeType);
        return UploadAvatarSuccessState();
      });
    }
  }

  Future<File?> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;
      return File(image.path);
    } on PlatformException catch (e) {
      showException(message: 'Failed to pick image: $e');
    }
  }
}
