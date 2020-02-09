import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
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
  int myhours = 0, myminutes = 0;
  int setHours = 0, setMinutes = 0;
  String date, hours, minutes, seconds; // current time
  FlutterLocalNotificationsPlugin alarmNotificationPlugin; //alarm

  void initState() {
    super.initState();

    //alarm notification plugin initialization
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
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

  void _sendAlarm() async {
    //Currently doesn't work with this code to schedule alarm ten seconds in advance
    //commented out code by itself works to make it send a notification as soon as function is called
    var alarmTime = DateTime.now().add(new Duration(seconds: 10));
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await alarmNotificationPlugin.schedule(0, 'scheduled title',
//        'scheduled body', alarmTime, platformChannelSpecifics);

//    showDialog(
//      context: context,
//      builder: (_) {
//        return new AlertDialog(
//          title: Text("PayLoad"),
//          content: Text("Payload : lol"),
//        );
//      },
//    );
  }

  _setAlarmTime() {
    setState(() {
      setHours = myhours;
      setMinutes = myminutes;
    });
  }

  hoursUpdate(DragUpdateDetails details) {
    setState(() {
      if (myhours - details.primaryDelta.round() < 0)
        myhours += 23;
      else if (myhours - details.primaryDelta.round() > 23)
        myhours -= 23;
      else
        myhours -= details.primaryDelta.round();
    });
  }

  minutesUpdate(DragUpdateDetails details) {
    setState(() {
      if (myminutes - details.primaryDelta.round() < 0)
        myminutes += 59;
      else if (myminutes - details.primaryDelta.round() > 59)
        myminutes -= 59;
      else
        myminutes -= details.primaryDelta.round();
    });
  }

  Widget timeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        tsSliver(myhours, hoursUpdate),
        Text(
          ':',
          style: timeStyle(SECOND_SIZE, SECOND_COLOR),
        ),
        tsSliver(myminutes, minutesUpdate),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Set",
              style: timeStyle(12.0, HOUR_COLOR),
            ),
            IconButton(
              iconSize: SECOND_SIZE,
              color: SECOND_COLOR,
              icon: Icon(Icons.access_alarm),
              onPressed: _setAlarmTime,
            ),
            Text(
              "Alarm",
              style: timeStyle(12.0, HOUR_COLOR),
            ),
          ],
        ),
      ],
    );
  }

  Widget tsSliver(int t, Function f) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.arrow_drop_up,
          color: HOUR_COLOR,
        ),
        GestureDetector(
          child: Text(
            "$t",
            style: timeStyle(SECOND_SIZE, SECOND_COLOR),
          ),
          onVerticalDragUpdate: (d) => f(d),
        ),
        Icon(
          Icons.arrow_drop_down,
          color: HOUR_COLOR,
        ),
      ],
    );
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
              timeSelector(),
              Text(
                "Next alarm at: $setHours:$setMinutes",
                style: timeStyle(12.0, SECOND_COLOR),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
