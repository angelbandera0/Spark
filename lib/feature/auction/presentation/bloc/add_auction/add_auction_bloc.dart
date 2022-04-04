import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkz/core/utils/index.dart';
import 'package:sparkz/feature/auction/domain/entity/location_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';
import 'package:sparkz/feature/auction/domain/usecases/add_auction_usecase.dart';

part 'add_auction_state.dart';
part 'add_auction_event.dart';

class AddAuctionBloc extends Bloc<AddAuctionEvent, AddAuctionState> with Utils {
  AddAuctionBloc(this._addAuctionUseCase) : super(AddAuctionInitialState());
  final AddAuctionUseCase _addAuctionUseCase;

  @override
  Stream<AddAuctionState> mapEventToState(AddAuctionEvent event) async* {
    if (event is AddAuctionInitialEvent) {
      yield AddAuctionInitialState();
    }

    if (event is AddAuctionSentEvent) {
      yield AddAuctionSentState();

      var parkedEntity = ParkedEntity(
          0,
          0,
          event.size,
          event.waitTime,
          event.minimunBid,
          false,
          LocationEntity(0, event.latitude, event.longitude, event.country,
              event.state, event.locality));

      final resp = await _addAuctionUseCase(Params(parkedEntity));

      yield resp.fold((l) {
        showException(message: l.message);
        return AddAuctionErrorState();
      }, (r) => AddAuctionSuccessState());
    }
  }
}
