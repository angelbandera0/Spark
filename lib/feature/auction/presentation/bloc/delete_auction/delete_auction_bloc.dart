import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/auction/domain/entity/delete_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/usecases/delete_auction_usecase.dart';

part 'delete_auction_event.dart';
part 'delete_auction_state.dart';

class DeleteAuctionBloc extends Bloc<DeleteAuctionEvent, DeleteAuctionState>
    with Utils {
  DeleteAuctionBloc(this.deleteAuctionUseCase)
      : super(DeleteAuctionInitialState());
  final DeleteAuctionUseCase deleteAuctionUseCase;

  @override
  Stream<DeleteAuctionState> mapEventToState(DeleteAuctionEvent event) async* {
    if (event is DeleteAuctionInitialState) {
      yield DeleteAuctionInitialState();
    }

    if (event is DeleteAuctionSentEvent) {
      yield DeleteAuctionSentState();

      final resp = await deleteAuctionUseCase(
          Params(DeleteAuctionRequestEntity(event.id)));

      yield resp.fold((l) {
        showException(message: l.message);
        return DeleteAuctionErrorState();
      }, (r) => DeleteAuctionSuccessState());
    }
  }
}
