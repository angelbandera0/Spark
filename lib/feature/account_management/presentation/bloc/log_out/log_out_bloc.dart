import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:sparkz/core/platform/shared_prefs.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/account_management/domain/usercases/log_out_usecase.dart';

part 'log_out_state.dart';
part 'log_out_event.dart';

class LogOutBloc extends Bloc<LogOutEvent, LogOutState> with Utils {
  LogOutBloc(this._logOutUseCase, this._sharedPreferencesManager)
      : super(LogOutInitialState());
  final LogOutUseCase _logOutUseCase;
  final SharedPreferencesManager _sharedPreferencesManager;

  @override
  Stream<LogOutState> mapEventToState(LogOutEvent event) async* {
    if (event is LogOutInitialEvent) {
      yield LogOutInitialState();
    }

    if (event is LogOutSentEvent) {
      yield LogOutSentState();

      var resp = await _logOutUseCase(NoParams());
      yield resp.fold((l) {
        showException(message: l.message);
        return LogOutErrorState();
      }, (r) {
        _sharedPreferencesManager.setAccessToken('');
        _sharedPreferencesManager.setRefreshToken('');
        _sharedPreferencesManager.setRememberMe(false);
        return LogOutSuccessState();
      });
    }
  }
}
