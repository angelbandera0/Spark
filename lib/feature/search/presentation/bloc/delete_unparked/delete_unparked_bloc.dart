import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/search/domain/entity/delete_unparked_request_entity.dart';
import 'package:sparkz/feature/search/domain/usecases/delete_unparked_usecase.dart';

part 'delete_unparked_event.dart';
part 'delete_unparked_state.dart';

class DeleteUnparkedBloc extends Bloc<DeleteUnparkedEvent, DeleteUnparkedState>
    with Utils {
  DeleteUnparkedBloc(this.deleteUnparkedUseCase)
      : super(DeleteUnparkedInitialState());
  final DeleteUnparkedUseCase deleteUnparkedUseCase;

  @override
  Stream<DeleteUnparkedState> mapEventToState(
      DeleteUnparkedEvent event) async* {
    if (event is DeleteUnparkedInitialState) {
      yield DeleteUnparkedInitialState();
    }

    if (event is DeleteUnparkedSentEvent) {
      yield DeleteUnparkedSentState();

      final resp = await deleteUnparkedUseCase(
          Params(DeleteUnparkedRequestEntity(event.id)));

      yield resp.fold((l) {
        showException(message: l.message);
        return DeleteUnparkedErrorState();
      }, (r) => DeleteUnparkedSuccessState());
    }
  }
}
