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
  bool _initialized = false;
  static const _morningId = 100;
  static const _eveningId = 101;
  static const _weeklyAnalysisId = 200;

  /// Initializes the notification plugin and timezone data.
  Future<void> initialize({
    void Function(NotificationResponse)? onTap,
  }) async {
    if (_initialized) return;
    _initialized = true;
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    try {
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
    } catch (e, st) {
      log.e('NotificationService init failed', e, st);
    }
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

  /// Schedules daily morning and evening reminders with default times.
  Future<void> scheduleDailyReminders() async {
    await scheduleMorningReminder();
    await scheduleEveningReminder();
    log.i('Daily reminders scheduled');
  }

  /// Schedules the morning reminder at the given [hour] and [minute].
  Future<void> scheduleMorningReminder({
    int hour = 7,
    int minute = 0,
    String? title,
    String? body,
  }) async {
    await _scheduleDaily(
      id: _morningId,
      hour: hour,
      minute: minute,
      title: title ?? 'Sabah Rutinin Hazır ☀️',
      body: body ?? 'Güne bakımlı başla! Sabah rutinine göz at.',
    );
  }

  /// Schedules the evening reminder at the given [hour] and [minute].
  Future<void> scheduleEveningReminder({
    int hour = 21,
    int minute = 0,
    String? title,
    String? body,
  }) async {
    await _scheduleDaily(
      id: _eveningId,
      hour: hour,
      minute: minute,
      title: title ?? 'Akşam Rutini Zamanı 🌙',
      body: body ?? 'Günü temiz bitir! Akşam bakım rutinine başla.',
    );
  }

  /// Schedules a weekly analysis reminder.
  Future<void> scheduleWeeklyAnalysisReminder({
    int weekday = DateTime.monday,
    int hour = 10,
  }) async {
    await _scheduleWeekly(
      id: _weeklyAnalysisId,
      weekday: weekday,
      hour: hour,
      title: 'Bu hafta analizini yaptın mı?',
      body: 'Haftalık analizini yap ve ilerlemeyi takip et!',
    );
    log.i('Weekly analysis reminder scheduled');
  }

  /// Cancels only the morning reminder.
  Future<void> cancelMorning() async {
    await _plugin.cancel(_morningId);
  }

  /// Cancels only the evening reminder.
  Future<void> cancelEvening() async {
    await _plugin.cancel(_eveningId);
  }

  /// Cancels only the weekly analysis reminder.
  Future<void> cancelWeekly() async {
    await _plugin.cancel(_weeklyAnalysisId);
  }

  /// Cancels all scheduled reminders.
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
    log.i('All notifications cancelled');
  }

  /// Shows an immediate notification (for milestones, celebrations).
  Future<void> showImmediate({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'instant',
      'Anlık Bildirimler',
      channelDescription: 'Başarım ve kutlama bildirimleri',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload: payload,
    );
  }

  Future<void> _scheduleDaily({
    required int id,
    required int hour,
    int minute = 0,
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
      minute,
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
      'Haftalık Analiz Hatırlatması',
      channelDescription: 'Haftalık cilt analizi hatırlatması',
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
