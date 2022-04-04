import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/custom_bottom_nav_bar.dart';
import 'package:sparkz/core/global/_widgets/custom_time_picker.dart';
import 'package:sparkz/core/global/_widgets/custom_time_picker_input_field.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/generics_inputs.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/core/global/data/user_profile.dart';
import 'package:sparkz/di/inyector.dart';
import 'package:sparkz/feature/auction/presentation/pages/list_auction_page.dart';
import 'package:sparkz/feature/car/data/datasource/size_enums.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:google_maps_webservice/geocoding.dart";
import 'package:sparkz/feature/car/domain/entity/car_entity.dart';
import 'package:sparkz/feature/car/presentation/pages/car_menu_page.dart';
import 'package:sparkz/feature/search/presentation/bloc/add_unparked/add_unparked_bloc.dart';
import 'package:sparkz/feature/search/presentation/bloc/list_unparked/list_unparked_bloc.dart';
import 'package:sparkz/feature/search/presentation/pages/parking_requests_page.dart';
import 'package:sparkz/core/global/_widgets/custom_time_picker.dart'
    as customTimePicker;

class AddUnparkedPage extends StatefulWidget {
  AddUnparkedPage({Key? key}) : super(key: key);

  @override
  _AddUnparkedPageState createState() => _AddUnparkedPageState();
}

