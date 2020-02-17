import 'package:flutter/material.dart';
import 'home.dart';

//Resources:
//Flutter Local Notifications | Nitish Kumar Singh
//https://medium.com/@nitishk72/flutter-local-notification-1e43a353877b

//Timer refresh and Flutter Launcher Icon | whatsupcoders (Youtube)
//https://www.youtube.com/channel/UCDCFIqDZ1QUqivxVFQDxS0w

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}
