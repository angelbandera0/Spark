import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity_list.dart';
import 'package:sparkz/feature/car/domain/usercases/edit_car_usecase.dart';

part 'edit_car_event.dart';
part 'edit_car_state.dart';

class EditCarBloc extends Bloc<EditCarEvent, EditCarState> with Utils {
  EditCarBloc(this._editActionUseCase) : super(EditCarInitialState());

  final EditCarUseCase _editActionUseCase;

  @override
  Stream<EditCarState> mapEventToState(EditCarEvent event) async* {
    if (event is EditCarInitialEvent) {
      yield EditCarInitialState();
    }

    if (event is EditCarSentEvent) {
      yield EditCarSentState();

      final resp = await _editActionUseCase(Params(CarEntityList(
          event.id,
          0,
          event.brand,
          event.color,
          event.model,
          event.plateNumber,
          event.sizeType,
          true,
          "",
          "")));

      yield resp.fold((l) {
        showException(message: l.message);
        return EditCarErrorState();
      }, (r) => EditCarSuccessState());
    }
  }
}
