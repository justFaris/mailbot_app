import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailbot_app/logic/BO.dart';
import 'package:mailbot_app/logic/DAO.dart';
import 'package:mailbot_app/logic/User.dart';
import 'package:mailbot_app/screens/connect_screen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                  'Register your MailBot now.',
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
                      'Register',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () {
                      if (_textEditingController.text.length != 0 ||
                          _textEditingController3.text.length != 0) {
                        sql
                            .insertUser(User(
                                mail: _textEditingController.text,
                                password: _textEditingController3.text))
                            .then((value) {
                          if (value == 'Inserted user succesfullly') {
                            EdgeAlert.show(
                              context,
                              title: 'Registerd',
                              icon: Icons.done,
                              backgroundColor: Colors.green,
                              gravity: EdgeAlert.TOP,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return ConnectToMailbot();
                              }),
                            );
                          }
                          if (value == 'email exists') {
                            EdgeAlert.show(
                              context,
                              title: 'Email is already exists',
                              icon: Icons.error,
                              backgroundColor: Colors.red,
                              gravity: EdgeAlert.TOP,
                            );
                          } else {
                            EdgeAlert.show(
                              context,
                              title: 'Faild to register',
                              icon: Icons.error,
                              backgroundColor: Colors.red,
                              gravity: EdgeAlert.TOP,
                            );
                          }
                        });
                      } else {
                        EdgeAlert.show(
                          context,
                          title: 'Faild To Register',
                          icon: Icons.error,
                          backgroundColor: Colors.red,
                          gravity: EdgeAlert.TOP,
                        );
                      }
                    },
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
