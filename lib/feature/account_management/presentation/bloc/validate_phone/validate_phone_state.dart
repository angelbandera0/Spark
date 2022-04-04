part of 'validate_phone_bloc.dart';

@immutable
abstract class ValidatePhoneState {}

/* Validate Code States */
class ValidatePhoneInitialState extends ValidatePhoneState {}

class ValidatePhoneSentState extends ValidatePhoneState {}

class ValidatePhoneErrorState extends ValidatePhoneState {}

class ValidatePhoneSuccessState extends ValidatePhoneState {}

/* Resend Validation Code States */
class RefreshValidateCodeInitialState extends ValidatePhoneState {}

class RefreshValidateCodeErrorState extends ValidatePhoneState {}

class RefreshValidateCodeSentState extends ValidatePhoneState {}

class RefreshValidateCodeSuccessState extends ValidatePhoneState {}

class WrongValidatePhoneState extends ValidatePhoneState {}

/* Update User Profile States */
class UpdateUserProfileSentState extends ValidatePhoneState {}

class UpdateUserProfileErrorState extends ValidatePhoneState {}

class UpdateUserProfileSuccessState extends ValidatePhoneState {}

/* Validate New Requested Validation Code States */
class ValidateCodeRequestSentState extends ValidatePhoneState {}

class ValidateCodeRequestErrorState extends ValidatePhoneState {}

class ValidateCodeRequestSuccessState extends ValidatePhoneState {}
