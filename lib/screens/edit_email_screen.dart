import 'package:flutter/material.dart';

class EditEmailScreen extends StatefulWidget {
  EditEmailScreen({Key key}) : super(key: key);

  @override
  _EditEmailScreenState createState() => _EditEmailScreenState();
}

class _EditEmailScreenState extends State<EditEmailScreen> {
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
      body: Column(
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
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
