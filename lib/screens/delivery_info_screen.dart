import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryInfo extends StatefulWidget {
  final String title;
  final String num;
  final String url;
  final DateTime time;
  DeliveryInfo({this.title, this.num, this.url, this.time});

  @override
  _DeliveryInfoState createState() => _DeliveryInfoState(title, num, url, time);
}

class _DeliveryInfoState extends State<DeliveryInfo> {
  String title, num, url;
  DateTime time;
  DateFormat date = DateFormat('yyyy/MM/dd');
  DateFormat timee = DateFormat('H:m:s');
  _DeliveryInfoState(this.title, this.num, this.url, this.time);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.blueGrey,
          size: 30.0,
        ),
        backgroundColor: Colors.grey[350],
        title: Text(
          'Delivery Info',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[350],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 45,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 30,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1, //                   <--- border width here
                    ),
                    color: Colors.grey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order No.'),
                        Text(num),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 30,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1, //                   <--- border width here
                    ),
                    color: Colors.grey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order Title'),
                        Text(title),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 30,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1, //                   <--- border width here
                    ),
                    color: Colors.grey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Camera Recording'),
                        IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              size: 18,
                            ),
                            onPressed: () async {
                              print(url);
                              await launch(
                                "http://${url}",
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.date_range,
                size: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 30,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1, //                   <--- border width here
                    ),
                    color: Colors.grey,
                  ),
                  child: Center(
                    child: Text(date.format(time).toString()),
                  ),
                ),
              ),
              Icon(
                Icons.timelapse,
                size: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 30,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1, //                   <--- border width here
                    ),
                    color: Colors.grey,
                  ),
                  child: Center(
                    child: Text(timee.format(time).toString()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
