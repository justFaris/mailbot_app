import 'package:flutter/material.dart';

class EditPasswordScreen extends StatefulWidget {
  EditPasswordScreen({Key key}) : super(key: key);

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
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
          'Edit Password',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
      body: Column(
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
              ),
            ),
          ),
          Text(
            'Confirm new password',
            style: TextStyle(fontSize: 20), //TextStyle
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
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
