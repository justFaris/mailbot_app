import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:mailbot_app/logic/DAO.dart';
import 'package:mailbot_app/logic/User.dart';

class EditEmailScreen extends StatefulWidget {
  EditEmailScreen({Key key}) : super(key: key);

  @override
  _EditEmailScreenState createState() => _EditEmailScreenState();
}

class _EditEmailScreenState extends State<EditEmailScreen> {
  var sql = DAO();
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
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
          'Edit Email',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Your old email',
              style: TextStyle(fontSize: 30), //TextStyle
            ),
            Container(
              padding: EdgeInsets.only(
                left: 35,
                right: 35,
                bottom: 50,
              ),
              child: Card(
                elevation: 10,
                child: TextField(
                  controller: _textEditingController1,
                ),
              ),
            ),
            Text(
              'Enter your new email',
              style: TextStyle(fontSize: 30), //TextStyle
            ),
            Container(
              padding: EdgeInsets.only(
                left: 35,
                right: 35,
              ),
              child: Card(
                elevation: 10,
                child: TextField(
                  controller: _textEditingController2,
                ),
              ),
            ),
            SizedBox(
              height: 30,
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
                  if (_textEditingController1.text.isNotEmpty &&
                      _textEditingController1.text.contains("@")) {
                    if (_textEditingController2.text.isNotEmpty &&
                        _textEditingController2.text.contains("@")) {
                      if (_textEditingController1.text !=
                          _textEditingController2.text) {
                        await sql
                            .editEmail(_textEditingController1.text,
                                _textEditingController2.text)
                            .then((value) {
                          print(value);
                          if (value == "email exists") {
                            EdgeAlert.show(
                              context,
                              title: 'Email is already exists',
                              icon: Icons.error,
                              backgroundColor: Colors.red,
                              gravity: EdgeAlert.TOP,
                            );
                          } else if (value == "email changed") {
                            EdgeAlert.show(
                              context,
                              title: 'Email Changed',
                              icon: Icons.done,
                              backgroundColor: Colors.green,
                              gravity: EdgeAlert.TOP,
                            );
                          } else {
                            EdgeAlert.show(
                              context,
                              title: 'Error',
                              icon: Icons.error,
                              backgroundColor: Colors.red,
                              gravity: EdgeAlert.TOP,
                            );
                          }
                        });
                      } else {
                        EdgeAlert.show(
                          context,
                          title: 'Old email is same new email',
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
