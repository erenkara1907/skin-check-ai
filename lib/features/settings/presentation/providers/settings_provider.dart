import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/notification_service.dart';
import '../../../../core/utils/logger.dart';

part 'settings_provider.g.dart';

const _kNotifEnabledKey = 'routine_notif_enabled';
const _kNotifHourKey = 'routine_notif_hour';
const _kNotifMinuteKey = 'routine_notif_minute';

/// Whether routine notifications are enabled.
@Riverpod(keepAlive: true)
class NotificationEnabled extends _$NotificationEnabled {
  @override
  bool build() {
    _load();
    return false;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_kNotifEnabledKey) ?? false;
  }

  /// Toggles notification enabled state.
  Future<void> toggle(bool enabled) async {
    state = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kNotifEnabledKey, enabled);

    final svc = NotificationService.instance;
    if (enabled) {
      await svc.requestPermission();
      await svc.scheduleDailyReminders();
    } else {
      await svc.cancelAll();
    }
    log.i('Notifications ${enabled ? "enabled" : "disabled"}');
  }
}

/// Reminder time (hour and minute).
@Riverpod(keepAlive: true)
class ReminderTime extends _$ReminderTime {
  @override
  ({int hour, int minute}) build() {
    _load();
    return (hour: 8, minute: 0);
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = (
      hour: prefs.getInt(_kNotifHourKey) ?? 8,
      minute: prefs.getInt(_kNotifMinuteKey) ?? 0,
    );
  }

  /// Sets and persists the reminder time.
  Future<void> setTime(int hour, int minute) async {
    state = (hour: hour, minute: minute);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kNotifHourKey, hour);
    await prefs.setInt(_kNotifMinuteKey, minute);

    final isEnabled = ref.read(notificationEnabledProvider);
    if (isEnabled) {
      await NotificationService.instance.scheduleDailyReminders();
    }
  }
}
