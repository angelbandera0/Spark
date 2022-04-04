import 'dart:async';

import 'package:flutter/widgets.dart' as Material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:sparkz/core/global/data/user_profile.dart';
import 'package:sparkz/core/global/endpoints.dart';
import 'package:sparkz/core/platform/connectivity.dart';
import 'package:sparkz/core/platform/network_handler.dart';
import 'package:sparkz/core/platform/shared_prefs.dart';
import 'package:sparkz/core/platform/signalr_service.dart';
import 'package:sparkz/core/utils/logger.dart';
import 'package:sparkz/feature/account_management/data/datasourse/account_management_remote_api.dart';
import 'package:sparkz/feature/account_management/data/respository/account_management_repository_demo_impl.dart';
import 'package:sparkz/feature/account_management/domain/usercases/request_verification_code_usecase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/upload_avatar_usecase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/validate_requested_code_usecase.dart';
import 'package:sparkz/feature/auction/data/datasource/auction_remote_api.dart';
import 'package:sparkz/feature/auction/data/repository/auction_repository_impl.dart';
import 'package:sparkz/feature/auction/domain/repository/auction_repository.dart';
import 'package:sparkz/feature/auction/domain/usecases/add_auction_usecase.dart';
import 'package:sparkz/feature/auction/domain/usecases/delete_auction_usecase.dart';
import 'package:sparkz/feature/auction/domain/usecases/edit_auction_usecase.dart';
import 'package:sparkz/feature/auction/domain/usecases/list_auction_usecase.dart';
import 'package:sparkz/feature/auction/domain/usecases/publish_auction_usecase.dart';
import 'package:sparkz/feature/auction/domain/usecases/start_auction_usecase.dart';
import 'package:sparkz/feature/auction/presentation/bloc/add_auction/add_auction_bloc.dart';
import 'package:sparkz/feature/auction/presentation/bloc/delete_auction/delete_auction_bloc.dart';
import 'package:sparkz/feature/auction/presentation/bloc/edit_auction/edit_auction_bloc.dart';
import 'package:sparkz/feature/auction/presentation/bloc/list_auction/list_auction_bloc.dart';
import 'package:sparkz/feature/account_management/data/respository/account_management_repository_impl.dart';
import 'package:sparkz/feature/account_management/domain/repository/account_management_repository.dart';
import 'package:sparkz/feature/auction/presentation/bloc/publish_auction/publish_auction_bloc.dart';
import 'package:sparkz/feature/auction/presentation/bloc/start_auction/start_auction_bloc.dart';
import 'package:sparkz/feature/car/data/datasource/card_remote_api.dart';
import 'package:sparkz/feature/car/data/repository/car_repository_impl.dart';
import 'package:sparkz/feature/car/domain/repository/car_repository.dart';
import 'package:sparkz/feature/account_management/domain/usercases/log_in_credential_usercase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/log_in_usercase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/log_out_usecase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/recover_account_usecase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/recover_password_usecase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/sign_up_usercase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/update_profile_usecase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/validate_phone_usecase.dart';
import 'package:sparkz/feature/account_management/domain/usercases/refresh_validate_code_usecase.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/log_in/log_in_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/log_out/log_out_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/recover_account/recover_account_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/recovery_password/recover_password_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/update_profile/update_profile_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/validate_phone/validate_phone_bloc.dart';
import 'package:sparkz/feature/car/domain/usercases/activate_car_usecase.dart';
import 'package:sparkz/feature/car/domain/usercases/add_car_usecase.dart';
import 'package:sparkz/feature/car/domain/usercases/delete_car_usecase.dart';
import 'package:sparkz/feature/car/domain/usercases/edit_car_usecase.dart';
import 'package:sparkz/feature/car/domain/usercases/get_active_car_usecase.dart';
import 'package:sparkz/feature/car/domain/usercases/list_car_usecase.dart';
import 'package:sparkz/feature/car/domain/usercases/submit_bid_usecase.dart';
import 'package:sparkz/feature/car/presentation/bloc/activate_car/activate_car_bloc.dart';
import 'package:sparkz/feature/car/presentation/bloc/add_car/add_car_bloc.dart';
import 'package:sparkz/feature/car/presentation/bloc/delete_car/delete_car_bloc.dart';
import 'package:sparkz/feature/car/presentation/bloc/edit_car/edit_car_bloc.dart';
import 'package:sparkz/feature/car/presentation/bloc/get_active_car/get_active_car_bloc.dart';
import 'package:sparkz/feature/car/presentation/bloc/list_car/list_car_bloc.dart';
import 'package:sparkz/feature/help/data/datasource/help_remote_api.dart';
import 'package:sparkz/feature/help/data/repository/help_repository_impl.dart';
import 'package:sparkz/feature/help/domain/repository/help_repository.dart';
import 'package:sparkz/feature/help/domain/usecases/contact_us_usecase.dart';
import 'package:sparkz/feature/help/presentation/bloc/contact_us/contact_us_bloc.dart';
import 'package:sparkz/feature/search/data/datasource/search_remote_api.dart';
import 'package:sparkz/feature/search/data/repository/search_repository_impl.dart';
import 'package:sparkz/feature/search/domain/repository/search_repository.dart';
import 'package:sparkz/feature/search/domain/usecases/delete_unparked_usecase.dart';
import 'package:sparkz/feature/search/domain/usecases/list_compatible_spots_usecase.dart';
import 'package:sparkz/feature/search/domain/usecases/list_unparked_usecase.dart';
import 'package:sparkz/feature/search/domain/usecases/search_auction_usecase.dart';
import 'package:sparkz/feature/search/presentation/bloc/add_unparked/add_unparked_bloc.dart';
import 'package:sparkz/feature/search/presentation/bloc/delete_unparked/delete_unparked_bloc.dart';
import 'package:sparkz/feature/search/presentation/bloc/list_compatible_spots/list_compatible_spots_bloc.dart';
import 'package:sparkz/feature/search/presentation/bloc/list_unparked/list_unparked_bloc.dart';
import 'package:sparkz/feature/search/presentation/bloc/submit_bid/submit_bid_bloc.dart';

