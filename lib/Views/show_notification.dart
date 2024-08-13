import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification(DateTime deadline, String contribution, String title) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics);

    // Remove the time part of the deadline and keep only the date
   String deadlines = DateFormat('yyyy-MM-dd').format(deadline);

    print(deadlines);
    print("Hello deadline");

    tz.TZDateTime scheduledTime;

    if (contribution == "Daily") {
      scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(minutes: 2));
    } else if (contribution == "Weekly") {
      scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(minutes: 2));
    } else if (contribution == "Monthly") {
      scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(minutes: 2));
    } else if (contribution == "Yearly") {
      scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(minutes: 2));
    } else {
      scheduledTime = tz.TZDateTime.from(deadline, tz.local);
    }

    print('Notification scheduled for: $scheduledTime');

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        'This is a scheduled notification',
        scheduledTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Sample data to test the notification scheduling
            DateTime deadline = DateTime.now().add(Duration(seconds: 10)); // Test deadline
            String contribution = "Daily"; // Change this to "Weekly", "Monthly", "Yearly" for testing
            String title = "Test Notification"; // Notification title

            _showNotification(deadline, contribution, title);
          },
          child: Text('Show Notification'),
        ),
      ),
    );
  }
}
