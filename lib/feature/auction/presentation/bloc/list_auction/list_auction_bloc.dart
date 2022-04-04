import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sparkz/core/utils/utils.dart';
import 'package:sparkz/feature/auction/data/model/list_auction_response_model.dart';
import 'package:sparkz/feature/auction/domain/entity/list_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/usecases/list_auction_usecase.dart';

part 'list_auction_state.dart';
part 'list_auction_event.dart';

class ListAuctionBloc extends Bloc<ListAuctionEvent, ListAuctionState>
    with Utils {
  ListAuctionBloc(this._listAuctionUseCase) : super(ListAuctionInitialState());

  final ListAuctionUseCase _listAuctionUseCase;
  final BehaviorSubject<List<ListAuctionResponseModel>> _subject =
      BehaviorSubject<List<ListAuctionResponseModel>>();

  @override
  Stream<ListAuctionState> mapEventToState(ListAuctionEvent event) async* {
    if (event is ListAuctionInitialEvent) {
      yield ListAuctionInitialState();
    }

    if (event is ListAuctionSentEvent) {
      yield ListAuctionSentState();

      final resp = await _listAuctionUseCase(
          Params(ListAuctionRequesEntity(event.pageNumber, event.pageSize)));

      yield resp.fold((l) {
        showException(message: l.message);
        return ListAuctionErrorState();
      }, (r) {
        _subject.sink.add(r);
        return ListAuctionSuccessState();
      });
    }
  }

  BehaviorSubject<List<ListAuctionResponseModel>> get subject => _subject;

  dispose() {
    _subject.close();
  }
}
