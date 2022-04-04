import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sparkz/core/global/entities/phone_entity.dart';
import 'package:sparkz/core/utils/index.dart';
import 'package:sparkz/feature/account_management/domain/entity/sign_up_entity.dart';
import 'package:sparkz/feature/account_management/domain/usercases/sign_up_usercase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> with Utils {
  SignUpBloc(this._signUpUserCase) : super(SignUpInitial());
  final SignUpUserCase _signUpUserCase;

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    /* Initial */
    if (event is InitialSignUpEvent) {
      yield SignUpInitial();
    }

    if (event is SignUpSentEvent) {
      yield SingUpSentState();
      final resp = await _signUpUserCase(Params(SigUpEntity(
          event.fullName,
          event.pass,
          event.repass,
          event.email,
          PhoneEntity(event.code, event.number))));

      yield resp.fold((l) {
        showException(message: l.message);
        return SingUpErrorState();
      }, (r) => SingUpSuccessState());
    }
  }
}
