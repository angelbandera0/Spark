import 'package:flutter/material.dart';

import 'index.dart';

/// Example to show how to popup overlay with custom animation.
class CustomAnimationToast extends StatelessWidget {
  final double value;
  final String message;

  static final Tween<Offset> tweenOffset = Tween<Offset>(
    begin: const Offset(0, 40),
    end: const Offset(0, 0),
  );

  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);

  const CustomAnimationToast({required this.value, required this.message});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: tweenOffset.transform(value),
      child: Opacity(
        opacity: tweenOpacity.transform(value),
        child: IosStyleToast(message: message),
      ),
    );
  }
}
