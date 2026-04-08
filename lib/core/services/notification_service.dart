import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../utils/logger.dart';

/// Callback for handling notification taps.
@pragma('vm:entry-point')
void _onDidReceiveBackgroundNotificationResponse(
  NotificationResponse response,
) {
  // Handled by foreground callback via GoRouter
}

/// Wrapper around flutter_local_notifications for daily reminders.
class NotificationService {
  NotificationService._();
  static final instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  static const _morningId = 100;
  static const _eveningId = 101;
  static const _weeklyAnalysisId = 200;

  /// Initializes the notification plugin and timezone data.
  Future<void> initialize({
    void Function(NotificationResponse)? onTap,
  }) async {
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveBackgroundNotificationResponse,
    );

    log.i('NotificationService initialized');
  }

  /// Requests notification permission (iOS/Android 13+).
  Future<bool> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      final granted = await android.requestNotificationsPermission();
      return granted ?? false;
    }

    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      final granted = await ios.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    return true;
  }

  /// Schedules daily morning (07:00) and evening (21:00) reminders.
  Future<void> scheduleDailyReminders() async {
    await _scheduleDaily(
      id: _morningId,
      hour: 7,
      title: 'Sabah Rutinin Hazır ☀️',
      body: 'Güne bakımlı başla! Sabah rutinine göz at.',
    );
    await _scheduleDaily(
      id: _eveningId,
      hour: 21,
      title: 'Akşam Rutini Zamanı 🌙',
      body: 'Günü temiz bitir! Akşam bakım rutinine başla.',
    );
    log.i('Daily reminders scheduled: 07:00 & 21:00');
  }

  /// Schedules a weekly analysis reminder (Monday 10:00).
  Future<void> scheduleWeeklyAnalysisReminder() async {
    await _scheduleWeekly(
      id: _weeklyAnalysisId,
      weekday: DateTime.monday,
      hour: 10,
      title: 'Bu hafta analizini yaptin mi?',
      body: 'Haftalik analizini yap ve ilerlemeyi takip et!',
    );
    log.i('Weekly analysis reminder scheduled: Monday 10:00');
  }

  /// Cancels all scheduled reminders.
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
    log.i('All notifications cancelled');
  }

  Future<void> _scheduleDaily({
    required int id,
    required int hour,
    required String title,
    required String body,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    const androidDetails = AndroidNotificationDetails(
      'routine_reminders',
      'Rutin Hatırlatmaları',
      channelDescription: 'Günlük cilt bakım rutini hatırlatmaları',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduled,
      const NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'routine',
    );
  }

  Future<void> _scheduleWeekly({
    required int id,
    required int weekday,
    required int hour,
    required String title,
    required String body,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
    );
    // Advance to the target weekday
    while (scheduled.weekday != weekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    const androidDetails = AndroidNotificationDetails(
      'weekly_analysis',
      'Haftalik Analiz Hatirlatmasi',
      channelDescription: 'Haftalik cilt analizi hatirlatmasi',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduled,
      const NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload: 'weekly_analysis',
    );
  }
}