///Part dependency injector engine and Part service locator.
///The main purpose of [Injector] is to provide bloCs instances and initialize the app components depending the current scope.
///To reuse a bloc instance in the widget's tree feel free to use the [BlocProvider] mechanism.
class Injector {
  ///Singleton instance
  static Injector? instance;

  KiwiContainer container = KiwiContainer();

  ///API base url
  static late String apiBaseUrl;

  ///Api url validator
  static late String apiGateway;

  ///IP Server
  static late String ipServer;

  static late Material.GlobalKey<Material.NavigatorState> navigatorKey;

  ///Init the injector with prod configurations
  static initProd() {
    apiBaseUrl = Endpoint.apiBaseUrlProd;

    apiGateway = Endpoint.API_GATEWAY_PROD;

    ipServer = Endpoint.IP_SERVER_PROD;

    if (instance == null) instance = Injector._init();
  }

  ///Init the injector with demo configurations
  static initDev() {
    apiBaseUrl = Endpoint.apiBaseUrl;

    apiGateway = Endpoint.API_GATEWAY;
    ipServer = Endpoint.IP_SERVER;

    if (instance == null) instance = Injector._init();
  }

  ///Init the injector with demo configurations
  static initDemo() {
    if (instance == null) instance = Injector._demo();
  }

  ///Init
  Injector._init() {
    navigatorKey = Material.GlobalKey(debugLabel: "Main Navigator");
    _registerLocalAuth();
    _registerCommonImpl();
    _registerModelConverters();
    _registerDaoLayer();
    _registerApiLayer();
    _registerDBLayer();
    _registerBloCs();
    _registerUserCaseLayer();
    //repositories
    _registerRepositoryLayer();
  }

  ///Init Demo
  Injector._demo() {
    _registerLocalAuth();
    _registerCommonImpl();
    _registerModelConverters();
    _registerDaoLayer();
    _registerApiLayer();
    _registerBloCs();
    _registerUserCaseLayer();
    //demo repositories
    _registerDemoRepositoryLayer();
  }

