import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkz/core/platform/signalr_service.dart';
import 'package:sparkz/core/utils/index.dart';
import 'package:sparkz/feature/car/domain/usercases/submit_bid_usecase.dart';
import 'package:sparkz/feature/search/domain/entity/submit_bid_request_entity.dart';

part 'submit_bid_state.dart';
part 'submit_bid_event.dart';

class SubmitBidBloc extends Bloc<SubmitBidEvent, SubmitBidState> with Utils {
  SubmitBidBloc(this._submitBidUseCase, this.signalRService)
      : super(SubmitBidInitialState());
  final SubmitBidUseCase _submitBidUseCase;
  final SignalRService signalRService;

  @override
  Stream<SubmitBidState> mapEventToState(SubmitBidEvent event) async* {
    if (event is SubmitBidInitialEvent) {
      yield SubmitBidInitialState();
    }

    if (event is SubmitBidSentEvent) {
      yield SubmitBidSentState();

      var submitBidRequestEntity = SubmitBidRequestEntity(
          bid: event.bid,
          parkedId: event.parkedId,
          unparkedId: event.unparkedId);

      final resp = await _submitBidUseCase(Params(submitBidRequestEntity));
      yield resp.fold((l) {
        showException(message: l.message);
        return SubmitBidErrorState();
      }, (r) {
        signalRService.addToGroup(event.parkedId.toString());
        showMessage(message: 'The Bid has been submitted successfully');
        return SubmitBidSuccessState();
      });
    }
  }
}
