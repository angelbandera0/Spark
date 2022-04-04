part of 'validate_phone_bloc.dart';

@immutable
abstract class ValidatePhoneEvent {}

/* Validation Code Events */
class ValidatePhoneInitialEvent extends ValidatePhoneEvent {}

class ValidatePhoneSentEvent extends ValidatePhoneEvent {
  ValidatePhoneSentEvent(this.email, this.code);
  final String email;
  final String code;
}

/* Refresh Validation Code Events */
class RefreshValidateCodeInitialEvent extends ValidatePhoneEvent {}

class RefreshValidateCodeSentEvent extends ValidatePhoneEvent {
  RefreshValidateCodeSentEvent(this.email);
  final String email;
}

/* Update Profile Events */
class UpdateUserProfileSentEvent extends ValidatePhoneEvent {
  UpdateUserProfileSentEvent(
      {this.name, this.email, this.country, this.number});
  final String? name;
  final String? email;
  final String? country;
  final String? number;
}

/* Validate New Requested Validation Code event */
class ValidateCodeRequestSentEvent extends ValidatePhoneEvent {
  ValidateCodeRequestSentEvent(this.phoneNumber, this.code);
  final String phoneNumber;
  final String code;
}