  _registerDemoRepositoryLayer() {
    container.registerSingleton<AccountManagementRepository>(
        (c) => AccountManagementRepositoryDemoImpl());
    //container.registerSingleton<CarRepository>((c) => CardRepositoryImpl());
    container.registerSingleton<UserProfile>((c) => UserProfileImpl());
  }

  _registerLocalAuth() {}

  _registerApiLayer() {
    container.registerSingleton<AccountManagementRemoteApi>(
        (c) => AccountManagementRemoteApiImpl(c.resolve()));
    container.registerSingleton<AuctionRemoteApi>(
        (c) => AuctionRemoteApiImpl(c.resolve()));
    container.registerSingleton<CardRemoteApi>(
        (c) => CardRemoteApiImpl(c.resolve()));
    container.registerSingleton<UserProfile>((c) => UserProfileImpl());
    container.registerSingleton<SearchRemoteApi>(
        (c) => SearchRemoteApiImpl(c.resolve()));
    container.registerSingleton<HelpRemoteApi>(
        (c) => HelpRemoteApiImpl(c.resolve()));
  }

  _registerUserCaseLayer() {
    container
        .registerFactory((container) => LogInUserCase(container.resolve()));
    container.registerFactory(
        (container) => LogInRememberUseCase(container.resolve()));
    container
        .registerFactory((container) => SignUpUserCase(container.resolve()));
    container
        .registerFactory((container) => ListCarUseCase(container.resolve()));
    container
        .registerFactory((container) => AddCarUseCase(container.resolve()));
    container
        .registerFactory((container) => EditCarUseCase(container.resolve()));
    container
        .registerFactory((container) => DeleteCarUseCase(container.resolve()));
    container.registerFactory(
        (container) => ActivateCarUseCase(container.resolve()));
    container.registerFactory(
        (container) => ValidatePhoneUseCase(container.resolve()));
    container.registerFactory(
        (container) => RefreshValidateCodeUseCase(container.resolve()));
    container.registerFactory(
        (container) => RecoverAccountUseCase(container.resolve()));
    container.registerFactory(
        (container) => RecoverPasswordUseCase(container.resolve()));
    container
        .registerFactory((container) => LogOutUseCase(container.resolve()));
    container.registerFactory(
        (container) => UpdateProfileUseCase(container.resolve()));
    container.registerFactory(
        (container) => ListAuctionUseCase(container.resolve()));
    container.registerFactory(
        (container) => RequestVerificationCodeUseCase(container.resolve()));
    container.registerFactory(
        (container) => UpdateAvatarUseCase(container.resolve()));
    container.registerFactory(
        (container) => ValidateRequestedCodeUseCase(container.resolve()));
    container.registerFactory(
        (container) => AddAuctionUseCase((container.resolve())));
    container.registerFactory(
        (container) => EditAuctionUseCase((container.resolve())));
    container.registerFactory(
        (container) => DeleteAuctionUseCase((container.resolve())));
    container.registerFactory(
        (container) => StartAuctionUseCase((container.resolve())));
    container.registerFactory(
        (container) => PublishAuctionUseCase((container.resolve())));
    container.registerFactory(
        (container) => AddUnparkedUseCase(container.resolve()));
    container.registerFactory(
        (container) => GetActiveCarUseCase(container.resolve()));
    container.registerFactory(
        (container) => ListUnparkedUseCase(container.resolve()));
    container.registerFactory(
        (container) => ListCompatibleSpotsUseCase(container.resolve()));
    container.registerFactory(
        (container) => DeleteUnparkedUseCase(container.resolve()));
    container
        .registerFactory((container) => SubmitBidUseCase(container.resolve()));
    container
        .registerFactory((container) => ContactUsUseCase(container.resolve()));
  }

  _registerDBLayer() {
    // container.registerSingleton<ICategoryDb, CategoryDbImplementation>(
    //     (c) => CategoryDbImplementation(container.resolve()));
  }

  _registerDaoLayer() {
//    container.registerSingleton<IUserDAO, UserDao>(
//        (c) => UserDao(container.resolve(), container.resolve()));
//    container.registerSingleton<IContactDao, ContactDao>((c) => ContactDao());
  }