class _AddUnparkedPageState
    extends StateWithBloC<AddUnparkedPage, ListUnparkedBloc> {
  final keyForm = GlobalKey<FormState>();
  final RegExp numberRegExp = RegExp(r"^[0-9]*$");

  PickResult selectedPlace = PickResult();
  static const API_KEY_GOOGLEMAPS = "AIzaSyB_-J18O-yWeTtt7OayuD6lLqWVcGHwAGw";
  final _geocoding = new GoogleMapsGeocoding(apiKey: API_KEY_GOOGLEMAPS);
  Position? _currentPosition;
  LocationAccuracy? desiredAccuracy;

  bool isselected = false;

  final textControllerParkingLocation = TextEditingController();
  final _inputFieldFromDateTimeController = TextEditingController();
  final _inputFieldToDateTimeController = TextEditingController();
  // ignore: unused_field
  String _fromDateTime = '';
  // ignore: unused_field
  String _toDateTime = '';

  late UserProfile _userProfile;

  String size = "Compact";
  SizesEnums sizesEnums = new SizesEnums();

  @override
  void initState() {
    super.initState();
    textControllerParkingLocation.text = '';
    _inputFieldFromDateTimeController.text = '';
    _inputFieldToDateTimeController.text = '';
    _userProfile = (Injector.instance!.getDependency());
    bloc?.add(ListUnparkedSentEvent("brand", "ASC", 1, 100));
  }

  @override
  void dispose() {
    textControllerParkingLocation.dispose();
    _inputFieldFromDateTimeController.dispose();
    _inputFieldToDateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    Size _sizeScreen = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding;
    final _appBarPreferredSize = _sizeScreen.height * 0.15;

    return BlocConsumer<ListUnparkedBloc, ListUnparkedState>(
        listener: (context, state) {
      if (state is ListUnparkedSuccessState &&
          _userProfile.getActiveCar()!.brand.isNotEmpty) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ParkingRequestsPage()));
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
          inAsyncCall: state is ListUnparkedSentState,
          child: Scaffold(
              backgroundColor: Color(0xFF2E3238),
              appBar: PreferredSize(
                  child: CustomAppBar(
                    leading: CustomUpperButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      icon: Icons.arrow_back,
                    ),
                    title: 'Parking Requirements',
                  ),
                  preferredSize: Size(_sizeScreen.width, _appBarPreferredSize)),
              body: Form(
                key: keyForm,
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color(0xFF34393F),
                          Color(0xFF1B1C20),
                        ])),
                    height: (_sizeScreen.height -
                        _appBarPreferredSize -
                        _padding.top),
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: GenericInput(
                                  readOnly: true,
                                  initialValue: null,
                                  controller: textControllerParkingLocation,
                                  labelText: 'Desire Parking Location:',
                                  fieldHint:
                                      'Main Street between 5th and 6th Avenues',
                                  validatorHandler: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return ('Please enter a valid location');
                                    }
                                    return null;
                                  },
                                  changeHandler: (value) {}),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RoundedButton(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      icon: Icons.location_on,
                                      btnText: 'Google Maps',
                                      textSize: 14,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return PlacePicker(
                                                apiKey: API_KEY_GOOGLEMAPS,
                                                initialPosition: LatLng(
                                                    25.7969358, -80.2761685),
                                                useCurrentLocation: true,
                                                selectInitialPosition: true,
                                                onPlacePicked: (result) {
                                                  selectedPlace = result;
                                                  textControllerParkingLocation
                                                          .text =
                                                      '${selectedPlace.formattedAddress}';
                                                  Navigator.of(context).pop();
                                                },
                                                automaticallyImplyAppBarLeading:
                                                    false,
                                                autocompleteLanguage: "en",
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      color: Color(0xFF1D2025)),
                                  RoundedButton(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      icon: Icons.my_location_outlined,
                                      textSize: 15,
                                      btnText: 'Use GPS',
                                      onPressed: () async {
                                        updateCurrentLocation()
                                            .whenComplete(() {
                                          if (_currentPosition != null) {
                                            _geocoding
                                                .searchByLocation(Location(
                                                    lat: _currentPosition!
                                                        .latitude,
                                                    lng: _currentPosition!
                                                        .longitude))
                                                .then((value) {
                                              selectedPlace = PickResult(
                                                addressComponents: value.results
                                                    .first.addressComponents,
                                                formattedAddress: value.results
                                                    .first.formattedAddress,
                                                geometry: value
                                                    .results.first.geometry,
                                                placeId:
                                                    value.results.first.placeId,
                                              );
                                              textControllerParkingLocation
                                                      .text =
                                                  '${selectedPlace.formattedAddress}';
                                            });
                                          }
                                        });
                                      },
                                      color: Color(0xFF1D2025)),
                                ],
                              ),
                            ),
                            _customCarInfo(_sizeScreen, _userProfile),
                            Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: _sizeScreen.width * 0.5,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Container(
                                      child: Text(
                                        'Time',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFC0C1C2)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Time period',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFC0C1C2)),
                                    ),
                                  ),
                                  Container(
                                    child: FlutterSwitch(
                                      width: 30.0,
                                      height: 15.0,
                                      valueFontSize: 10.0,
                                      toggleSize: 8.0,
                                      value: isselected,
                                      toggleColor: Colors.grey,
                                      activeToggleColor: Color(0xFFFF4F01),
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.black,
                                      onToggle: (val) {
                                        setState(() {
                                          isselected = val;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomTimePickerInputField(
                                validatorHandler: (value) {
                                  if ((value?.isEmpty ?? true) ||
                                      DateTime.parse(_fromDateTime)
                                          .isBefore(DateTime.now()) ||
                                      DateTime.parse(_fromDateTime)
                                          .isBefore(DateTime.now())) {
                                    return ('Please enter a valid time');
                                  }
                                  return null;
                                },
                                changeHandler: (value) {},
                                onTap: () async {
                                  customTimePicker
                                      .showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    initialEntryMode: customTimePicker
                                        .TimePickerEntryMode.dial,
                                  )
                                      .then((value) {
                                    if (value != null) {
                                      String _hour = (value.hour > 9)
                                          ? value.hour.toString()
                                          : '0${value.hour}';
                                      String _minutes = (value.minute > 9)
                                          ? value.minute.toString()
                                          : '0${value.minute}';
                                      setState(() {
                                        _inputFieldFromDateTimeController.text =
                                            '${value.format(context).toString()}';
                                        _fromDateTime = DateTime.now()
                                            .toIso8601String()
                                            .replaceRange(
                                                11, 16, '$_hour:$_minutes');
                                      });
                                    }
                                  });
                                },
                                controller: _inputFieldFromDateTimeController,
                                sizeScreen: _sizeScreen,
                                hintText: isselected
                                    ? 'From.'
                                    : '${TimeOfDay.now().format(context).toString()}'),
                            isselected
                                ? CustomTimePickerInputField(
                                    validatorHandler: (value) {
                                      if ((value?.isEmpty ?? true) &&
                                              !isselected ||
                                          DateTime.parse(_toDateTime)
                                              .isBefore(DateTime.now()) ||
                                          DateTime.parse(_toDateTime)
                                              .isBefore(DateTime.now()) ||
                                          DateTime.parse(_toDateTime).isBefore(
                                              DateTime.parse(_fromDateTime))) {
                                        return ('Please enter a valid time');
                                      }
                                      return null;
                                    },
                                    changeHandler: (value) {},
                                    onTap: () {
                                      customTimePicker
                                          .showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        initialEntryMode: customTimePicker
                                            .TimePickerEntryMode.dial,
                                      )
                                          .then((value) {
                                        if (value != null) {
                                          String _hour = (value.hour > 9)
                                              ? value.hour.toString()
                                              : '0${value.hour}';
                                          String _minutes = (value.minute > 9)
                                              ? value.minute.toString()
                                              : '0${value.minute}';
                                          setState(() {
                                            _inputFieldToDateTimeController
                                                    .text =
                                                '${value.format(context).toString()}';
                                            _toDateTime = DateTime.now()
                                                .toIso8601String()
                                                .replaceRange(
                                                    11, 16, '$_hour:$_minutes');
                                          });
                                        }
                                      });
                                    },
                                    controller: _inputFieldToDateTimeController,
                                    sizeScreen: _sizeScreen,
                                    hintText: 'To.')
                                : Container(),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SearchParkingRequirementsButton(
                                    isSelectedTimePeriod: isselected,
                                    fromDateTime: _fromDateTime.toString(),
                                    keyForm: keyForm,
                                    selectedPlace: selectedPlace,
                                    sizesEnums: sizesEnums,
                                    toDateTime: _toDateTime.toString(),
                                    userProfile: _userProfile,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              extendBody: true,
              bottomNavigationBar: CustomHomeBottomNavBar(
                isAuctionPressed: false,
                isSearchPressed: true,
              )));
    });
  }

  Future<void> updateCurrentLocation() async {
    try {
      await Permission.location.request();
      if (await Permission.location.request().isGranted) {
        _currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: desiredAccuracy ?? LocationAccuracy.best);
      } else {
        _currentPosition = null;
      }
    } catch (e) {
      print(e);
      _currentPosition = null;
    }
  }

  Widget _customCarInfo(Size size, UserProfile userProfile) {
    CarEntity car = _userProfile.getActiveCar() as CarEntity;
    return Container(
      height: 45,
      margin: EdgeInsets.only(bottom: 10, right: 20, left: 20, top: 20),
      width: size.width,
      child: Neumorphic(
        style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            shadowDarkColor: Colors.black,
            shadowLightColor: Colors.white38,
            color: Color(0xFF1D2025)),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (_userProfile.getActiveCar()!.brand.isNotEmpty)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Car:',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14))),
                        SizedBox(
                          width: size.height * 0.01,
                        ),
                        Container(
                            child: Text('${car.brand} ${car.model}',
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14))),
                        Spacer(),
                        Container(
                            child: Text('Plate:',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14))),
                        SizedBox(
                          width: size.height * 0.01,
                        ),
                        Container(
                            child: Text(car.plateNumber,
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14))),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => CarMenuPage()));
                      },
                      child: Container(
                        child: Text('Press to activate a Car',
                            style: TextStyle(
                                color: Color(0xFFFF4F01),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchParkingRequirementsButton extends StatefulWidget {
  const SearchParkingRequirementsButton(
      {Key? key,
      required this.keyForm,
      required this.sizesEnums,
      required this.userProfile,
      required this.fromDateTime,
      required this.toDateTime,
      required this.selectedPlace,
      required this.isSelectedTimePeriod})
      : super(key: key);

  final PickResult selectedPlace;
  final keyForm;
  final SizesEnums sizesEnums;
  final UserProfile userProfile;
  final String fromDateTime;
  final String toDateTime;
  final bool isSelectedTimePeriod;

  @override
  _SearchParkingRequirementsButtonState createState() =>
      _SearchParkingRequirementsButtonState();
}

class _SearchParkingRequirementsButtonState
    extends StateWithBloC<SearchParkingRequirementsButton, AddUnparkedBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return BlocConsumer<AddUnparkedBloc, AddUnparkedState>(
        listener: (context, state) {
      if (state is AddUnparkedSuccessState) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ParkingRequestsPage()));
      }
      return;
    }, builder: (context, state) {
      return RoundedButton(
          color: (widget.userProfile.getActiveCar()!.brand.isEmpty)
              ? Colors.blueGrey
              : Color(0xFFFF4F01),
          btnText: 'Search',
          onPressed: (widget.userProfile.getActiveCar()!.brand.isEmpty)
              ? null
              : () async {
                  List<String>? listSelectedPlace =
                      widget.selectedPlace.formattedAddress?.split(',');
                  if (widget.keyForm.currentState?.validate() ?? false) {
                    bloc?.add(AddUnparkedSentEvent(
                        widget.userProfile
                            .getActiveCar()!
                            .parkingSpotSize
                            .toString(),
                        widget.selectedPlace.geometry?.location.lat
                                .toString() ??
                            '',
                        widget.selectedPlace.geometry?.location.lng
                                .toString() ??
                            '',
                        listSelectedPlace?.last ?? '',
                        '${listSelectedPlace?[1] ?? ''}',
                        listSelectedPlace?.first ?? '',
                        widget.fromDateTime,
                        (widget.isSelectedTimePeriod) ? widget.toDateTime : "",
                        widget.userProfile.getActiveCar()!.brand,
                        widget.userProfile.getActiveCar()!.color,
                        widget.userProfile.getActiveCar()!.model,
                        widget.userProfile.getActiveCar()!.plateNumber));
                  }
                });
    });
  }
}
