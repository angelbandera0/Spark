import 'package:flutter/material.dart';

class CustomCountDownButton extends AnimatedWidget {
  CustomCountDownButton({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  final Animation<int> animation;

  @override
  Widget build(BuildContext context) {
    return Text('Resend (${animation.value.toString()})',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFFC0C1C2),
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ));
  }
}
