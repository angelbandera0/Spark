import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/account_management/domain/entity/recover_account_entity.dart';
import 'package:sparkz/feature/account_management/domain/usercases/recover_account_usecase.dart';

part 'recover_account_event.dart';
part 'recover_account_state.dart';

class RecoverAccountBloc extends Bloc<RecoverAccountEvent, RecoverAccountState>
    with Utils {
  RecoverAccountBloc(this._recoverAccountUseCase)
      : super(RecoverAccountInitialState());

  final RecoverAccountUseCase _recoverAccountUseCase;

  @override
  Stream<RecoverAccountState> mapEventToState(
      RecoverAccountEvent event) async* {
    if (event is RecoverAccountInitialEvent) {
      yield RecoverAccountInitialState();
    }

    if (event is RecoverAccountSentEvent) {
      yield RecoverAccountSentState();
      final resp = await _recoverAccountUseCase(
          Params(RecoverAccountEntity(event.email)));

      yield resp.fold((l) {
        if (l is ServerFailure) {
          showException(message: l.message);
        }
        return RecoverAccountErrorState();
      }, (r) => RecoverAccountSuccessState());
    }
  }
}
