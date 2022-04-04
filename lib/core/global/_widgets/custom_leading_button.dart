import 'package:flutter/material.dart';

class CustomLeadingButton extends StatelessWidget {
  const CustomLeadingButton(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgorund_leading.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/images/back_arrow.png',
          ),
        ));
  }
}
