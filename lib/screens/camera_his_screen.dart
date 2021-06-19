import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mailbot_app/logic/DAO.dart';
import 'package:mailbot_app/models/camerahistory.dart';

class CameraHisScreen extends StatefulWidget {
  final String email;
  CameraHisScreen({this.email});
  @override
  _CameraHisScreenState createState() => _CameraHisScreenState(email);
}

class _CameraHisScreenState extends State<CameraHisScreen> {
  String email;
  _CameraHisScreenState(this.email);
  final TextEditingController _textEditingController1 = TextEditingController();
  bool value = false;
  var sql = DAO();
  List<CameraHisModel> mod = [];
  List<CameraHisModel> _searchResult = [];
  DateFormat date = DateFormat('yyyy/MM/dd');
  @override
  void initState() {
    sql.getCameraHistory(email).then((value) {
      setState(() {
        mod = value;
      });
    });
    super.initState();
  }

  onChanged(String value) {
    _searchResult.clear();
    if (value.isEmpty) {
      setState(() {});
      return;
    }

    mod.forEach((itemsDetail) {
      if (date.format(itemsDetail.recDate).contains(value)) {
        setState(() {
          _searchResult.add(itemsDetail);
        });
      }
    });
  }

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
              TextField(
                controller: _textEditingController1,
                onChanged: (value) => onChanged(value),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12, width: 1.0),
                  ),
                  hintText: 'DD/MM/YY',
                ),
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
                    itemCount: mod.length,
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
                                    child: Text(date.format(mod[i].recDate)),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.camera_alt),
                                    onPressed: () async {
                                      await launch(
                                        'https://${mod[i].url}',
                                        forceWebView: true,
                                      );
                                    })
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
