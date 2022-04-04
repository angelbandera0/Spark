import 'package:flutter/material.dart';
import 'package:sparkz/core/global/_widgets/custom_appbar.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/di/inyector.dart';
import 'package:sparkz/feature/account_management/presentation/pages/log_in_page.dart';

class RecoverySuccessPage extends StatelessWidget {
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
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/recovery_success.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(
              height: 55,
            ),
            Text(
              "Success!",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFFC0C1C2),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 37),
            Text(
              "The password has been changed",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFC0C1C2),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "successfully",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFC0C1C2),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            RoundedButton(
                btnText: 'Login',
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (_) => LogInPage(
                            signalRService:
                                Injector.instance!.getDependency())),
                    (route) => false))
          ],
        ),
      ),
    );
  }
}
