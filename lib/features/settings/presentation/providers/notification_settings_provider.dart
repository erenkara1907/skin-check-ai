import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/notification_service.dart';
import '../../../../core/utils/logger.dart';

part 'notification_settings_provider.g.dart';

const _kMorningHourKey = 'morning_notif_hour';
const _kMorningMinuteKey = 'morning_notif_minute';
const _kEveningHourKey = 'evening_notif_hour';
const _kEveningMinuteKey = 'evening_notif_minute';
const _kStreakNotifKey = 'streak_notif_enabled';
const _kMotivationalNotifKey = 'motivational_notif_enabled';
const _kWeeklyDayKey = 'weekly_reminder_day';

/// Morning reminder time (hour + minute).
@Riverpod(keepAlive: true)
class MorningReminderTime extends _$MorningReminderTime {
  @override
  ({int hour, int minute}) build() {
    _load();
    return (hour: 7, minute: 0);
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = (
      hour: prefs.getInt(_kMorningHourKey) ?? 7,
      minute: prefs.getInt(_kMorningMinuteKey) ?? 0,
    );
  }

  /// Sets and persists the morning reminder time.
  Future<void> setTime(int hour, int minute) async {
    state = (hour: hour, minute: minute);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kMorningHourKey, hour);
    await prefs.setInt(_kMorningMinuteKey, minute);
    await NotificationService.instance
        .scheduleMorningReminder(hour: hour, minute: minute);
    log.i('Morning reminder set to $hour:$minute');
  }
}

/// Evening reminder time (hour + minute).
@Riverpod(keepAlive: true)
class EveningReminderTime extends _$EveningReminderTime {
  @override
  ({int hour, int minute}) build() {
    _load();
    return (hour: 21, minute: 0);
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = (
      hour: prefs.getInt(_kEveningHourKey) ?? 21,
      minute: prefs.getInt(_kEveningMinuteKey) ?? 0,
    );
  }

  /// Sets and persists the evening reminder time.
  Future<void> setTime(int hour, int minute) async {
    state = (hour: hour, minute: minute);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kEveningHourKey, hour);
    await prefs.setInt(_kEveningMinuteKey, minute);
    await NotificationService.instance
        .scheduleEveningReminder(hour: hour, minute: minute);
    log.i('Evening reminder set to $hour:$minute');
  }
}

/// Whether streak milestone notifications are enabled.
@Riverpod(keepAlive: true)
class StreakNotificationEnabled extends _$StreakNotificationEnabled {
  @override
  bool build() {
    _load();
    return false;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_kStreakNotifKey) ?? false;
  }

  /// Toggles streak notification preference.
  Future<void> toggle(bool enabled) async {
    state = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kStreakNotifKey, enabled);
  }
}

/// Whether motivational notification messages are enabled.
@Riverpod(keepAlive: true)
class MotivationalNotificationEnabled
    extends _$MotivationalNotificationEnabled {
  @override
  bool build() {
    _load();
    return false;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_kMotivationalNotifKey) ?? false;
  }

  /// Toggles motivational notification preference.
  Future<void> toggle(bool enabled) async {
    state = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kMotivationalNotifKey, enabled);
  }
}

/// Day of week for the weekly analysis reminder (1=Monday, 7=Sunday).
@Riverpod(keepAlive: true)
class WeeklyReminderDay extends _$WeeklyReminderDay {
  @override
  int build() {
    _load();
    return DateTime.monday;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getInt(_kWeeklyDayKey) ?? DateTime.monday;
  }

  /// Sets and persists the weekly reminder day.
  Future<void> setDay(int weekday) async {
    state = weekday;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kWeeklyDayKey, weekday);
    await NotificationService.instance
        .scheduleWeeklyAnalysisReminder(weekday: weekday);
    log.i('Weekly reminder day set to $weekday');
  }
}
