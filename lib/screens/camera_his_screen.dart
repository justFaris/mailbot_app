import 'package:flutter/material.dart';

class CameraHisScreen extends StatefulWidget {
  @override
  _CameraHisScreenState createState() => _CameraHisScreenState();
}

class _CameraHisScreenState extends State<CameraHisScreen> {
  final TextEditingController _textEditingController1 = TextEditingController();
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
          'Camera history',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                      child: TextField(
                    controller: _textEditingController1,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black12, width: 1.0),
                      ),
                      hintText: 'DD/MM/YY',
                    ),
                  )),
                  IconButton(icon: Icon(Icons.search), onPressed: () {})
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 350,
                height: 500,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: ListView.builder(
                    itemCount: 50,
                    itemBuilder: (ctx, i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 30,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width:
                                          1, //                   <--- border width here
                                    ),
                                    color: Colors.grey,
                                  ),
                                  child: Center(
                                    child: Text('DD/MM/YY'),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.camera_alt),
                                    onPressed: () {})
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ), //Center//Center
      //Scaffold
    ); //MaterialApp
  }
}
