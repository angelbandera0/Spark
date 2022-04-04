import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomTile extends StatelessWidget {
  CustomTile({
    Key? key,
    this.textTime,
    this.textLocation = 'Fill Location',
    required this.isActive,
  }) : super(key: key);
  final String? textTime;
  final String textLocation;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.14,
      margin: EdgeInsets.only(bottom: 10, right: 15, left: 15, top: 5),
      child: Neumorphic(
        style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            border: isActive
                ? NeumorphicBorder(color: Color(0xFFFF4F01), width: 2)
                : NeumorphicBorder.none(),
            shadowDarkColor: Colors.black,
            shadowLightColor: Colors.white38,
            color: Color(0xFF1D2025)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Parking Location: ',
                      style: TextStyle(
                          color: Color(0xFFC0C1C2),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          fontSize: 16)),
                  RichText(
                      text: TextSpan(
                          text: 'Time:  ',
                          style: TextStyle(
                              color: Color(0xFFC0C1C2),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                          children: [
                        TextSpan(
                            text: textTime,
                            style: TextStyle(
                                color: Color(0xFFFF4F01),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w300,
                                fontSize: 14))
                      ]))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(textLocation,
                  maxLines: 2,
                  style: TextStyle(
                      color: Color(0xFFFF4F01),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300,
                      fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}
