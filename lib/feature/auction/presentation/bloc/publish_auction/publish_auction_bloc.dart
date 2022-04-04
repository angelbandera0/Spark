import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/platform/signalr_service.dart';
import 'package:sparkz/core/utils/index.dart';
import 'package:sparkz/feature/auction/domain/entity/location_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';
import 'package:sparkz/feature/auction/domain/usecases/publish_auction_usecase.dart';

part 'publish_auction_state.dart';
part 'publish_auction_event.dart';

class PublishAuctionBloc extends Bloc<PublishAuctionEvent, PublishAuctionState>
    with Utils {
  PublishAuctionBloc(this._publishAuctionUseCase, this.signalRService)
      : super(PublishAuctionInitialState());
  final PublishAuctionUseCase _publishAuctionUseCase;
  final SignalRService signalRService;

  @override
  Stream<PublishAuctionState> mapEventToState(
      PublishAuctionEvent event) async* {
    if (event is PublishAuctionInitialEvent) {
      yield PublishAuctionInitialState();
    }

    if (event is PublishAuctionSentEvent) {
      yield PublishAuctionSentState();

      var parkedEntity = ParkedEntity(
          0,
          0,
          event.size,
          event.waitTime,
          event.minimunBid,
          false,
          LocationEntity(0, event.latitude, event.longitude, event.country,
              event.state, event.locality));

      final resp = await _publishAuctionUseCase(Params(parkedEntity));

      yield resp.fold((l) {
        if (l is PublishAuctionFailure) {
          showException(message: l.message);
          return PublishAuctionSuccessState();
        }
        showException(message: l.message);
        return PublishAuctionErrorState();
      }, (r) {
        signalRService.addToGroup(r.id.toString());
        return PublishAuctionSuccessState();
      });
    }
  }
}
