import 'package:flutter/material.dart';

// Credit to Dane Mackier for bottom sheet example
// https://www.filledstacks.com/post/bottom-sheet-guide-in-flutter/

class floatingBottomButton extends StatefulWidget {
  final ValueChanged<String> onSaveData;

  floatingBottomButton({this.onSaveData});

  @override
  _floatingBottomButtonState createState() => _floatingBottomButtonState();
}

class _floatingBottomButtonState extends State<floatingBottomButton> {
  //bool showFBB = true,
  bool open = false;
  Icon buttonSymbol = Icon(Icons.keyboard_arrow_up, color: Colors.grey);
  String alarmMesg = "";

  saveData() {
    alarmMesg;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () {
        if (!open) {
          showBottomSheet(
              context: context,
              builder: (context) => Container(
                    color: Colors.white,
                    child: alarmMessageTextBox(onPressed: widget.onSaveData),
                  ));
          buttonSymbol = Icon(Icons.keyboard_arrow_down, color: Colors.grey);

          //bottomSheetController.closed.then((value) {
          //showFloatingBottomButton(true);
          //});
          open = true;
        } else {
          showBottomSheet(
              context: context,
              builder: (context) => Container(
                    color: Colors.grey[900],
                    height: 0,
                  ));
          buttonSymbol = Icon(Icons.keyboard_arrow_up, color: Colors.grey);

          open = false;
        }
      },
      child: buttonSymbol,
    );
  }

  /*void showFloatingBottomButton(bool value) {
    setState(() {
      showFBB = value;
    });
  }*/
}

//source: https://api.flutter.dev/flutter/material/TextField-class.html#material.TextField.2
//https://stackoverflow.com/questions/53707961/how-to-send-data-through-different-classes-in-different-screens-in-flutter

class alarmMessageTextBox extends StatefulWidget {
  final ValueChanged<String> onPressed;

  alarmMessageTextBox({this.onPressed});

  @override
  _alarmMessageTextBoxState createState() => _alarmMessageTextBoxState();
}

class _alarmMessageTextBoxState extends State<alarmMessageTextBox> {
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: TextField(
        controller: _controller,
        onSubmitted: (String value) async {
          await showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('You set the next alarm message to "$value".'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      widget.onPressed(value);
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Input alarm message you want to see',
            fillColor: Colors.white),
      ),
    );
  }
}
