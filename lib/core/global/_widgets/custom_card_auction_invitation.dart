import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';

import 'generics_inputs.dart';

class CustomCardAuctionInvitations extends StatelessWidget {
  CustomCardAuctionInvitations({
    Key? key,
    required this.size,
    required this.entity,
    this.changeHandler,
    this.onPressed,
  }) : super(key: key);
  final Size size;
  final ParkedEntity entity;
  final Function(String)? changeHandler;
  final Function()? onPressed;
  final RegExp numberRegExp = RegExp(r"^[0-9]+([.][0-9]+)?$");
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.65,
      margin: EdgeInsets.only(right: 20, left: 20, top: 10),
      width: size.width,
      child: Neumorphic(
        style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            shadowDarkColor: Colors.black,
            shadowLightColor: Colors.white38,
            color: Color(0xFF1D2025)),
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Parking Spot Location:',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text(
                                '${entity.location.locality} ${entity.location.state} ${entity.location.country}',
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14)))
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Parking Spot Size:',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text(entity.size,
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14)))
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Wait Time:',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text('${entity.waitTime.toString()} minutes',
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14)))
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
                            child: Text('Minimun Bid:',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text(
                                '\$${entity.minimunBid.floor().toString()}/minute',
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14)))
                      ],
                    ),
                  ),
                ],
              ),
              GenericInput(
                labelText: 'Enter Bid:',
                fieldHint: '30',
                initialValue: entity.minimunBid.toString(),
                keyType: TextInputType.number,
                validatorHandler: (value) {
                  if ((value?.isEmpty ?? true) ||
                      (!numberRegExp.hasMatch(value!))) {
                    return 'Please enter a valid Bid';
                  }
                  if (double.parse(value) <= entity.minimunBid) {
                    return 'Bid must be higher';
                  }

                  return null;
                },
                changeHandler: changeHandler,
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: RoundedButton(
                      btnText: 'Submit Bid', onPressed: onPressed)),
            ],
          ),
        ),
      ),
    );
  }
}
