import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/di/inyector.dart';

import 'log_in_page.dart';

class SignUpConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding;
    final _appBarPreferredSize = _screenSize.height * 0.15;
    final separator = SizedBox(height: _screenSize.height * 0.05);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          child: CustomAppBar(
            leading: CustomUpperButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icons.arrow_back,
            ),
            title: '',
          ),
          preferredSize: Size(_screenSize.width, _appBarPreferredSize)),
      backgroundColor: Color(0xFF2E3238),
      body: SafeArea(
        child: Container(
          width: _screenSize.width,
          height: (_screenSize.height - _appBarPreferredSize - _padding.top),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF34393F),
              Color(0xFF1B1C20),
            ],
          )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                separator,
                Container(
                  child: Image.asset(
                    'assets/images/parking_car.png',
                    height: _screenSize.height * 0.4,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                separator,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: AutoSizeText('Congratulations, you already',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFC0C1C2),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(height: _screenSize.height * 0.02),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: AutoSizeText('have an account',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFC0C1C2),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      )),
                ),
                separator,
                RoundedButton(
                    btnText: 'Go Ahead!',
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (_) => LogInPage(
                                signalRService:
                                    Injector.instance!.getDependency())),
                        (route) => false))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
