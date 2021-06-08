import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mailbot_app/logic/DAO.dart';
import 'package:mailbot_app/logic/savedata.dart';
import 'package:mailbot_app/models/dileveryitemmodel.dart';
import 'package:mailbot_app/screens/add_item_screen.dart';
import 'package:mailbot_app/screens/delivery_info_screen.dart';
import 'package:mailbot_app/screens/settings_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'camera_his_screen.dart';
import 'delivery_his_screen.dart';

class HomeScreen extends StatefulWidget {
  final String serialNum;
  HomeScreen({this.serialNum});

  @override
  _HomeScreenState createState() => _HomeScreenState(serialNum);
}

class _HomeScreenState extends State<HomeScreen> {
  String serialNum;
  _HomeScreenState(this.serialNum);
  List<DItem> items = [];
  var sql = DAO();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var itemsLength = 0;
  @override
  void initState() {
    sql.getItems().then((value) {
      setState(() {
        items = value;
        itemsLength = value.length;
      });
    });
    new Timer.periodic(Duration(seconds: 20), (t) {
      sql.getItems().then((value) {
        if (itemsLength != value.length) {
          showNotification();
          setState(() {
            itemsLength = value.length;
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
                    return AddItem();
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
                    return DeliveryHistory();
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
                    return CameraHisScreen();
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
              onTap: () {},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.blueGrey,
                        ),
                        onPressed: () {}),
                  ),
                ],
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
                        showNotification();
                      })
                ],
              ),
              Container(
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: ListView.builder(
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
                                    time: items[i].time,
                                  );
                                }),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 10),
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
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (ctx, i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(items[itemsLength - 1].title,
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return DeliveryInfo(
                                          title: items[itemsLength - 1]
                                              .title
                                              .toString(),
                                          num: items[itemsLength - 1]
                                              .id
                                              .toString(),
                                          time: items[itemsLength - 1].time,
                                        );
                                      }),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
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

  void checkDatabase() async {
    new Timer.periodic(Duration(seconds: 5), (Timer t) {
      sql.getItems().then((value) {
        setState(() {
          itemsLength = value.length;
        });
      });
      print(itemsLength);
    });
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin
        .show(0, 'Add Item', 'New item', platform, payload: 'La');
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
  }
}
