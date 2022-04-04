import 'package:flutter/material.dart';

class CustomPushLeadingButton extends StatelessWidget {
  const CustomPushLeadingButton({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Widget widget;

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
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          icon: Image.asset(
            'assets/images/back_arrow.png',
          ),
        ));
  }
}
