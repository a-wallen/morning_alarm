import 'package:flutter/material.dart';
import 'package:morning_alarm/utils.dart';

class TimeSelector extends StatefulWidget {
  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  int hours = 0;
  int minutes = 0;

  hoursUpdate(DragUpdateDetails details) {
    setState(() {
      if(hours-details.primaryDelta.round() < 0)
        hours += 23;
      else if(hours-details.primaryDelta.round() > 23)
        hours -= 23;
      else
        hours -= details.primaryDelta.round();
    });
      print(hours);
  }

  minutesUpdate(DragUpdateDetails details){
    setState(() {
      if(minutes-details.primaryDelta.round() < 0)
        minutes += 59;
      else if(minutes-details.primaryDelta.round() > 59)
        minutes -= 59;
      else
        minutes -= details.primaryDelta.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        tsSliver(hours, hoursUpdate),
        Text(
          ':',
          style: timeStyle(SECOND_SIZE, SECOND_COLOR),
        ),
        tsSliver(minutes, minutesUpdate),
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
