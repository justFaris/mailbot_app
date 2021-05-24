import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.blueGrey,
          size: 30.0,
        ),
        backgroundColor: Colors.grey[350],
        title: Text(
          'Add item',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Order Title',
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
              'Order Number',
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
            Text(
              '*to be used as key.',
            ),
            SizedBox(height: 50),
            Row(children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Text(
                'Open cash wallet? ',
                style: TextStyle(fontSize: 20),
              ),
              Checkbox(
                value: this.value,
                onChanged: (bool value) {
                  setState(() {
                    this.value = value;
                  });
                },
              ),
            ]),
            Row(children: <Widget>[
              SizedBox(
                width: 42,
              ),
              Text(
                'Deliver to home? ',
                style: TextStyle(fontSize: 20),
              ),
              Checkbox(
                value: this.value,
                onChanged: (bool value) {
                  setState(() {
                    this.value = value;
                  });
                },
              ), //Checkbox
            ] //<Widget>[]
                ),
            SizedBox(
              height: 40,
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
          ],
        ), //Column
      ), //Center//Center
      //Scaffold
    ); //MaterialApp
  }
}
