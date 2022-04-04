import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sparkz/core/global/data/user_profile.dart';
import 'package:sparkz/core/usercases/usercases.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity.dart';
import 'package:sparkz/feature/car/domain/usercases/get_active_car_usecase.dart';

part 'get_active_car_state.dart';
part 'get_active_car_event.dart';

class GetActiveCarBloc extends Bloc<GetActiveCarEvent, GetActiveCarState>
    with Utils {
  GetActiveCarBloc(this._getActiveCarUseCase, this._userProfile)
      : super(GetActiveCarInitialState());

  final GetActiveCarUseCase _getActiveCarUseCase;
  // ignore: close_sinks
  final BehaviorSubject<CarEntity> _subject = BehaviorSubject<CarEntity>();
  final UserProfile _userProfile;
  @override
  Stream<GetActiveCarState> mapEventToState(GetActiveCarEvent event) async* {
    if (event is GetActiveCarInitialEvent) {
      yield GetActiveCarInitialState();
    }

    if (event is GetActiveCarSentEvent) {
      yield GetActiveCarSentState();

      final resp = await _getActiveCarUseCase(NoParams());

      yield resp.fold((l) {
        _userProfile.setActiveCar(CarEntity('', '', '', '', ''));
        if (l.message ==
            "Object reference not set to an instance of an object.") {
          Future.delayed(Duration(seconds: 3)).whenComplete(
              () => showException(message: "You must have an active car"));
          return GetNoActiveCarState();
        } else {
          showException(message: l.message);
          return GetActiveCarErrorState();
        }
      }, (r) {
        _userProfile.setActiveCar(r);
        return GetActiveCarSuccessState();
      });
    }
  }

  BehaviorSubject<CarEntity> get subject => _subject;
}
