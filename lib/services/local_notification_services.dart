import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../screens/screen_shifter.dart';


class NotificationLogic {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
          'Water Reminder',
          'Don\'t forget to drink water',
          importance: Importance.max,
          priority: Priority.max
      ),
    );
  }

  static Future init(BuildContext context) async {
    tz.initializeTimeZones();
    final android = AndroidInitializationSettings('img_3');
    final settings = InitializationSettings(android: android);
    await _notifications.initialize(settings, onSelectNotification: (payload) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ShifterScreen()));
      onNotifications.add(payload);
    });
  }


  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime dateTime,
  }) async {
    if(dateTime.isBefore(DateTime.now())){
      dateTime=dateTime.add(Duration(days: 1));
    }
    _notifications.zonedSchedule(
      id, title, body, tz.TZDateTime.from(dateTime, tz.local),
      await _notificationDetails(),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation
          .absoluteTime, androidAllowWhileIdle: true,);
  }
}