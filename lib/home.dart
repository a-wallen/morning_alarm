import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:morning_alarm/get_alarm.dart';
import 'package:morning_alarm/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  DateTime now = DateTime.now();
  //DateTime alarmTest;
  int alarmMinutes=30, alarmHours=7; // alarm target times
  String date, hours, minutes, seconds; // current time
  FlutterLocalNotificationsPlugin alarmNotificationPlugin; //alarm

  void initState() {
    super.initState();

    //alarm notification plugin initialization
    var initializationSettingsAndroid =
      new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    alarmNotificationPlugin = new FlutterLocalNotificationsPlugin();
    alarmNotificationPlugin.initialize(initializationSettings);


    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        now = DateTime.now();
        //alarmTest = DateTime(now.year, now.month, now.day, now.hour, now.minute+1);
        date = DateFormat('EEE d MMM').format(now);
        seconds = DateFormat('ss').format(now);
        hours = DateFormat('kk').format(now);
        minutes = DateFormat('mm').format(now);
      });
    });
  }

  void _setAlarm() async{
    //Currently doesn't work with this code to schedule alarm ten seconds in advance
    //commented out code by itself works to make it send a notification as soon as function is called
    var alarmTime = DateTime.now().add(new Duration(seconds: 10));
    var androidPlatformChannelSpecifics =
    new AndroidNotificationDetails('your other channel id',
        'your other channel name', 'your other channel description');
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await alarmNotificationPlugin.schedule(0,
    'scheduled title',
    'scheduled body',
    alarmTime,
    platformChannelSpecifics);

    /*showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : lol"),
        );
      },
    );*/

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
                    "$hours:$minutes",
                    style: timeStyle(HOUR_SIZE, HOUR_COLOR),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ":$seconds",
                        style: timeStyle(SECOND_SIZE, SECOND_COLOR),
                      ),
                      Text(
                        date,
                        style: timeStyle(SECOND_SIZE, SECOND_COLOR),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "Alarm at: $alarmHours:$alarmMinutes",
                style: timeStyle(SECOND_SIZE, Colors.black54),
              ),
              TimeSelector(),
<<<<<<< HEAD
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Set", style: timeStyle(12.0, SECOND_COLOR),),
                  FlatButton(
                    child: Icon(
                      Icons.alarm,
                      color: SECOND_COLOR,
                    ),
                    onPressed: null,
                  ),
                  Text("Alarm", style: timeStyle(12.0, SECOND_COLOR),),
                ],
=======
              FlatButton(
                color: Colors.black54,
                child: Icon(
                  Icons.alarm,
                  color: SECOND_COLOR,
                ),
                onPressed: _setAlarm,
>>>>>>> a3041a679fd392856c66c12c722dc38dd5c9606a
              ),
            ],
          ),
        ),
      ),
    );
  }
}
