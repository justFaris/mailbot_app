import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:mailbot_app/logic/DAO.dart';
import 'package:mailbot_app/logic/User.dart';

class EditPasswordScreen extends StatefulWidget {
  final String serialNum;
  EditPasswordScreen({this.serialNum});

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState(serialNum);
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  String serialNum;
  _EditPasswordScreenState(this.serialNum);
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  var sql = DAO();
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
          'Edit Password',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Enter your old password',
              style: TextStyle(fontSize: 20), //TextStyle
            ),
            Container(
              padding: EdgeInsets.only(
                left: 35,
                right: 35,
                bottom: 20,
              ),
              child: Card(
                elevation: 10,
                child: TextField(
                  controller: _textEditingController1,
                  textAlign: TextAlign.center,
                  obscureText: true,
                ),
              ),
            ),
            Text(
              'Enter your new password',
              style: TextStyle(fontSize: 20), //TextStyle
            ),
            Container(
              padding: EdgeInsets.only(
                left: 35,
                right: 35,
                bottom: 20,
              ),
              child: Card(
                elevation: 10,
                child: TextField(
                  controller: _textEditingController2,
                  textAlign: TextAlign.center,
                  obscureText: true,
                ),
              ),
            ),
            Container(
              width: 330,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                  Colors.blueGrey,
                )),
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  if (_textEditingController1.text.isNotEmpty) {
                    if (_textEditingController2.text.isNotEmpty) {
                      if (_textEditingController1.text !=
                          _textEditingController2.text) {
                        sql
                            .editPass(
                                serialNum,
                                User(password: _textEditingController1.text)
                                    .hash
                                    .toString(),
                                User(password: _textEditingController2.text)
                                    .hash
                                    .toString())
                            .then((value) {
                          if (value == 'password changed') {
                            EdgeAlert.show(
                              context,
                              title: 'Password Changed Successfully',
                              icon: Icons.done,
                              backgroundColor: Colors.green,
                              gravity: EdgeAlert.TOP,
                            );
                          } else if (value == 'password not changed') {
                            EdgeAlert.show(
                              context,
                              title: 'Password not changed',
                              icon: Icons.error,
                              backgroundColor: Colors.red,
                              gravity: EdgeAlert.TOP,
                            );
                          } else {
                            EdgeAlert.show(
                              context,
                              title: 'Check your old password',
                              icon: Icons.error,
                              backgroundColor: Colors.red,
                              gravity: EdgeAlert.TOP,
                            );
                          }
                        });
                      } else {
                        EdgeAlert.show(
                          context,
                          title: 'Old pass is same new pass',
                          icon: Icons.error,
                          backgroundColor: Colors.red,
                          gravity: EdgeAlert.TOP,
                        );
                      }
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
