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
        String date = DateFormat('kk:mm \n EEE d MMM').format(now);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String date = DateFormat('kk:mm \n EEE d MMM').format(now);
    return Container(
      color: Colors.white30,
      child: Center(
        child: Container(
          color:Colors.blue,
          margin: new EdgeInsets.fromLTRB(0, 200.0, 0, 200.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                date,
                textAlign: TextAlign.center,
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
      ),
    );
  }
}
