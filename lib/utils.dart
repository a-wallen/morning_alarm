import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const SCROLL_FACTOR = 1.9;
const HOUR_SIZE = 96.0;
const SECOND_SIZE = 32.0;
const Color HOUR_COLOR = Colors.white;
const Color SECOND_COLOR = Colors.white70;

String alarmTitle = 'morning_alarm';
String alarmBody = 'wake up!';
//var alarmTime = DateTime.now().add(new Duration(seconds: 10));

TextStyle timeStyle(double size, Color myColor) {
  return TextStyle(
    //color: Colors.black54,
    //TODO this is just a suggestion
    color: myColor,
    fontFamily: 'BebasNeue',
    fontSize: size,
  );
}

// UI constants for the application i.e colors etc
const primaryColor = const Color(0xFFFFF0BC);

const primaryGradient = const LinearGradient(
  colors: const [Color(0xffbb8aAA), Color(0xffe6cfCA)],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

// metrics

// screen sizing metrics
Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).height - reducedBy) / dividedBy;
}

double screenWidth(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).width - reducedBy) / dividedBy;
}

// time
class CurrentTime {
  //data types
  final int seconds;
  final int minutes;
  final int hours;
  //constructor
  CurrentTime(this.seconds, this.minutes, this.hours);
}
