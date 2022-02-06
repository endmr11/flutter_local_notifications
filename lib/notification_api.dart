import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    InitializationSettings initializationSettings =
        const InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
  }

  final AndroidNotificationDetails _androidNotificationDetails = const AndroidNotificationDetails(
    'channel ID',
    'channel name',
    channelDescription: 'channel description',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  final IOSNotificationDetails _iosNotificationDetails = const IOSNotificationDetails();

  Future<void> showNotifications(String? payload) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      "Eren",
      "Test Body!",
      NotificationDetails(android: _androidNotificationDetails, iOS: _iosNotificationDetails),
      payload: payload,
    );
  }

  Future<void> scheduleNotifications(String? payload) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "Eren",
      "Test Body 5!",
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      NotificationDetails(
        android: _androidNotificationDetails,
        iOS: _iosNotificationDetails,
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

void selectNotification(String? payload) async {
  // ignore: avoid_print
  print("BİLDİRİME BASTIN: $payload");

  if (payload == "A") {
    print("BU: A");
  } else if (payload == "B") {
    print("BU: B");
  } else {
    print("BU BELİRSİZ: $payload");
  }
}
