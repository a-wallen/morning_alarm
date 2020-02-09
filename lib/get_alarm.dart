import 'package:flutter/material.dart';
import 'package:morning_alarm/utils.dart';

class TimeSelector extends StatefulWidget {
  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {

  @override
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
              onPressed: _setTime,
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
          onVerticalDragUpdate: (d)=>f(d),
        ),
        Icon(
          Icons.arrow_drop_down,
          color: HOUR_COLOR,
        ),
      ],
    );
  }
}
