import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class App_Notification {
  void notifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    tz.initializeTimeZones();

    var scheduledTime = Time(2, 0, 0); // 8:00 AM
    var now = DateTime.now();
    var scheduledDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      scheduledTime.hour,
      scheduledTime.minute,
    );

    var androidDetails = const AndroidNotificationDetails(
      "notification 1",
      "App Notification 1",
      importance: Importance.max,
      priority: Priority.high,
      color: Colors.blue,
      playSound: true,
      // timeoutAfter: 5000,
    );
    var generalNotificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "Fossil capture",
      "title",
      tz.TZDateTime.from(scheduledDateTime, tz.local),
      generalNotificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
