import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sparkz/core/platform/shared_prefs.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/core/utils/index.dart';
import 'package:sparkz/feature/account_management/domain/entity/log_in_entity.dart';
import 'package:sparkz/feature/account_management/domain/usercases/log_in_credential_usercase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/log_in_usercase.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> with Utils {
  final LogInUserCase logInUserCase;
  final LogInRememberUseCase logInCredentialCase;
  final SharedPreferencesManager sharedPreferencesManager;

  LogInBloc(this.logInUserCase, this.logInCredentialCase,
      this.sharedPreferencesManager)
      : super(LogInInitial());

  @override
  Stream<LogInState> mapEventToState(
    LogInEvent event,
  ) async* {
    if (event is LogInRememberEvent) {
      bool remember = await sharedPreferencesManager.getRememberMe();
      if (remember) {
        yield LogInSentState();
        final resp = await logInCredentialCase(NoParams());
        yield resp.fold((l) {
          showException(message: l.message);
          return LogInFailState();
        }, (r) => LogInSuccessState());
      }
    }

    if (event is LogInSendEvent) {
      yield LogInSentState();
      final resp =
          await logInUserCase(Params(LogInEntity(event.email, event.pass)));
      yield resp.fold((l) {
        showException(message: l.message);
        return LogInFailState();
      }, (r) {
        sharedPreferencesManager.setRememberMe(event.remember);
        return LogInSuccessState();
      });
    }
  }
}
