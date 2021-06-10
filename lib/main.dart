import 'package:flutter/material.dart';
import 'package:mailbot_app/screens/connect_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: ConnectToMailbot(),
    );
  }
}
