import 'package:flutter/material.dart';
import 'package:mailbot_app/logic/DAO.dart';
import 'package:mailbot_app/models/camerahistory.dart';
import 'package:mailbot_app/models/dileveryitemmodel.dart';

import 'delivery_info_screen.dart';

class DeliveryHistory extends StatefulWidget {
  final String email;
  DeliveryHistory({this.email});
  @override
  _DeliveryHistoryState createState() => _DeliveryHistoryState(email);
}

class _DeliveryHistoryState extends State<DeliveryHistory> {
  String email;
  _DeliveryHistoryState(this.email);
  final TextEditingController _textEditingController1 = TextEditingController();
  List<DItem> items = [];
  List<CameraHisModel> cItems = [];
  List<DItem> _searchResult = [];
  var sql = DAO();
  @override
  void initState() {
    sql.getCameraHistory(email).then((value) {
      setState(() {
        cItems = value;
      });
    });
    sql.getAllItems().then((value) {
      setState(() {
        items = value;
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

    items.forEach((itemsDetail) {
      if (itemsDetail.id.contains(value)) {
        setState(() {
          _searchResult.add(itemsDetail);
        });
      }
    });
  }

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
          'Delivery history',
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
                    keyboardType: TextInputType.number,
                    onChanged: (value) => onChanged(value),
                    controller: _textEditingController1,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black12, width: 1.0),
                      ),
                      hintText: 'Order Number',
                    ),
                  )),
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
                child: _searchResult.length != 0 ||
                        _textEditingController1.text.isNotEmpty
                    ? ListView.builder(
                        itemCount: _searchResult.length,
                        itemBuilder: (ctx, i) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.info_outline,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return DeliveryInfo(
                                                title: _searchResult[i].title,
                                                time: _searchResult[i].time,
                                                num: _searchResult[i].id,
                                                url: cItems[i].url != null
                                                    ? cItems[i].url
                                                    : "www.google.com",
                                              );
                                            }),
                                          );
                                        }),
                                    Expanded(
                                      child: Text(
                                        _searchResult[i].id.toString(),
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      _searchResult[i].time.toString(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                indent: 15,
                                endIndent: 15,
                                thickness: 1,
                              ),
                            ],
                          );
                        })
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (ctx, i) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.info_outline,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return DeliveryInfo(
                                                title: items[i].title,
                                                time: items[i].time,
                                                num: items[i].id,
                                                url: cItems[i].url != null
                                                    ? cItems[i].url
                                                    : "www.google.com",
                                              );
                                            }),
                                          );
                                        }),
                                    Expanded(
                                      child: Text(
                                        items[i].id.toString(),
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      items[i].time.toString(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                indent: 15,
                                endIndent: 15,
                                thickness: 1,
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
