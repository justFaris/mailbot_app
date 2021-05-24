import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController3 = TextEditingController();
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 35,
                right: 35,
                bottom: 50,
              ),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(hintText: 'Enter it here'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 235, top: 10),
              child: Text('Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 35,
                right: 35,
                bottom: 50,
              ),
              child: TextField(
                controller: _textEditingController3,
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
                  'Register',
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  print('ok');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) {
                  //     return SuccessfullyReg(_textEditingController);
                  //   }),
                  // );
                },
              ),
            )
          ]),
        ));
  }
}
