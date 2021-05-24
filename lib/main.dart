import 'package:flutter/material.dart';
import 'package:mailbot_app/screens/registration_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // routes: {
      //   '/': (context) => Login(),
      // },
      home: Register(),
    );
  }
}
