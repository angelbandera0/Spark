import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity_list.dart';

abstract class RouteParams {}

class ParamsFromSignUpPage extends RouteParams {
  ParamsFromSignUpPage(this.email, this.phoneNumber);
  final String email;
  final String phoneNumber;
}

class ParamsFromRecoveryAccountPage extends RouteParams {
  ParamsFromRecoveryAccountPage(this.email);
  final String email;
}

class ParamsFromValidatePhonePage extends RouteParams {
  ParamsFromValidatePhonePage(this.code);
  final String code;
}

class ParamsFromUpdateUserProfile extends RouteParams {
  ParamsFromUpdateUserProfile(
      {this.userName, this.email, this.country, this.number});
  final String? userName;
  final String? email;
  final String? country;
  final String? number;
}

class ParamsFromListAuction extends RouteParams {
  ParamsFromListAuction(this.parkedEntity);
  final ParkedEntity parkedEntity;
}

class ParamsFromListCar extends RouteParams {
  ParamsFromListCar(this.car);
  final CarEntityList car;
}

class ParamsFromSearchAuction extends RouteParams {
  ParamsFromSearchAuction(this.parkedEntity, this.unparkedId);
  final ParkedEntity parkedEntity;
  final int unparkedId;
}
