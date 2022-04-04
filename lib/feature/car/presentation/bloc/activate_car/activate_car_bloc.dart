import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sparkz/core/utils/index.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity_activate.dart';
import 'package:sparkz/feature/car/domain/usercases/activate_car_usecase.dart';

part 'activate_car_event.dart';
part 'activate_car_state.dart';

class ActivateCarBloc extends Bloc<ActivateCarEvent, ActivateCarState>
    with Utils {
  ActivateCarBloc(this._activateActionUseCase)
      : super(ActivateCarInitialState());

  final ActivateCarUseCase _activateActionUseCase;

  @override
  Stream<ActivateCarState> mapEventToState(ActivateCarEvent event) async* {
    if (event is ActivateCarInitialEvent) {
      yield ActivateCarInitialState();
    }

    if (event is ActivateCarSentEvent) {
      yield ActivateCarSentState();

      final resp = await _activateActionUseCase(
          Params(CarEntityActivate(event.id, event.active)));

      yield resp.fold((l) {
        showException(message: l.message);
        return ActivateCarErrorState();
      }, (r) => ActivateCarSuccessState());
    }
  }
}
