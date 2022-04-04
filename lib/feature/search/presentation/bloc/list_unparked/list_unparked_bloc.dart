import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sparkz/core/global/data/user_profile.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/search/domain/entity/add_unparked_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_unparked_request_entity.dart';
import 'package:sparkz/feature/search/domain/usecases/list_unparked_usecase.dart';

part 'list_unparked_state.dart';
part 'list_unparked_event.dart';

class ListUnparkedBloc extends Bloc<ListUnparkedEvent, ListUnparkedState>
    with Utils {
  ListUnparkedBloc(this._listUnparkedUseCase, this._userProfile)
      : super(ListUnparkedInitialState());

  final ListUnparkedUseCase _listUnparkedUseCase;
  final UserProfile _userProfile;
  // ignore: close_sinks
  final BehaviorSubject<List<AddUnparkedEntity>> _subject =
      BehaviorSubject<List<AddUnparkedEntity>>();

  @override
  Stream<ListUnparkedState> mapEventToState(ListUnparkedEvent event) async* {
    if (event is ListUnparkedInitialEvent) {
      yield ListUnparkedInitialState();
    }

    if (event is ListUnparkedSentEvent) {
      yield ListUnparkedSentState();

      final resp = await _listUnparkedUseCase(Params(ListUnparkedRequestEntity(
          event.orderBy,
          event.orderDirection,
          event.pageNumber,
          event.pageSize)));

      yield resp.fold((l) {
        _userProfile.setUnparked([]);
        showException(message: l.message);
        return ListUnparkedErrorState();
      }, (r) {
        if (r.isNotEmpty) {
          _userProfile.setUnparked(r);
          return ListUnparkedSuccessState();
        } else {
          return ListUnparkedEmptyState();
        }
      });
    }
  }

  BehaviorSubject<List<AddUnparkedEntity>> get subject => _subject;
}
