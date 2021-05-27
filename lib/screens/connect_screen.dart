import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailbot_app/screens/home_screen.dart';

class ConnectToMailbot extends StatefulWidget {
  @override
  _ConnectToMailbotState createState() => _ConnectToMailbotState();
}

class _ConnectToMailbotState extends State<ConnectToMailbot> {
  final TextEditingController _textEditingController = TextEditingController();
  bool connected = true;
  @override
  void dispose() {
    super.dispose();

    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[350],
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        // ),
        body: Center(
          child: Column(children: [
            Container(
              height: 150,
            ),
            Text(
              'Connect to MailBot',
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: 70,
            ),
            Container(
              padding: EdgeInsets.only(right: 250, top: 50),
              child: Text('Serial ID',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 35,
                right: 35,
                bottom: 100,
              ),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(hintText: 'Enter it here'),
              ),
            ),
            Container(
              width: 100,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueGrey)),
                child: Text(
                  'Connect',
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  if (connected) {
                    EdgeAlert.show(
                      context,
                      title: 'Connnected',
                      icon: Icons.done,
                      backgroundColor: Colors.green,
                      gravity: EdgeAlert.TOP,
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }),
                    );
                  } else {
                    EdgeAlert.show(
                      context,
                      title: 'Faild To Connect',
                      icon: Icons.error,
                      backgroundColor: Colors.red,
                      gravity: EdgeAlert.TOP,
                    );
                  }
                },
              ),
            )
          ]),
        ));
  }
}
