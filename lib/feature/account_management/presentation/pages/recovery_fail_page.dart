import 'package:flutter/material.dart';
import 'package:sparkz/core/global/_widgets/custom_appbar.dart';

import 'package:sparkz/core/global/_widgets/rounded_btn.dart';

class RecoveryFailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E3238),
      appBar: CustomAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF34393F),
            Color(0xFF1B1C20),
          ],
        )),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Center(
              child: Container(
                  child: Image.asset(
                'assets/images/recovery_fail.png',
                height: 150,
                width: 200,
                fit: BoxFit.fitHeight,
              )),
            ),
            SizedBox(
              height: 38,
            ),
            Text(
              "Ooops!",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFFC0C1C2),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 38,
            ),
            Text(
              "Email you entered does not match",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFC0C1C2),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "our records.",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFC0C1C2),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            RoundedButton(btnText: 'Try again', onPressed: () {})
          ],
        ),
      ),
    );
  }
}
