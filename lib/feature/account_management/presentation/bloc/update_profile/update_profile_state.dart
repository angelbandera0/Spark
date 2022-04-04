part of 'update_profile_bloc.dart';

@immutable
abstract class UpdateProfileState {}

class UpdateProfileInitialState extends UpdateProfileState {}

class UpdateProfileSentState extends UpdateProfileState {}

class UpdateProfileSuccessState extends UpdateProfileState {}

class UpdateProfileErrorState extends UpdateProfileState {}

class RequestVerificationCodeSentState extends UpdateProfileState {}

class RequestVerificationCodeErrorState extends UpdateProfileState {}

class RequestVerificationCodeSuccessState extends UpdateProfileState {}

class UploadAvatarSentState extends UpdateProfileState {}

class UploadAvatarErrorState extends UpdateProfileState {}

class UploadAvatarSuccessState extends UpdateProfileState {}
