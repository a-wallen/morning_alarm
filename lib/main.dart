import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'home.dart';
import 'dart:async';

//Resources:
//Flutter Local Notifications | Nitish Kumar Singh
//https://medium.com/@nitishk72/flutter-local-notification-1e43a353877b

//Timer refresh and Flutter Launcher Icon | whatsupcoders (Youtube)
//https://www.youtube.com/channel/UCDCFIqDZ1QUqivxVFQDxS0w

final FlutterLocalNotificationsPlugin alarmNotificationPlugin = new FlutterLocalNotificationsPlugin();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(
      {@required this.id,
        @required this.title,
        @required this.body,
        @required this.payload});
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid =
  new AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = new IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await alarmNotificationPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
      });
  runApp(MyApp());
}

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
