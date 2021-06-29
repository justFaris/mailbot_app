import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mailbot_app/logic/DAO.dart';
import 'package:mailbot_app/screens/registration_screen.dart';
import 'package:workmanager/workmanager.dart';

const simplePeriodicTask = "simplePeriodicTask";
var sql = DAO();
var itemsLength = 0;
var dLength = 0;
var invalidLength = 0;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  await Workmanager().registerPeriodicTask("5", simplePeriodicTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      frequency: Duration(minutes: 15), //when should it check the link
      initialDelay:
          Duration(seconds: 5), //duration before showing the notification
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
  runApp(MyApp());
}

void callbackDispatcher() {
  sql.getAllItems().then((value) {
    itemsLength = value.length;
  });
  sql.getPendingItems().then((value) {
    dLength = value.length;
  });
  sql.checkValidWeightSize().then((value) {
    invalidLength = value.length;
  });
  Workmanager().executeTask((task, inputData) async {
    sql.getPendingItems().then((value) {
      sql.getAllItems().then((value2) {
        if (itemsLength != value.length && itemsLength <= value.length) {
          itemsLength = value.length;
          showNotification('Item was Delivered', 'Item Delivered Successfully');
        }
      });
    });
    sql.checkValidWeightSize().then((value) {
      if (invalidLength != value.length && invalidLength >= value.length) {
        showNotification('Invalid Item', 'Item Weight or Size Invalid');
        invalidLength = value.length;
      }
    });
    return Future.value(true);
  });
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Register(),
    );
  }
}
