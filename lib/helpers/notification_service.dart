import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;

/// A helper class to manage local notifications for alarms.
class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  /// Initializes the notification plugin for both Android and iOS.
  /// This should be called once during app startup.
  static Future<void> init() async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = DarwinInitializationSettings();

    await _plugin.initialize(
      InitializationSettings(android: android, iOS: iOS),
    );

    // Initialize timezone data for accurate scheduling
    tzdata.initializeTimeZones();
  }

  /// Schedules a notification at the given [scheduledDate] with a unique [id].
  /// [title] and [body] define the content of the notification.
  static Future<void> scheduleNotification(
      int id,
      String title,
      String body,
      DateTime scheduledDate,
      ) async {
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel',
          'Alarms',
          channelDescription: 'Alarm notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}
