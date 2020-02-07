import 'package:flutter/material.dart';
import 'package:morning_alarm/utils.dart';

class TimeSelector extends StatefulWidget {
  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  int hours = 0, minutes = 0;

  int alarm_update(DragUpdateDetails details, int unit) {
    if (details.delta.dy > 0) {
      unit--;
    } else if (details.delta.dy < 0) {
      unit++;
    }
    return unit;
  }

  @override
  Widget build(BuildContext context) {
    Widget ts_sliver(int t) {
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
            onVerticalDragUpdate: (d) {
              setState(() {
                print(d);
                t = alarm_update(d, t);
              });
            },
          ),
          Icon(
            Icons.arrow_drop_down,
            color: HOUR_COLOR,
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ts_sliver(hours),
        Text(
          ':',
          style: timeStyle(SECOND_SIZE, SECOND_COLOR),
        ),
        ts_sliver(minutes),
      ],
    );
  }
}
