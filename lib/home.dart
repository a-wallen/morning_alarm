import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:morning_alarm/utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer timer;
  DateTime now;
  String date;
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        DateTime now = DateTime.now();
        String date = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String date = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    return Container(
      color: Colors.white70,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              date,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 24.0,
              ),
            ),
            FlatButton(
              color: Colors.black54,
              child: Icon(
                Icons.alarm,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}
