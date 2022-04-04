import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/feature/car/presentation/bloc/activate_car/activate_car_bloc.dart';
import 'package:sparkz/feature/car/presentation/pages/car_menu_page.dart';

class CustomCardCar extends StatefulWidget {
  CustomCardCar(
      {Key? key,
      required this.carId,
      required this.title,
      required this.cardBran,
      required this.cardModel,
      required this.cardSize,
      required this.plateNumber,
      required this.carColor,
      required this.isSwitched})
      : super(key: key);
  final int carId;
  final String title;
  final String cardBran;
  final String cardModel;
  final String cardSize;
  final String plateNumber;
  final String carColor;
  final bool isSwitched;

  @override
  _CustomCardCarState createState() => _CustomCardCarState();
}

class _CustomCardCarState extends State<CustomCardCar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.38,
      margin: EdgeInsets.only(bottom: 15, right: 20, left: 20, top: 5),
      width: size.width,
      child: Neumorphic(
        style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            shadowDarkColor: Colors.black,
            shadowLightColor: Colors.white38,
            color: Color(0xFF1D2025)),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title,
                        style: TextStyle(
                            color: Color(0xFFC0C1C2),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal,
                            fontSize: 18)),
                    Spacer(),
                    Text('Active',
                        style: TextStyle(
                            color: Color(0xFFC0C1C2),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal,
                            fontSize: 15)),
                    SizedBox(width: 6),
                    ActivateCarSwitch(
                        id: widget.carId, isActive: widget.isSwitched)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Car Brand',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text(widget.cardBran,
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)))
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: size.width * 0.15),
                            child: Text('Model',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text(widget.cardModel,
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)))
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Car Size',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text(widget.cardSize,
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Plate Number',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text(widget.plateNumber,
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)))
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Car Color',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text(widget.carColor,
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivateCarSwitch extends StatefulWidget {
  const ActivateCarSwitch({Key? key, required this.id, required this.isActive})
      : super(key: key);

  final int id;
  final bool isActive;

  @override
  _ActivateCarSwitchState createState() => _ActivateCarSwitchState();
}

class _ActivateCarSwitchState
    extends StateWithBloC<ActivateCarSwitch, ActivateCarBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    bool isSwitched = widget.isActive;
    return BlocConsumer<ActivateCarBloc, ActivateCarState>(
        listener: (context, state) {
      if (state is ActivateCarSuccessState) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CarMenuPage()));
      }
      return;
    }, builder: (context, state) {
      return FlutterSwitch(
        width: 30.0,
        height: 15.0,
        valueFontSize: 10.0,
        toggleSize: 8.0,
        value: isSwitched,
        toggleColor: Colors.grey,
        activeToggleColor: Color(0xFFFF4F01),
        activeColor: Colors.white,
        inactiveColor: Colors.black,
        onToggle: (val) {
          context
              .read<ActivateCarBloc>()
              .add(ActivateCarSentEvent(widget.id, val));
        },
      );
    });
  }
}
