import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/feature/search/domain/entity/auction_result_response_entity.dart';

class CustomCardAuctionWon extends StatelessWidget {
  CustomCardAuctionWon({
    Key? key,
    this.changeHandler,
    this.onPressed,
    required this.parkedUser,
  }) : super(key: key);

  final Function(String)? changeHandler;
  final Function()? onPressed;
  final ParkedUser parkedUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.80,
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
          margin: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Text('Details',
                          style: TextStyle(
                              color: Color(0xFFC0C1C2),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 18))),
                ],
              ),
              Container(
                  child: Text('Parking Spot Location',
                      style: TextStyle(
                          color: Color(0xFFC0C1C2),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 14))),
              Container(
                  child: Text(
                      '${parkedUser.parkedLocality} ${parkedUser.parkedState} ${parkedUser.parkedCountry}',
                      style: TextStyle(
                          color: Color(0xFFFF4F01),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w300,
                          fontSize: 13.5))),
              Container(
                  child: Text('Person who auctioned',
                      style: TextStyle(
                          color: Color(0xFFC0C1C2),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 14))),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('${parkedUser.parkedUserAvatar}'),
                        placeholder: AssetImage('assets/images/avatar.png'),
                      ),
                      width: size.width * 0.32,
                      height: size.height * 0.16,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: size.width * 0.38,
                    height: size.height * 0.16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Text('Name',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text('${parkedUser.parkedUserFullName}',
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.5))),
                        Spacer(),
                        Container(
                            child: Text('Phone Number',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text('${parkedUser.parkedUserPhone}',
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.5)))
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: size.height * 0.15,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.32,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text('Car Brand',
                                      style: TextStyle(
                                          color: Color(0xFFC0C1C2),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14))),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                  child: Text('${parkedUser.parkedCarBrand}',
                                      style: TextStyle(
                                          color: Color(0xFFFF4F01),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13.5)))
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.32,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text('Model',
                                      style: TextStyle(
                                          color: Color(0xFFC0C1C2),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14))),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                  child: Text('${parkedUser.parkedCarModel}',
                                      style: TextStyle(
                                          color: Color(0xFFFF4F01),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13.5)))
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.32,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text('Car Color',
                                      style: TextStyle(
                                          color: Color(0xFFC0C1C2),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14))),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                  child: Text('${parkedUser.parkedCarColor}',
                                      style: TextStyle(
                                          color: Color(0xFFFF4F01),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13.5)))
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.32,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text('Plate Number',
                                      style: TextStyle(
                                          color: Color(0xFFC0C1C2),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14))),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                  child: Text(
                                      '${parkedUser.parkedCarPlateNumber}',
                                      style: TextStyle(
                                          color: Color(0xFFFF4F01),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13.5)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                child: Center(
                    child: RoundedButton(
                        textSize: 14,
                        color: Color(0xFF1D2025),
                        height: size.height * 0.06,
                        width: size.width * 0.55,
                        padding: EdgeInsets.zero,
                        btnText: 'Go to the location',
                        onPressed: () {})),
              ),
              Center(
                  child: RoundedButton(
                      textSize: 14,
                      height: size.height * 0.06,
                      width: size.width * 0.55,
                      padding: EdgeInsets.only(bottom: 10),
                      btnText: 'Accept',
                      onPressed: () {})),
            ],
          ),
        ),
      ),
    );
  }
}
