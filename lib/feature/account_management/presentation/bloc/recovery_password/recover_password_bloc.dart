import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sparkz/core/utils/index.dart';
import 'package:sparkz/feature/account_management/domain/entity/recover_password_entity.dart';
import 'package:sparkz/feature/account_management/domain/usercases/recover_password_usecase.dart';

part 'recover_password_event.dart';
part 'recover_password_state.dart';

class RecoverPasswordBloc
    extends Bloc<RecoverPasswordEvent, RecoverPasswordState> with Utils {
  RecoverPasswordBloc(this._recoverPasswordUseCase)
      : super(RecoverPasswordInitialState());

  final RecoverPasswordUseCase _recoverPasswordUseCase;

  @override
  Stream<RecoverPasswordState> mapEventToState(
      RecoverPasswordEvent event) async* {
    if (event is RecoveryPasswordInitialEvent) {
      yield RecoverPasswordInitialState();
    }

    if (event is RecoverPasswordSentEvent) {
      yield RecoverPasswordSentState();

      final resp = await _recoverPasswordUseCase(Params(RecoverPasswordEntity(
          event.code, event.password, event.confirmPassword)));

      yield resp.fold((l) {
        showException(message: l.message);
        return RecoverPasswordErrorState();
      }, (r) => RecoverPasswordSuccessState());
    }
  }
}
