import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/base/widget_base_state.dart';

import 'package:sparkz/core/global/_widgets/custom_dropdown_button.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:sparkz/core/global/_widgets/generics_inputs.dart';
import 'package:sparkz/core/global/_widgets/custom_bottom_nav_bar.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/core/global/navigator/router_params.dart';
import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';
import 'package:sparkz/feature/auction/presentation/bloc/add_auction/add_auction_bloc.dart';
import 'package:sparkz/feature/auction/presentation/bloc/edit_auction/edit_auction_bloc.dart';
import 'package:sparkz/feature/auction/presentation/pages/list_auction_page.dart';
import 'package:sparkz/feature/car/data/datasource/size_enums.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:google_maps_webservice/geocoding.dart";

class EditAuctionPage extends StatefulWidget {
  EditAuctionPage({Key? key, this.routeParams}) : super(key: key);
  final RouteParams? routeParams;

  @override
  _EditAuctionPageState createState() => _EditAuctionPageState();
}

class _EditAuctionPageState
    extends StateWithBloC<EditAuctionPage, EditAuctionBloc> {
  final keyForm = GlobalKey<FormState>();
  final padding = EdgeInsets.symmetric(horizontal: 20);
  late ParkedEntity entity;

  String locality = '';
  int waitTime = 0;
  double minimunBid = 0;
  String size = 'MidSize';
  PickResult selectedPlace = PickResult();
  final textControllerParkingLocation = TextEditingController();
  static const API_KEY_GOOGLEMAPS = "AIzaSyB_-J18O-yWeTtt7OayuD6lLqWVcGHwAGw";
  final _geocoding = new GoogleMapsGeocoding(apiKey: API_KEY_GOOGLEMAPS);

  Position? _currentPosition;
  LocationAccuracy? desiredAccuracy;
  late LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
    _parseRouteParams();
    textControllerParkingLocation.text =
        '${entity.location.locality} ${entity.location.state} ${entity.location.country}';
    _initialPosition = LatLng(double.parse(entity.location.latitude),
        double.parse(entity.location.longitude));
  }

  @override
  void dispose() {
    textControllerParkingLocation.dispose();
    super.dispose();
  }

  void _parseRouteParams() {
    if (widget.routeParams is ParamsFromListAuction) {
      final params = widget.routeParams as ParamsFromListAuction;
      entity = params.parkedEntity;
    }
  }

  SizesEnums sizesEnums = new SizesEnums();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Compact"), value: "Compact"),
      DropdownMenuItem(child: Text("Midsize"), value: "Midsize"),
      DropdownMenuItem(child: Text("Sedan"), value: "Sedan"),
      DropdownMenuItem(child: Text("Small SUV"), value: "Small SUV"),
      DropdownMenuItem(child: Text("SUV"), value: "SUV"),
      DropdownMenuItem(child: Text("Small Truck"), value: "Small Truck"),
      DropdownMenuItem(
          child: Text("Full-size truck"), value: "Full-size truck"),
    ];
    return menuItems;
  }

  @override
  Widget buildWidget(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding;
    final _appBarPreferredSize = _screenSize.height * 0.15;

    return BlocConsumer<EditAuctionBloc, EditAuctionState>(
      listener: (context, state) {
        if (state is EditAuctionSuccessState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListAuctionPage()));
        }
        return;
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is AddAuctionSentState,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor:  Color(0xFF34393F),
                appBar: PreferredSize(
                  child:Container(
                    margin: EdgeInsets.only(right:35.0),
                    child: CustomAppBar(
                      leading: CustomUpperButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icons.arrow_back,
                      ),
                      title: 'Edit Auction Parking',
                    ),),
                    preferredSize:
                        Size(_screenSize.width, _appBarPreferredSize)),
                body: Form(
                  key: keyForm,
                  child: SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Color(0xFF34393F),
                            Color(0xFF1B1C20),
                          ])),
                      height: (_screenSize.height -
                          _appBarPreferredSize -
                          _padding.top),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: GenericInput(
                                readOnly: true,
                                controller: textControllerParkingLocation,
                                labelText: 'Parking Spot Location:',
                                fieldHint: '${entity.location.locality}',
                                initialValue: null,
                                validatorHandler: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return ('Please enter a valid location');
                                  }
                                  return null;
                                },
                                changeHandler: (value) {
                                  locality = value;
                                },
                              ),
                            ),
                            Container(
                              margin: padding,
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
                                                initialPosition:
                                                    _initialPosition,
                                                useCurrentLocation: false,
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
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                'Parking Spot Size:',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFC0C1C2)),
                              ),
                            ),
                            Container(
                              child: CustomDropDownButton(
                                  onPressDropDown: (String? newValue) {
                                    setState(() {
                                      size = newValue.toString();
                                    });
                                  },
                                  dropdownItems: dropdownItems),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 10),
                              child: GenericInput(
                                labelText: 'Wait Time (minutes):',
                                fieldHint: '20 minutes',
                                initialValue: entity.waitTime.toString(),
                                keyType: TextInputType.number,
                                validatorHandler: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Please enter valid minutes';
                                  }

                                  if (int.parse(value!) <= 0) {
                                    return 'Wait time must be higher';
                                  }
                                  return null;
                                },
                                changeHandler: (value) {
                                  waitTime = int.parse(value);
                                },
                              ),
                            ),
                            Container(
                              margin: padding,
                              child: GenericInput(
                                labelText: 'Minimum Bid (\$1/minutes):',
                                fieldHint: '30',
                                initialValue: entity.minimunBid.toString(),
                                keyType: TextInputType.number,
                                validatorHandler: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Please enter valid minutes';
                                  }
                                  if (double.parse(value!) <= 0) {
                                    return 'Wait time must be higher';
                                  }
                                  return null;
                                },
                                changeHandler: (value) {
                                  minimunBid = double.parse(value);
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundedButton(
                                      color: Color(0xFF1D2025),
                                      btnText: 'Update',
                                      onPressed: () {
                                        List<String>? listSelectedPlace =
                                            selectedPlace.formattedAddress
                                                ?.split(',');
                                        if (keyForm.currentState?.validate() ??
                                            false) {
                                          bloc?.add(EditAuctionSentEvent(
                                            entity.id!,
                                            entity.locationId!,
                                            sizesEnums
                                                .getKeyInMap(size)
                                                .toString(),
                                            waitTime <= 0
                                                ? entity.waitTime
                                                : waitTime,
                                            minimunBid <= 0
                                                ? entity.minimunBid
                                                : minimunBid,
                                            false,
                                            selectedPlace.geometry?.location.lat
                                                    .toString() ??
                                                entity.location.latitude,
                                            selectedPlace.geometry?.location.lng
                                                    .toString() ??
                                                entity.location.longitude,
                                            listSelectedPlace?.last ??
                                                entity.location.country,
                                            '${listSelectedPlace?[1] ?? entity.location.state}',
                                            listSelectedPlace?.first ??
                                                entity.location.locality,
                                          ));
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                extendBody: true,
                bottomNavigationBar: CustomHomeBottomNavBar(
                  isAuctionPressed: true,
                  isSearchPressed: false,
                )));
      },
    );
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
}
