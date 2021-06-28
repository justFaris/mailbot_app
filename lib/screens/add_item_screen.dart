import 'package:flutter/material.dart';
import 'package:mailbot_app/logic/DAO.dart';
import 'package:mailbot_app/screens/home_screen.dart';

class AddItem extends StatefulWidget {
  final String serialNum;
  final String userID;
  final String email;

  const AddItem({
    this.serialNum,
    this.userID,
    this.email,
  });
  @override
  _AddItemState createState() => _AddItemState(serialNum, userID, email);
}

class _AddItemState extends State<AddItem> {
  String serialNum;
  String userID;
  String email;
  _AddItemState(this.serialNum, this.userID, this.email);
  var sql = DAO();
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  bool value = false;
  bool value2 = false;
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
      body: SingleChildScrollView(
        child: Center(
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
                    textAlign: TextAlign.center,
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
                    textAlign: TextAlign.center,
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
                  value: this.value2,
                  onChanged: (bool value) {
                    setState(() {
                      this.value2 = value;
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
                  onPressed: () async {
                    print(userID);
                    await sql.insertItem(
                        int.parse(userID),
                        int.parse(_textEditingController2.text),
                        value == true ? 1 : 0,
                        value2 == true ? 1 : 0,
                        _textEditingController1.text);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return HomeScreen(
                          email: email,
                          userID: userID,
                          serialNum: serialNum,
                        );
                      }),
                    );
                  },
                ),
              )
            ],
          ), //Column
        ),
      ), //Center//Center
      //Scaffold
    ); //MaterialApp
  }
}
