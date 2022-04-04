import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/custom_dropdown_button.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:sparkz/core/global/_widgets/generics_inputs.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/core/global/navigator/router_params.dart';
import 'package:sparkz/feature/car/data/datasource/size_enums.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity_list.dart';
import 'package:sparkz/feature/car/presentation/bloc/edit_car/edit_car_bloc.dart';
import 'package:sparkz/feature/car/presentation/pages/car_menu_page.dart';

class EditCarPage extends StatefulWidget {
  EditCarPage({Key? key, this.routeParams}) : super(key: key);
  final RouteParams? routeParams;

  @override
  _EditCarPageState createState() => _EditCarPageState();
}

class _EditCarPageState extends StateWithBloC<EditCarPage, EditCarBloc> {
  String brand = "";
  int carId = 0;
  String model = "";
  String cardSize = "";
  String plate = "";
  String color = "";
  String size = " ";
  String carSize = " ";
  late CarEntityList entity;
  SizesEnums enums = new SizesEnums();

  final keyForm = GlobalKey<FormState>();

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
  void initState() {
    super.initState();
    _parseRouteParams();
  }

  void _parseRouteParams() {
    if (widget.routeParams is ParamsFromListCar) {
      final params = widget.routeParams as ParamsFromListCar;
      entity = params.car;
      cardSize = enums.getValueInMap(entity.carSizeType);
      brand = entity.carBrand;
      color = entity.carColor;
      plate = entity.carPlateNumber;
      model = entity.carModel;
      carId = entity.carId;
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding;
    final _appBarPreferredSize = _screenSize.height * 0.15;

    return BlocConsumer<EditCarBloc, EditCarState>(listener: (context, state) {
      if (state is EditCarSuccessState) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CarMenuPage()));
      }
      return;
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is EditCarSentState,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
              child: CustomAppBar(
                leading: CustomUpperButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icons.arrow_back,
                ),
                title: 'Edit Car',
              ),
              preferredSize: Size(_screenSize.width, _appBarPreferredSize)),
          backgroundColor: Color(0xFF2E3238),
          body: Form(
            key: keyForm,
            child: SingleChildScrollView(
              child: Container(
                height:
                    (_screenSize.height - _appBarPreferredSize - _padding.top),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xFF34393F),
                      Color(0xFF1B1C20),
                    ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10),
                            child: GenericInput(
                              labelText: 'Car brand',
                              initialValue: brand,
                              fieldHint: 'Hyundai',
                              keyType: TextInputType.text,
                              validatorHandler: (value) {
                                if (value?.isEmpty ?? true) {
                                  return ('Please enter a Car brand');
                                }
                                return null;
                              },
                              changeHandler: (value) {
                                brand = value;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20),
                            child: GenericInput(
                              labelText: 'Model',
                              initialValue: model,
                              fieldHint: 'Elantra',
                              keyType: TextInputType.text,
                              iconHeight: 12,
                              iconWidth: 18,
                              validatorHandler: (value) {
                                if (value?.isEmpty ?? true) {
                                  return ('Please enter a Car Model');
                                }
                                return null;
                              },
                              changeHandler: (value) {
                                model = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Parking Spot Size:',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFC0C1C2)),
                      ),
                    ),
                    CustomDropDownButton(
                        itemSelected: cardSize,
                        onPressDropDown: (String? newValue) {
                          setState(() {
                            cardSize = newValue.toString();
                          });
                        },
                        dropdownItems: dropdownItems),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GenericInput(
                        labelText: 'Plate number',
                        initialValue: plate,
                        fieldHint: 'HNX-1973',
                        validatorHandler: (value) {
                          if (value?.isEmpty ?? true) {
                            return ('Please enter a Plate number');
                          }
                          return null;
                        },
                        changeHandler: (value) {
                          plate = value;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GenericInput(
                        labelText: 'Car color',
                        initialValue: color,
                        fieldHint: 'White',
                        validatorHandler: (value) {
                          if (value?.isEmpty ?? true) {
                            return ('Please enter a Car color');
                          }
                          return null;
                        },
                        changeHandler: (value) {
                          color = value;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RoundedButton(
                            btnText: 'Cancel',
                            color: Color(0xFF1B1C20),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          RoundedButton(
                              width: _screenSize.width * 0.4,
                              btnText: 'Accept',
                              onPressed: () {
                                if (keyForm.currentState?.validate() ?? false) {
                                  bloc?.add(EditCarSentEvent(
                                      carId,
                                      brand,
                                      color,
                                      model,
                                      plate,
                                      enums.getKeyInMap(cardSize)));
                                }
                              }),
                        ],
                      ),
                    ),
                    SizedBox(height: _screenSize.height * 0.01),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
