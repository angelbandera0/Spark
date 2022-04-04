import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  CustomCheckBox({this.checkBoxValue = false, @required this.onChangeHandler});

  final bool checkBoxValue;
  final Function(bool?)? onChangeHandler;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 8,
          left: 7,
          child: Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/checkbox_background.png'),
              ),
            ),
          ),
        ),
        Transform.scale(
          scale: 1.1,
          child: Checkbox(
              side: BorderSide(color: Colors.transparent),
              activeColor: Color(0xFFFF4F01),
              checkColor: Color(0xFFC0C1C2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.5),
              ),
              value: checkBoxValue,
              onChanged: onChangeHandler),
        ),
      ],
    );
  }
}
