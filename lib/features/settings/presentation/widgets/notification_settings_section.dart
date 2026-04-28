import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../providers/notification_settings_provider.dart';
import '../providers/settings_provider.dart';
import 'settings_actions.dart';
import 'settings_section.dart';
import 'settings_tile.dart';

/// Turkish day names indexed by ISO weekday (1=Monday).
const _dayNames = {
  1: 'Pazartesi',
  2: 'Salı',
  3: 'Çarşamba',
  4: 'Perşembe',
  5: 'Cuma',
  6: 'Cumartesi',
  7: 'Pazar',
};

/// Enhanced notification settings with separate morning/evening times,
/// streak/motivational toggles, and weekly reminder day picker.
class NotificationSettingsSection extends ConsumerWidget {
  const NotificationSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(notificationEnabledProvider);
    final morning = ref.watch(morningReminderTimeProvider);
    final evening = ref.watch(eveningReminderTimeProvider);
    final streakEnabled = ref.watch(streakNotificationEnabledProvider);
    final motivationalEnabled =
        ref.watch(motivationalNotificationEnabledProvider);
    final weeklyDay = ref.watch(weeklyReminderDayProvider);

    return SettingsSection(
      title: context.l10n.notificationsSectionTitle,
      children: [
        // Master toggle
        SettingsTile(
          icon: LucideIcons.bell,
          label: context.l10n.routineReminderLabel,
          trailing: Switch.adaptive(
            value: enabled,
            activeTrackColor: AppColors.primary,
            onChanged: (v) {
              ref.read(notificationEnabledProvider.notifier).toggle(v);
            },
          ),
          showDivider: enabled,
        ),
        if (enabled) ...[
          // Morning time
          SettingsTile(
            icon: LucideIcons.sunrise,
            label: context.l10n.morningReminderLabel,
            value: _formatTime(morning.hour, morning.minute),
            showDivider: true,
            onTap: () => _pickMorningTime(context, ref, morning),
          ),
          // Evening time
          SettingsTile(
            icon: LucideIcons.sunset,
            label: context.l10n.eveningReminderLabel,
            value: _formatTime(evening.hour, evening.minute),
            showDivider: true,
            onTap: () => _pickEveningTime(context, ref, evening),
          ),
          // Streak notifications
          SettingsTile(
            icon: LucideIcons.flame,
            label: context.l10n.streakNotificationLabel,
            trailing: Switch.adaptive(
              value: streakEnabled,
              activeTrackColor: AppColors.primary,
              onChanged: (v) {
                ref
                    .read(streakNotificationEnabledProvider.notifier)
                    .toggle(v);
              },
            ),
            showDivider: true,
          ),
          // Motivational messages
          SettingsTile(
            icon: LucideIcons.sparkles,
            label: context.l10n.motivationalNotificationLabel,
            trailing: Switch.adaptive(
              value: motivationalEnabled,
              activeTrackColor: AppColors.primary,
              onChanged: (v) {
                ref
                    .read(motivationalNotificationEnabledProvider.notifier)
                    .toggle(v);
              },
            ),
            showDivider: true,
          ),
          // Weekly analysis day
          SettingsTile(
            icon: LucideIcons.calendarDays,
            label: context.l10n.weeklyReminderDayLabel,
            value: _dayNames[weeklyDay] ?? 'Pazartesi',
            showDivider: false,
            onTap: () => _pickWeeklyDay(context, ref, weeklyDay),
          ),
        ],
      ],
    );
  }

  String _formatTime(int hour, int minute) {
    return '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}';
  }

  Future<void> _pickMorningTime(
    BuildContext context,
    WidgetRef ref,
    ({int hour, int minute}) current,
  ) async {
    final picked = await pickReminderTime(context, current);
    if (picked != null) {
      ref
          .read(morningReminderTimeProvider.notifier)
          .setTime(picked.hour, picked.minute);
    }
  }

  Future<void> _pickEveningTime(
    BuildContext context,
    WidgetRef ref,
    ({int hour, int minute}) current,
  ) async {
    final picked = await pickReminderTime(context, current);
    if (picked != null) {
      ref
          .read(eveningReminderTimeProvider.notifier)
          .setTime(picked.hour, picked.minute);
    }
  }

  Future<void> _pickWeeklyDay(
    BuildContext context,
    WidgetRef ref,
    int currentDay,
  ) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final picked = await showAppBottomSheet<int>(
      context: context,
      ref: ref,
      isScrollControlled: false,
      backgroundColor:
          isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => _DayPickerSheet(currentDay: currentDay),
    );
    if (picked != null) {
      ref.read(weeklyReminderDayProvider.notifier).setDay(picked);
    }
  }
}

class _DayPickerSheet extends StatelessWidget {
  const _DayPickerSheet({required this.currentDay});

  final int currentDay;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          for (final entry in _dayNames.entries)
            ListTile(
              title: Text(entry.value),
              trailing: entry.key == currentDay
                  ? const Icon(LucideIcons.check, color: AppColors.primary)
                  : null,
              onTap: () => Navigator.of(context).pop(entry.key),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
