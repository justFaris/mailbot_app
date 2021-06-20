import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailbot_app/logic/BO.dart';
import 'package:mailbot_app/logic/DAO.dart';
import 'package:mailbot_app/logic/User.dart';
import 'package:mailbot_app/screens/connect_screen.dart';
import 'package:mailbot_app/screens/registration_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _textEditingController = new TextEditingController();
  var _textEditingController3 = new TextEditingController();
  var sql = DAO();

  @override
  void dispose() {
    super.dispose();
    _textEditingController3.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          backgroundColor: Colors.grey[350],
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blueGrey),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(children: [
                Container(
                  height: 10,
                ),
                Text(
                  'MailBot',
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                Container(
                  height: 30,
                ),
                Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  'Login',
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  padding: EdgeInsets.only(left: 6.0, right: 280, top: 50),
                  child: Text('Email',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 35,
                    right: 35,
                    bottom: 50,
                  ),
                  child: textfield(
                      'Enter it here', _textEditingController, false,
                      validate: true),
                ),
                Container(
                  padding: EdgeInsets.only(right: 235, top: 10),
                  child: Text('Password',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 35,
                    right: 35,
                    bottom: 50,
                  ),
                  child: textfield(
                      'Enter it here', _textEditingController3, true,
                      validate: true),
                ),
                Container(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey)),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () {
                      if (_textEditingController.text.length != 0 ||
                          _textEditingController3.text.length != 0) {
                        sql
                            .loginC(
                          User(password: _textEditingController3.text)
                              .hash
                              .toString(),
                          _textEditingController.text,
                        )
                            .then((value) {
                          if (value != 'false') {
                            print(value);
                            EdgeAlert.show(
                              context,
                              title: 'Logged in Successfully',
                              icon: Icons.done,
                              backgroundColor: Colors.green,
                              gravity: EdgeAlert.TOP,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return ConnectToMailbot(
                                  serial: value,
                                );
                              }),
                            );
                          } else {
                            EdgeAlert.show(
                              context,
                              title: 'Faild to Login',
                              icon: Icons.error,
                              backgroundColor: Colors.red,
                              gravity: EdgeAlert.TOP,
                            );
                          }
                        });
                      } else {
                        EdgeAlert.show(
                          context,
                          title: 'Faild To Login',
                          icon: Icons.error,
                          backgroundColor: Colors.red,
                          gravity: EdgeAlert.TOP,
                        );
                      }
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Register();
                      }),
                    );
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
