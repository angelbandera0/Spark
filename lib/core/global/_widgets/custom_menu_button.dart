import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class CustomMenuButton extends StatelessWidget {
  const CustomMenuButton(this.icon, this.onClicked);
  final VoidCallback? onClicked;

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.2,
      width: 51.1,
      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
      child: NeumorphicButton(
        onPressed: onClicked,
        style: NeumorphicStyle(
            shadowDarkColor: Colors.black,
            shadowLightColor: Colors.white38,
            depth: 4,
            intensity: 5,
            color: Color(0xFF1B1C20)),
        padding: EdgeInsets.all(5),
        child: Align(
          alignment: Alignment.center,

          child: Icon(
            icon,
            color: Color(0xFFFF4F01),

          ),
        ),
      ),
    );
  }
}
