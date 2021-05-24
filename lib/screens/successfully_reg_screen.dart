import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessfullyReg extends StatelessWidget {
  //SuccessfullyReg(TextEditingController textEditingController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: Center(
        child: Column(
          children: [
            Container(
              height: 400,
            ),
            Text(
              'Successfully Registered',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 50,
            ),
            Icon(
              Icons.verified,
              color: Colors.green,
              size: 33,
            ),
          ],
        ),
      ),
    );
  }
}
