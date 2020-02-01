import 'package:flutter/material.dart';

// UI constants for the application i.e colors etc
const primaryColor = const Color(0xFFFF8961);

const primaryGradient = const LinearGradient(
  colors: const [Color(0xFFFD60A3), Color(0xFFFF8961)],
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
  CurrentTime(this.seconds,this.minutes,this.hours);
}

