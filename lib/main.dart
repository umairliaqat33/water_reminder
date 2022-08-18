import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder/screens/splash_screen.dart';
import 'package:water_reminder/services/local_notification_services.dart';

import 'firebase_options.dart';

Future<void> backGroundHandler(RemoteMessage message)async{
  LocalNotificationService.display(message);
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backGroundHandler);
  // LocalNotificationService.initialize();
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  //   FirebaseMessaging.instance.getInitialMessage().then((message){
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => SplashScreen(),
  //       ),
  //     );
  //     print(message!.data['route']);
  //   });
  //
  //
  //   FirebaseMessaging.onMessage.listen((message) {
  //     log(message.notification!.body.toString());
  //     log(message.notification!.title.toString());
  //
  //     LocalNotificationService.display(message);
  //   });
  //
  //   ///When app is in background and user taps on notification
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //     LocalNotificationService.display(message);
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => SplashScreen(),
  //       ),
  //     );
  //     print(message.data['route']);
  //
  //   });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
