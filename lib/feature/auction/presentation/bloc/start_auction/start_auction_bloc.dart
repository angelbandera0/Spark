import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sparkz/core/platform/signalr_service.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/auction/domain/entity/start_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/usecases/start_auction_usecase.dart';

part 'start_auction_event.dart';
part 'start_auction_state.dart';

class StartAuctionBloc extends Bloc<StartAuctionEvent, StartAuctionState>
    with Utils {
  StartAuctionBloc(this.startAuctionUseCase, this.signalRService)
      : super(StartAuctionInitialState());
  final StartAuctionUseCase startAuctionUseCase;
  final SignalRService signalRService;

  @override
  Stream<StartAuctionState> mapEventToState(StartAuctionEvent event) async* {
    if (event is StartAuctionInitialState) {
      yield StartAuctionInitialState();
    }

    if (event is StartAuctionSentEvent) {
      yield StartAuctionSentState();
      final resp = await startAuctionUseCase(
          Params(StartAuctionRequestEntity(event.id)));

      yield resp.fold((l) {
        showException(message: l.message);
        return StartAuctionErrorState();
      }, (r) {
        signalRService.addToGroup(event.id.toString());
        return StartAuctionSuccessState();
      });
    }
  }
}
