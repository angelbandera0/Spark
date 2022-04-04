part of 'update_profile_bloc.dart';

@immutable
abstract class UpdateProfileEvent {}

class UpdateProfileInitialEvent extends UpdateProfileEvent {}

class UpdateProfileSentEvent extends UpdateProfileEvent {
  UpdateProfileSentEvent(this.name, this.email);

  final String name;
  final String email;
}

class RequestVerificationCodeSentEvent extends UpdateProfileEvent {
  RequestVerificationCodeSentEvent(this.phoneNumber);
  final String phoneNumber;
}

class UpdateImageEvent extends UpdateProfileEvent {
  final ImageSource source;
  UpdateImageEvent(this.source);

}
class UpdateImageEventCamera extends UpdateProfileEvent {
  final File source;
  UpdateImageEventCamera(this.source);
}
