import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/auction/domain/entity/location_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';
import 'package:sparkz/feature/auction/domain/usecases/edit_auction_usecase.dart';

part 'edit_auction_state.dart';
part 'edit_auction_event.dart';

class EditAuctionBloc extends Bloc<EditAuctionEvent, EditAuctionState>
    with Utils {
  EditAuctionBloc(this._editActionUseCase) : super(EditAuctionInitialState());

  final EditAuctionUseCase _editActionUseCase;

  @override
  Stream<EditAuctionState> mapEventToState(EditAuctionEvent event) async* {
    if (event is EditAuctionInitialEvent) {
      yield EditAuctionInitialState();
    }

    if (event is EditAuctionSentEvent) {
      yield EditAuctionSentState();

      final resp = await _editActionUseCase(Params(ParkedEntity(
          event.id,
          event.locationId,
          event.size,
          event.waitTime,
          event.minimunBid,
          false,
          LocationEntity(event.locationId, event.latitude, event.longitude,
              event.country, event.state, event.locality))));

      yield resp.fold((l) {
        showException(message: l.message);
        return EditAuctionErrorState();
      }, (r) => EditAuctionSuccessState());
    }
  }
}