  _registerRepositoryLayer() {
    container.registerSingleton<AccountManagementRepository>((c) =>
        AccountManagementRepositoryImpl(
            c.resolve(), c.resolve(), c.resolve(), c.resolve()));
    container.registerSingleton<AuctionRepository>(
        (c) => AuctionRepositoryImpl(c.resolve(), c.resolve()));
    container.registerSingleton<CarRepository>(
        (c) => CardRepositoryImpl(c.resolve(), c.resolve()));
    container.registerSingleton<SearchRepository>(
        (c) => SearchRepositoryImpl(c.resolve(), c.resolve()));
    container.registerSingleton<HelpRepository>(
        (c) => HelpRepositoryImpl(c.resolve(), c.resolve()));
  }

  ///Register the blocs here
  _registerBloCs() {
    container.registerFactory(
        (c) => LogInBloc(c.resolve(), c.resolve(), c.resolve()));
    container.registerFactory((c) => SignUpBloc(c.resolve()));
    container.registerFactory((c) => ListCarBloc(c.resolve()));
    container.registerFactory((c) => RecoverAccountBloc(c.resolve()));
    container.registerFactory((c) =>
        ValidatePhoneBloc(c.resolve(), c.resolve(), c.resolve(), c.resolve()));
    container.registerFactory((c) => RecoverPasswordBloc(c.resolve()));
    container.registerFactory((c) => LogOutBloc(c.resolve(), c.resolve()));
    container.registerFactory((c) =>
        UpdateProfileBloc(c.resolve(), c.resolve(), c.resolve(), c.resolve()));
    container.registerFactory((c) => ListAuctionBloc(c.resolve()));
    container.registerFactory((c) => AddAuctionBloc(c.resolve()));
    container.registerFactory((c) => EditAuctionBloc(c.resolve()));
    container.registerFactory((c) => DeleteAuctionBloc(c.resolve()));
    container
        .registerFactory((c) => StartAuctionBloc(c.resolve(), c.resolve()));
    container
        .registerFactory((c) => PublishAuctionBloc(c.resolve(), c.resolve()));
    container.registerFactory((c) => AddCarBloc(c.resolve()));
    container.registerFactory((c) => EditCarBloc(c.resolve()));
    container.registerFactory((c) => DeleteCarBloc(c.resolve()));
    container.registerFactory((c) => ActivateCarBloc(c.resolve()));
    container
        .registerFactory((c) => GetActiveCarBloc(c.resolve(), c.resolve()));
    container.registerFactory((c) => AddUnparkedBloc(c.resolve(), c.resolve()));
    container
        .registerFactory((c) => ListUnparkedBloc(c.resolve(), c.resolve()));
    container.registerFactory((c) => ListCompatibleSpotsBloc(c.resolve()));
    container.registerFactory((c) => DeleteUnparkedBloc(c.resolve()));
    container.registerFactory((c) => SubmitBidBloc(c.resolve(), c.resolve()));
    container.registerFactory((c) => ContactUsBloc(c.resolve()));
  }

  _registerModelConverters() {
//    container.registerSingleton<IUserConverter, UserConverter>(
//      (c) => UserConverter(),
//    );
  }

  ///Register common components
  _registerCommonImpl() {
    container.registerSingleton<Logger>((c) => LoggerImpl());
    container.registerSingleton((c) => SharedPreferencesManager());
    container.registerSingleton(
      (c) => NetworkHandler(container.resolve(), container.resolve()),
    );

    container.registerSingleton((container) => StreamController.broadcast());
    container.registerSingleton((container) => ConnectivityService());
    container
        .registerSingleton((container) => SignalRService(container.resolve()));
  }

  ///returns the current instance of the logger
  Logger getLogger() => container.resolve();

  ///returns a new bloc instance
  T getNewBloCLibrary<T extends Bloc>() => container.resolve();

  NetworkHandler get networkHandler => container.resolve();

  SharedPreferencesManager get sharedPreferences => container.resolve();

  StreamController get streamController => container.resolve();

  ConnectivityService get connectivityService => container.resolve();

  SignalRService get signalRService => container.resolve();

  T getDependency<T>() => container.resolve();
}
