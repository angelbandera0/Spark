import 'package:flutter/material.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final appBarPreferredSize = size.height * 0.15;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        child:Container(
          margin: EdgeInsets.only(right:150.0),
          child: CustomAppBar(
            leading: CustomUpperButton(
              icon: Icons.arrow_back,
            ),
            title: 'Info',
          ),),
          preferredSize: Size(size.width, appBarPreferredSize)),
      backgroundColor: Color(0xFF34393F),
      body: SingleChildScrollView(
        child: Container(
            height: (size.height - appBarPreferredSize - padding.top),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0xFF34393F),
                  Color(0xFF1B1C20),
                ])),
            child: Container(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      height: size.height * 0.23,
                      child: Center(
                          child: Image.asset('assets/images/login.png'))),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFC0C1C2)),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    '© 2021. All Rights Reserved',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFC0C1C2)),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
