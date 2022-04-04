import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sparkz/core/global/data/user_profile.dart';
import 'package:sparkz/core/utils/utils.dart';

import 'package:sparkz/feature/search/domain/entity/add_unparked_entity.dart';
import 'package:sparkz/feature/search/domain/entity/add_unparked_response_entity.dart';
import 'package:sparkz/feature/search/domain/usecases/search_auction_usecase.dart';

part 'add_unparked_state.dart';
part 'add_unparked_event.dart';

class AddUnparkedBloc extends Bloc<AddUnparkedEvent, AddUnparkedState>
    with Utils {
  AddUnparkedBloc(this._addUnparkedUseCase, this._userProfile)
      : super(AddUnparkedInitialState());

  final UserProfile _userProfile;
  final AddUnparkedUseCase _addUnparkedUseCase;
  final BehaviorSubject<List<AddUnparkedResponseEntity>> _subject =
      BehaviorSubject<List<AddUnparkedResponseEntity>>();

  @override
  Stream<AddUnparkedState> mapEventToState(AddUnparkedEvent event) async* {
    if (event is AddUnparkedInitialEvent) {
      yield AddUnparkedInitialState();
    }
    if (event is AddUnparkedSentEvent) {
      yield AddUnparkedSentState();

      var unparkedEntityAdd = AddUnparkedEntity(
        size: event.size,
        latitude: event.latitude,
        longitude: event.longitude,
        country: event.country,
        state: event.state,
        locality: event.locality,
        brand: event.brand,
        color: event.color,
        model: event.model,
        plateNumber: event.plateNumber,
        timePeriodFrom: event.fromDate,
        timePeriodTo: event.toDate,
      );

      final resp = await _addUnparkedUseCase(Params(unparkedEntityAdd));

      yield resp.fold((l) {
        _userProfile.setUnparked([]);
        showException(message: l.message);
        return AddUnparkedErrorState();
      }, (r) {
        unparkedEntityAdd.id = r.response;
        _userProfile.setUnparked([unparkedEntityAdd]);
        return AddUnparkedSuccessState();
      });
    }
  }

  BehaviorSubject<List<AddUnparkedResponseEntity>> get subject => _subject;

  dispose() {
    _subject.close();
  }
}
