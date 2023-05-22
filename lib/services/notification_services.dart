import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '/models/task.dart';
import '/ui/pages/notification_screen.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  String selectedNotificationPayload = '';

  final BehaviorSubject<String> selectNotificationSubject =
  BehaviorSubject<String>();

  initializeNotification() async {
    tz.initializeTimeZones();
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();
    // await requestIOSPermissions(flutterLocalNotificationsPlugin);
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('appicon');

    final InitializationSettings initializationSettings =
    InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse
    );
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Get.to(NotificationScreen(payload),
    );
  }

  displayNotification(
      {required String title, required String note, required String time}) async {
    print('doing test');
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      note,
      platformChannelSpecifics,
      payload: '${title}|${note}|${time}|',
    );
  }

  scheduledNotification(int hour, int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!,
      task.title,
      task.note,
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      await _nextInstanceOfTenAM(
          hour, minutes, task.repeat!, task.remind!, task.date!),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'your channel id', 'your channel name',
            channelDescription: 'your channel description'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '${task.title}|${task.note}|${task.startTime}|',
    );
  }

  Future<tz.TZDateTime> _nextInstanceOfTenAM(int hour, int minutes,
      String repeat, int remind, String date) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    DateTime dateformat = DateFormat.yMd().parse(date);
    final tz.TZDateTime fd = tz.TZDateTime.from(dateformat, tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, fd.year, fd.month, fd.day, hour, minutes);
    scheduledDate = _remindNotification(scheduledDate, remind);
    if (scheduledDate.isBefore(now)) {
      if (repeat == 'Daily') {
        scheduledDate = tz.TZDateTime(
            tz.local, now.year, now.month, (dateformat.day) + 1, hour, minutes);
      }
      if (repeat == 'Weekly') {
          scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, (dateformat.day) + 7, hour, minutes);
        }
      if (repeat == 'Monthly') {
          scheduledDate = tz.TZDateTime(
              tz.local, now.year, (dateformat.month) + 1, (dateformat.day), hour,
              minutes);
        }
      scheduledDate = _remindNotification(scheduledDate, remind);
      }

      return scheduledDate;
    }
    _remindNotification(tz.TZDateTime scheduledDate, int remind) {
      if (remind == 5)
        scheduledDate = scheduledDate.subtract(Duration(minutes: 5));
      if (remind == 15)
        scheduledDate = scheduledDate.subtract(Duration(minutes: 15));
      if (remind == 10)
        scheduledDate = scheduledDate.subtract(Duration(minutes: 10));
      if (remind == 20)
        scheduledDate = scheduledDate.subtract(Duration(minutes: 20));
    }
    cancelNotification(Task task) async {
      await flutterLocalNotificationsPlugin.cancel(task.id!);
    }
  cancelallNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
    void requestIOSPermissions() {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    Future<void> _configureLocalTimeZone() async {
      tz.initializeTimeZones();
      final String timeZoneName = await FlutterNativeTimezone
          .getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    }

/*   Future selectNotification(String? payload) async {
    if (payload != null) {
      //selectedNotificationPayload = "The best";
      selectNotificationSubject.add(payload);
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(() => SecondScreen(selectedNotificationPayload));
  } */

//Older IOS
    Future onDidReceiveLocalNotification(int id, String? title, String? body,
        String? payload) async {
      // display a dialog with the notification details, tap ok to go to another page
      /* showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Title'),
        content: const Text('Body'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Container(color: Colors.white),
                ),
              );
            },
          )
        ],
      ),
    ); 
 */
      Get.dialog(Text(body!));
    }

    void _configureSelectNotificationSubject() {
      selectNotificationSubject.stream.listen((String payload) async {
        debugPrint('My payload is ' + payload);
        await Get.to(() => NotificationScreen(payload));
      });
    }
  }
