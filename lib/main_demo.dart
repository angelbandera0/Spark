import 'package:flutter/material.dart';
import 'package:sparkz/di/inyector.dart';
import 'package:sparkz/feature/account_management/presentation/pages/log_in_page.dart';

void main() {
  Injector.initDemo();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LogInPage(signalRService: Injector.instance!.getDependency()),
    );
  }
}
