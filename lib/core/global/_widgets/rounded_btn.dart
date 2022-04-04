import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {@required this.btnText,
      @required this.onPressed,
      this.color = const Color(0xFFFF4F01),
      this.textColor = Colors.white,
      this.textSize = 16,
      this.width = 155,
      this.height = 50,
      this.borderColor = const Color(0xff656565),
      this.icon,
      this.padding});

  final Color? color;
  final String? btnText;
  final Function()? onPressed;
  final double width;
  final double height;
  final Color? textColor;
  final double? textSize;
  final Color? borderColor;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        width: width,
        height: height,
        child: NeumorphicButton(
          onPressed: onPressed,
          style: NeumorphicStyle(
              depth: 3,
              intensity: 1,
              shadowDarkColor: Colors.black,
              shadowLightColor: Colors.white38,
              color: color ?? Color(0xFFFF4F01)),
          child: Center(
            child: (icon == null)
                ? Text(
                    btnText ?? "",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 22,
                        color: Color(0xFFFF4F01),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        btnText ?? "",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: textSize,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
