import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkz/core/utils/index.dart';

import 'package:sparkz/feature/help/domain/entity/contact_us_request_entity.dart';

import 'package:sparkz/feature/help/domain/usecases/contact_us_usecase.dart';

part 'contact_us_state.dart';
part 'contact_us_event.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> with Utils {
  ContactUsBloc(this._contactUsUseCase) : super(ContactUsInitialState());
  final ContactUsUseCase _contactUsUseCase;

  @override
  Stream<ContactUsState> mapEventToState(ContactUsEvent event) async* {
    if (event is ContactUsInitialEvent) {
      yield ContactUsInitialState();
    }

    if (event is ContactUsSentEvent) {
      yield ContactUsSentState();

      var contactUs = ContactUsRequestEntity(event.body);

      final resp = await _contactUsUseCase(Params(contactUs));

      yield resp.fold((l) {
        showException(message: l.message);
        return ContactUsErrorState();
      }, (r) {
        showMessage(message: 'Thanks for feedback.');
        return ContactUsSuccessState();
      });
    }
  }
}
