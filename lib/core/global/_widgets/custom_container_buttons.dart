import 'package:flutter/material.dart';

class CustomContainerButtons extends StatelessWidget {
  CustomContainerButtons({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(-2, 1.05),
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/images/home_bottom.png'),
          ),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF34393F),
                Color(0xFF1B1C20),
              ])),
      child: child,
    );
  }
}
