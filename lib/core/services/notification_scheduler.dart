import 'package:shared_preferences/shared_preferences.dart';

import '../utils/logger.dart';
import 'notification_service.dart';
import 'smart_notification_service.dart';

/// Orchestrates personalized notification scheduling and immediate alerts.
class NotificationScheduler {
  NotificationScheduler._();

  static const _streakMilestoneId = 300;
  static const _scoreCelebrationId = 301;

  /// Checks for streak milestones and fires an immediate notification.
  static Future<void> checkStreakMilestone(int streak) async {
    final enabled = await _isStreakNotifEnabled();
    if (!enabled) return;

    final milestone = SmartNotificationService.streakMilestone(streak);
    if (milestone == null) return;

    await NotificationService.instance.showImmediate(
      id: _streakMilestoneId,
      title: milestone.title,
      body: milestone.body,
      payload: 'routine',
    );
    log.i('Streak milestone notification fired for $streak days');
  }

  /// Checks for score improvement and fires a celebration notification.
  static Future<void> checkScoreImprovement({
    required double previousScore,
    required double currentScore,
  }) async {
    final message = SmartNotificationService.scoreImprovement(
      previousScore: previousScore,
      currentScore: currentScore,
    );
    if (message == null) return;

    await NotificationService.instance.showImmediate(
      id: _scoreCelebrationId,
      title: message.title,
      body: message.body,
      payload: 'routine',
    );
    log.i('Score improvement notification fired');
  }

  /// Re-schedules daily reminders with personalized messages.
  static Future<void> reschedulePersonalized({
    required int morningHour,
    required int morningMinute,
    required int eveningHour,
    required int eveningMinute,
    required int currentStreak,
    required bool missedYesterdayEvening,
    required bool completedMorning,
  }) async {
    final morning = SmartNotificationService.morningMessage(
      currentStreak: currentStreak,
      missedYesterdayEvening: missedYesterdayEvening,
    );
    await NotificationService.instance.scheduleMorningReminder(
      hour: morningHour,
      minute: morningMinute,
      title: morning.title,
      body: morning.body,
    );

    final evening = SmartNotificationService.eveningMessage(
      currentStreak: currentStreak,
      completedMorning: completedMorning,
    );
    await NotificationService.instance.scheduleEveningReminder(
      hour: eveningHour,
      minute: eveningMinute,
      title: evening.title,
      body: evening.body,
    );
    log.i('Personalized notifications rescheduled');
  }

  static Future<bool> _isStreakNotifEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('streak_notif_enabled') ?? false;
  }
}
