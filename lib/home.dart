import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:morning_alarm/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:weather/weather.dart';
import 'dart:typed_data';
import 'main.dart';
import 'dart:async';

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
  int temp;
//  int sunrise, sunset, midDay;

  //var alarm of type time used for local notifications class
  String alarmAsString = '';
  int myhours = 0, myminutes = 0;

  //current time variables
  String date, hours, minutes, seconds; // current time

  //instance of flutter local notification plugin

  void initState() {
    super.initState();
    _getWeather();

    //alarm notification plugin initialization
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
//      if ('$alarmAsString:00' == '$hours:$minutes:$seconds') {
//        _setAlarm(now);
//      }
    });
  }

  Future _getWeather() async {
    weather = await weatherStation.currentWeather();
    setState(() {
//      sunrise = 60 * int.parse(DateFormat('kk').format(weather.sunrise)) +
//          int.parse(DateFormat('mm').format(weather.sunrise));
//      sunset = 60 * int.parse(DateFormat('kk').format(weather.sunset)) +
//          int.parse(DateFormat('mm').format(weather.sunrise));
//      midDay = ((sunrise + sunset) / 2).round();
      temp = weather.temperature.fahrenheit.round();
      weatherIconUrl = weather.weatherIcon;
    });
  }

  void _setAlarmTime() {
    String alarmForDT;
    setState(() {
      if (myminutes < 10) {
        alarmAsString = '${myhours}:0${myminutes}';
        alarmForDT = '${myhours}0${myminutes}';
      }else {
        alarmAsString = '${myhours}:${myminutes}';
        alarmForDT = '${myhours}${myminutes}';
      }
    });
    String dateWithT = "${DateFormat('yyyyMMdd').format(now)}T${alarmForDT}00";
    //print(dateWithT);
    DateTime alarm = DateTime.parse(dateWithT);
    _scheduleAlarm(alarm);
  }

  Future _scheduleAlarm(DateTime t) async {
    //Currently doesn't work with this code to schedule alarm ten seconds in advance
    //commented out code by itself works to make it send a notification as soon as function is called
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        'your channel description',
        //vibrationPattern: vibrationPattern,
        sound: 'video_game_ringtone',
        importance: Importance.Max,
        priority: Priority.Max,
        );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await alarmNotificationPlugin.show(
//        0, alarmTitle, alarmBody, platformChannelSpecifics);
    await alarmNotificationPlugin.cancelAll();
    await alarmNotificationPlugin.schedule(
        0, alarmTitle, alarmBody, t, platformChannelSpecifics);

    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("Success"),
          content: myminutes < 10 ? Text("Scheduled an alarm at: ${myhours}:0${myminutes}") :
          Text("Scheduled an alarm at: ${myhours}:${myminutes}"),
        );
      },
    );
  }

  /// Updates the hours
  hoursUpdate(DragUpdateDetails details) {
    setState(() {
      final int update = (details.primaryDelta / SCROLL_FACTOR).round();
      if (myhours - update < 0)
        myhours += 23;
      else if (myhours - update > 23)
        myhours -= 23;
      else
        myhours -= update;
    });
  }

  ///Updates the minutes
  minutesUpdate(DragUpdateDetails details) {
    setState(() {
      final int update = (details.primaryDelta / SCROLL_FACTOR).round();
      if (myminutes - update < 0)
        myminutes += 59;
      else if (myminutes - update > 59)
        myminutes -= 59;
      else
        myminutes -= update;
    });
  }

  /// Overall time selector widget
  Widget timeSelector() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        tsSliver(myhours, hoursUpdate),
        Text(
          ':',
          style: timeStyle(SECOND_SIZE, HOUR_COLOR),
        ),
        tsSliver(myminutes, minutesUpdate),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Set",
              style: timeStyle(12.0, HOUR_COLOR),
            ),
            IconButton(
              tooltip: "Scroll up or down get desired time! Press alarm icon to set alarm.",
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

  /// Time selector wheel widget
  Widget tsSliver(int t, Function f) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.arrow_drop_up,
          color: HOUR_COLOR,
        ),
        GestureDetector(
          child: Text(
            t < 10 ? '0$t' : '$t',
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
      backgroundColor: primaryColor,
      body: Stack(
        children: <Widget>[
          /// Weather Icon
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
                          "$temp°",
                          style: timeStyle(SECOND_SIZE, SECOND_COLOR),
                        ),
                      ),
                      Image.network(
                        "http://openweathermap.org/img/wn/$weatherIconUrl@2x.png",
                        height: HOUR_SIZE - 15,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                    ],
                  ),
          ),

          /// Current Timestamp
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

          /// Display alarm
          Positioned(
            top: 30.0,
            left: 10.0,
            child: Text(
              "Alarm at: $alarmAsString",
              style: timeStyle(12.0, SECOND_COLOR),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              timeSelector(),
            ],
          ),
        ],
      ),
    );
  }
}
