import 'package:flutter/material.dart';

import 'custom_leading_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({this.title = '', this.actions, this.leadingButton})
      : preferredSize = Size.fromHeight(75);

  final Size preferredSize;
  final String title;
  final List<Widget>? actions;
  final Widget? leadingButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 75,
      backgroundColor: Color(0xFF34393F),
      leading: leadingButton ?? CustomLeadingButton(context),
      leadingWidth: 75,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Color(0xFFFF4F01),
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }
}
