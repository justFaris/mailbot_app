import 'package:flutter/material.dart';
import 'package:mailbot_app/screens/edit_email_screen.dart';
import 'package:mailbot_app/screens/edit_pass_screen.dart';

class SettingsScreen extends StatefulWidget {
  final String serialNum;
  SettingsScreen({this.serialNum});

  @override
  _SettingsScreenState createState() => _SettingsScreenState(serialNum);
}

class _SettingsScreenState extends State<SettingsScreen> {
  String serialNum;
  _SettingsScreenState(this.serialNum);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blueGrey,
          size: 30.0,
        ),
        backgroundColor: Colors.grey[350],
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Container(
                width: 330,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                    Colors.blueGrey,
                  )),
                  child: Text(
                    'Edit Email',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return EditEmailScreen();
                      }),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Container(
                width: 330,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                    Colors.blueGrey,
                  )),
                  child: Text(
                    'Edit Password',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return EditPasswordScreen(
                          serialNum: serialNum,
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Container(
                width: 330,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                    Colors.blueGrey,
                  )),
                  child: Text(
                    'e-manual',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
