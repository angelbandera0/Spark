import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/car/domain/entity/delete_car_request_entity.dart';
import 'package:sparkz/feature/car/domain/usercases/delete_car_usecase.dart';

part 'delete_car_event.dart';
part 'delete_car_state.dart';

class DeleteCarBloc extends Bloc<DeleteCarEvent, DeleteCarState> with Utils {
  DeleteCarBloc(this.deleteCarUseCase) : super(DeleteCarInitialState());
  final DeleteCarUseCase deleteCarUseCase;

  @override
  Stream<DeleteCarState> mapEventToState(DeleteCarEvent event) async* {
    if (event is DeleteCarInitialState) {
      yield DeleteCarInitialState();
    }

    if (event is DeleteCarSentEvent) {
      yield DeleteCarSentState();

      final resp =
          await deleteCarUseCase(Params(DeleteCarRequestEntity(event.id)));

      yield resp.fold((l) {
        showException(message: l.message);
        return DeleteCarErrorState();
      }, (r) => DeleteCarSuccessState());
    }
  }
}
