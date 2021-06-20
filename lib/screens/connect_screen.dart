import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailbot_app/logic/DAO.dart';
import 'package:mailbot_app/screens/home_screen.dart';

class ConnectToMailbot extends StatefulWidget {
  final String serial;

  const ConnectToMailbot({this.serial});
  @override
  _ConnectToMailbotState createState() => _ConnectToMailbotState(serial);
}

class _ConnectToMailbotState extends State<ConnectToMailbot> {
  String serial;
  _ConnectToMailbotState(this.serial);
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController1 = TextEditingController();

  bool connected = false;
  var sql = DAO();
  @override
  void dispose() {
    super.dispose();

    _textEditingController.dispose();
    _textEditingController1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          backgroundColor: Colors.grey[350],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Container(
                height: 10,
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
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 15,
                  left: 35,
                  right: 35,
                ),
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(hintText: 'Enter it here'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(right: 240, top: 50),
                child: Text('Config ID',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 15,
                  left: 35,
                  right: 35,
                  bottom: 50,
                ),
                child: TextField(
                  controller: _textEditingController1,
                  decoration: InputDecoration(hintText: 'Enter it here'),
                ),
              ),
              Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey)),
                  child: Text(
                    'Connect',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () async {
                    await sql
                        .login(_textEditingController.text,
                            _textEditingController1.text)
                        .then((value) async {
                      if (value.email != null) {
                        if (value.serialNum == serial) {
                          connected = true;
                        }
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
                              return HomeScreen(
                                userID: value.userID.toString(),
                                serialNum: value.serialNum.toString(),
                                email: value.email.toString(),
                              );
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
                      }
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ]),
          ),
        ));
  }
}
