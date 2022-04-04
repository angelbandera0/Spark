import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity_list.dart';
import 'package:sparkz/feature/car/domain/entity/list_card_request_entity.dart';
import 'package:sparkz/feature/car/domain/usercases/list_car_usecase.dart';


part 'list_car_state.dart';
part 'list_car_event.dart';

class ListCarBloc extends Bloc<ListCarEvent, ListCarState> with Utils {
  ListCarBloc(this._listCarUseCase) : super(ListCarInitialState());

  final ListCarUseCase _listCarUseCase;
  final BehaviorSubject<List<CarEntityList>> _subject =
      BehaviorSubject<List<CarEntityList>>();

  @override
  Stream<ListCarState> mapEventToState(ListCarEvent event) async* {
    if (event is ListCarInitialEvent) {
      yield ListCarInitialState();
    }

    if (event is ListCarSentEvent) {
      yield ListCarSentState();

      final resp = await _listCarUseCase(Params(ListCardRequstEntity(
          event.orderBy,
          event.orderDirection,
          event.pageNumber,
          event.pageSize)));

      yield resp.fold((l) {
        showException(message: l.message);
        return ListCarErrorState();
      }, (r) {
        _subject.sink.add(r);
        return ListCarSuccessState();
      });
    }

  }

  BehaviorSubject<List<CarEntityList>> get subject => _subject;

}
