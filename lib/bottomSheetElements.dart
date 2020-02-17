import 'package:flutter/material.dart';

// Credit to Dane Mackier for bottom sheet example
// https://www.filledstacks.com/post/bottom-sheet-guide-in-flutter/

class BottomSheetWidget extends StatefulWidget {
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      height: 160,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: []),
    );
  }
}

class floatingBottomButton extends StatefulWidget {
  @override
  _floatingBottomButtonState createState() => _floatingBottomButtonState();
}

class _floatingBottomButtonState extends State<floatingBottomButton> {
  bool showFBB = true;
  @override
  Widget build(BuildContext context) {
    return showFBB
        ? FloatingActionButton(
            onPressed: () {
              var bottomSheetController = showBottomSheet(
                  context: context,
                  builder: (context) => Container(
                        color: Colors.grey[900],
                        height: 250,
                      ));

              showFloatingBottomButton(false);

              bottomSheetController.closed.then((value) {
                showFloatingBottomButton(true);
              });
            },
          )
        : Container();
  }

  void showFloatingBottomButton(bool value) {
    setState(() {
      showFBB = value;
    });
  }
}
