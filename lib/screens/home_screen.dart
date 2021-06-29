import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mailbot_app/logic/DAO.dart';
import 'package:mailbot_app/models/camerahistory.dart';
import 'package:mailbot_app/models/dileveryitemmodel.dart';
import 'package:mailbot_app/screens/add_item_screen.dart';
import 'package:mailbot_app/screens/delivery_info_screen.dart';
import 'package:mailbot_app/screens/settings_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'camera_his_screen.dart';
import 'delivery_his_screen.dart';
import 'dart:io';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  final String serialNum;
  final String userID;
  final String email;
  HomeScreen({
    this.serialNum,
    this.userID,
    this.email,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState(serialNum, userID, email);
}

class _HomeScreenState extends State<HomeScreen> {
  String serialNum;
  String userID;
  String email;
  _HomeScreenState(this.serialNum, this.userID, this.email);
  final TextEditingController _textEditingController1 = TextEditingController();
  List<DItem> items = [];
  List<DItem> ditems = [];
  List<DItem> _searchResult = [];
  List<CameraHisModel> cItems = [];
  var sql = DAO();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var itemsLength = 0;
  var dLength = 0;
  var invalidLength = 0;
  @override
  void initState() {
    sql.getCameraHistory(email).then((value) {
      setState(() {
        cItems = value;
      });
    });
    sql.checkValidWeightSize().then((value) {
      setState(() {
        invalidLength = value.length;
      });
    });
    sql.getPendingItems().then((value) {
      setState(() {
        items = value;
        itemsLength = value.length;
      });
    });
    sql.getAllItems().then((value) {
      setState(() {
        ditems = value;
        dLength = value.length;
      });
    });
    new Timer.periodic(Duration(seconds: 10), (t) {
      sql.getPendingItems().then((value) {
        sql.getAllItems().then((value2) {
        if (itemsLength != value.length && itemsLength >= value.length) {       
            setState(() {
              items = value;
              itemsLength = value.length;
              ditems = value2;
              dLength = value2.length;
            });
            showNotification('Delivered Item', 'Item Delivered Successfully');
        } else {
          setState(() {
            items = value;
            itemsLength = value.length;
          });
        }
      });
      });
      sql.checkValidWeightSize().then((value) {
        if (invalidLength != value.length && invalidLength >= value.length) {
          setState(() {
            invalidLength = value.length;
          });
          showNotification('Invalid Item', 'Item Weight or Size Invalid');
        } else {
         setState(() {
            invalidLength = value.length;
          });
        }
      });
    });
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  onChanged(String value) {
    _searchResult.clear();
    if (value.isEmpty) {
      setState(() {});
      return;
    }

    items.forEach((itemsDetail) {
      if (itemsDetail.title.contains(value)) {
        setState(() {
          _searchResult.add(itemsDetail);
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                serialNum,
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return AddItem(
                      email: email,
                      userID: userID,
                      serialNum: serialNum,
                    );
                  }),
                );
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Add item',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return DeliveryHistory(
                      email: email,
                    );
                  }),
                );
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Delivery history',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return CameraHisScreen(
                      email: email,
                    );
                  }),
                );
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Camera history',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                socketConnect();
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Open MailBot',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SettingsScreen(
                      serialNum: serialNum,
                    );
                  }),
                );
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blueGrey,
          size: 30.0,
        ),
        backgroundColor: Colors.grey[350],
        elevation: 0,
        title: Text(
          serialNum,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                child: Flexible(
                    child: TextField(
                  keyboardType: TextInputType.text,
                  onChanged: (value) => onChanged(value),
                  controller: _textEditingController1,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 1.0),
                    ),
                    hintText: 'Order Title',
                  ),
                )),
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                thickness: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Pending Items",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(),
                  SizedBox(),
                  IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.blueGrey,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return AddItem(
                              email: email,
                              userID: userID,
                              serialNum: serialNum,
                            );
                          }),
                        );
                      })
                ],
              ),
              Container(
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: items.length == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : _searchResult.length != 0 ||
                            _textEditingController1.text.isNotEmpty
                        ? ListView.builder(
                            itemCount: _searchResult.length,
                            itemBuilder: (ctx, i) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return DeliveryInfo(
                                            title: _searchResult[i]
                                                .title
                                                .toString(),
                                            num: _searchResult[i].id.toString(),
                                            time: _searchResult[i].time,
                                          );
                                        }),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 10),
                                      child: Text(_searchResult[i].title,
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                          )),
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return DeliveryInfo(
                                            title: items[i].title.toString(),
                                            num: items[i].id.toString(),
                                            url: cItems[i].url != null
                                                ? cItems[i].url
                                                : "www.google.com",
                                            time: items[i].time,
                                          );
                                        }),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 10),
                                      child: Text(items[i].title,
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                          )),
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
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text(
                      "Recent Delivery",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: items.length == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: 1,
                        itemBuilder: (ctx, i) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(ditems.first.title,
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                        )),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return DeliveryInfo(
                                              title:
                                                  ditems.first.title.toString(),
                                              num: ditems.first.id.toString(),
                                              url: cItems[i].url != null
                                                  ? cItems[i].url
                                                  : "www.google.com",
                                              time: ditems.first.time,
                                            );
                                          }),
                                        );
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          Icons.info_outline,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 23.0, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return DeliveryHistory();
                          }),
                        );
                      },
                      child: Text(
                        "expand",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showNotification(body, payload) async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(0, 'Mailbot', body, platform,
        payload: payload);
  }

  Future onSelectNotification(String payload) async {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
        actions: [],
      ),
    );
  }

  socketConnect() async {
    Socket socket = await Socket.connect('192.168.1.124', 65432);
    socket.listen((List<int> event) {
      print(utf8.decode(event));
    });
    var message = Uint8List(1);
    var bytedata = ByteData.view(message.buffer);
    bytedata.setUint8(0, 0x01);
    socket.add(message);
    await Future.delayed(Duration(seconds: 5));

    socket.close();
  }
}
