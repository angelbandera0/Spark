import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkz/core/utils/index.dart';
import 'package:sparkz/feature/car/domain/entity/card_entity_add.dart';
import 'package:sparkz/feature/car/domain/usercases/add_car_usecase.dart';

part 'add_car_state.dart';
part 'add_car_event.dart';

class AddCarBloc extends Bloc<AddCarEvent, AddCarState> with Utils {
  AddCarBloc(this._addCarUseCase) : super(AddCarInitialState());
  final AddCarUseCase _addCarUseCase;

  @override
  Stream<AddCarState> mapEventToState(AddCarEvent event) async* {
    if (event is AddCardInitialEvent) {
      yield AddCarInitialState();
    }

    if (event is AddCarSentEvent) {
      yield AddCarSentState();

      var carEntityAdd = CarEntityAdd(event.brand, event.color, event.model,
          event.plateNumber, event.sizeType);

      final resp = await _addCarUseCase(Params(carEntityAdd));

      yield resp.fold((l) {
        showException(message: l.message);
        return AddCarErrorState();
      }, (r) => AddCarSuccessState());
    }
  }
}
