import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:morning_alarm/utils.dart';

//these steps will have to run on dummy alarm data
//TODO implement push notifications triggered by alarm
//TODO have app run in background

//TODO enable user to enter their own alarm
//TODO show user set alarm on UI

//TODO performance optimization!

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer timer;
  DateTime now;
  String date;
  String hours;
  String minutes;
  String seconds;
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        DateTime now = DateTime.now();
        date = DateFormat('EEE d MMM').format(now);
        hours = DateFormat('kk').format(now);
        minutes = DateFormat('mm').format(now);
        seconds = DateFormat('ss').format(now);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    hours,
                    style: timeStyle(HOUR_SIZE, HOUR_COLOR),
                  ),
                  Text(
                    ':',
                    style:  timeStyle(HOUR_SIZE, HOUR_COLOR),
                  ),
                  Text(
                    minutes,
                    style:  timeStyle(HOUR_SIZE, HOUR_COLOR),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            ':',
                            style:  timeStyle(SECOND_SIZE, SECOND_COLOR),
                          ),
                          // TODO: You may remove the seconds (using for testing)
                          Text(
                            seconds,
                            style:  timeStyle(SECOND_SIZE, SECOND_COLOR),
                          ),
                        ],
                      ),
                      Text(
                        date,
                        style: timeStyle(SECOND_SIZE, SECOND_COLOR),
                      ),
                    ],
                  ),
                ],
              ),
              FlatButton(
                color: Colors.black54,
                child: Icon(
                  Icons.alarm,
                  color: SECOND_COLOR,
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
