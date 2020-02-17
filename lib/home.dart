import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:morning_alarm/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:weather/weather.dart';
import 'bottomSheetElements.dart';

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
  //Weather classes from the weather library
  WeatherStation weatherStation =
      WeatherStation("6a2c0c137802dededc82292b586c8d15");
  Weather weather;
  String weatherIconUrl;

  //Timer for UI redrawing
  Timer timer;
  DateTime now = DateTime.now();
  int sunrise, sunset, midDay;

  //var alarm of type time used for local notifications class
  Time alarm = Time(0, 0, 0);
  String alarmAsString = '';
  int myhours = 0, myminutes = 0;

  //current time variables
  String date, hours, minutes, seconds; // current time

  //instance of flutter local notification plugin
  FlutterLocalNotificationsPlugin alarmNotificationPlugin; //alarm

  void initState() {
    super.initState();
    _getWeather();
    //alarm notification plugin initialization
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    alarmNotificationPlugin = new FlutterLocalNotificationsPlugin();
    alarmNotificationPlugin.initialize(initializationSettings);
    date = DateFormat('EEE d MMM').format(now);
    seconds = DateFormat('ss').format(now);
    hours = DateFormat('kk').format(now);
    minutes = DateFormat('mm').format(now);
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        now = DateTime.now();
        //alarmTest = DateTime(now.year, now.month, now.day, now.hour, now.minute+1);
        seconds = DateFormat('ss').format(now);
        hours = DateFormat('kk').format(now);
        minutes = DateFormat('mm').format(now);
      });
      if (alarmAsString == '$hours:$minutes:$seconds') {
        _sendAlarm();
      }
    });
  }

  Future _getWeather() async {
    weather = await weatherStation.currentWeather();
    setState(() {
      sunrise = 60 * int.parse(DateFormat('kk').format(weather.sunrise)) +
          int.parse(DateFormat('mm').format(weather.sunrise));
      sunset = 60 * int.parse(DateFormat('kk').format(weather.sunset)) +
          int.parse(DateFormat('mm').format(weather.sunrise));
      midDay = ((sunrise + sunset) / 2).round();
      weatherIconUrl = weather.weatherIcon;
    });
  }

  Future _sendAlarm() async {
    //Currently doesn't work with this code to schedule alarm ten seconds in advance
    //commented out code by itself works to make it send a notification as soon as function is called

    //var alarmTime = DateTime.now().add(new Duration(seconds: 10));
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description',
        importance: Importance.Max,
        sound: "assets/flappy_bird.mp3",
        playSound: true,
        enableVibration: true,
        icon: "assets/morning_alarm_icon.png",
        priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await alarmNotificationPlugin.show(
        0, 'title', 'body', platformChannelSpecifics);
    // await alarmNotificationPlugin.schedule(id, title, body, scheduledDate, notificationDetails)
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
      alarm = Time(myhours, myminutes, 0);
      alarmAsString = '$myhours:$myminutes:00';
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
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) => Stack(
          children: <Widget>[
            Positioned(
              top: 30.0,
              right: 0.0,
              child: weatherIconUrl == null
                  ? CircularProgressIndicator()
                  : Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          child: Text(
                            "70°",
                            style: timeStyle(SECOND_SIZE, SECOND_COLOR),
                          ),
                        ),
                        Image.network(
                          "http://openweathermap.org/img/wn/$weatherIconUrl@2x.png",
                          height: HOUR_SIZE,
                        ),
                      ],
                    ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$hours:$minutes",
                    style: timeStyle(HOUR_SIZE, HOUR_COLOR),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
            ),
            Positioned(
              bottom: 15.0,
              left: screenWidth(context, dividedBy: 2, reducedBy: 5.0),
              child: FlatButton(
                color: Colors.white,
                padding: EdgeInsets.all(5.0),
                child: Icon(Icons.arrow_drop_up),
                onPressed: () {
                  showBottomSheet(
                      context: context,
                      builder: (context) => Container(
                            height: screenHeight(context, dividedBy: 4.5),
                            color: Colors.grey,
                            padding: EdgeInsets.all(10.0),
                            child: Center(child: timeSelector()),
                          ));
                },
              ),
            ),
            Positioned(
              top: 30.0,
              left: 10.0,
              child: Text(
                "Next alarm at: $alarmAsString",
                style: timeStyle(12.0, SECOND_COLOR),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
