import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/search/domain/entity/list_compatible_spots_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_compatible_spots_response_entity.dart';
import 'package:sparkz/feature/search/domain/usecases/list_compatible_spots_usecase.dart';

part 'list_compatible_spots_state.dart';
part 'list_compatible_spots_event.dart';

class ListCompatibleSpotsBloc
    extends Bloc<ListCompatibleSpotsEvent, ListCompatibleSpotsState>
    with Utils {
  ListCompatibleSpotsBloc(this._listCompatibleSpotsUseCase)
      : super(ListCompatibleSpotsInitialState());

  final ListCompatibleSpotsUseCase _listCompatibleSpotsUseCase;
  // ignore: close_sinks
  final BehaviorSubject<List<ListCompatibleSpotsResponseEntity>> _subject =
      BehaviorSubject<List<ListCompatibleSpotsResponseEntity>>();

  @override
  Stream<ListCompatibleSpotsState> mapEventToState(
      ListCompatibleSpotsEvent event) async* {
    if (event is ListCompatibleSpotsInitialEvent) {
      yield ListCompatibleSpotsInitialState();
    }

    if (event is ListCompatibleSpotsSentEvent) {
      yield ListCompatibleSpotsSentState();

      final resp = await _listCompatibleSpotsUseCase(Params(
          ListCompatibleSpotsEntity(
              orderBy: event.orderBy,
              orderDirection: event.orderDirection,
              pageNumber: event.pageNumber,
              pageSize: event.pageSize,
              country: event.country,
              latitude: event.latitude,
              locality: event.locality,
              longitude: event.longitude,
              desiredTimeTo: event.desiredTimeTo,
              state: event.state,
              desiredTimeFrom: event.desiredTimeFrom,
              brand: event.brand,
              color: event.color,
              desiredSize: event.desiredSize,
              model: event.model,
              plateNumber: event.plateNumber)));

      yield resp.fold((l) {
        showException(message: l.message);
        return ListCompatibleSpotsErrorState();
      }, (r) {
        if (r.isNotEmpty) {
          _subject.sink.add(r);
          return ListCompatibleSpotsSuccessState();
        } else {
          return ListCompatibleSpotsEmptyState();
        }
      });
    }
  }

  BehaviorSubject<List<ListCompatibleSpotsResponseEntity>> get subject =>
      _subject;
}
