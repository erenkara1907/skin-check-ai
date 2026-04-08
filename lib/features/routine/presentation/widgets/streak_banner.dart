import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/streak_entity.dart';

/// Displays the user's current routine completion streak.
class StreakBanner extends StatelessWidget {
  const StreakBanner({super.key, required this.streak});

  /// Streak data to display.
  final StreakEntity streak;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (streak.currentStreak == 0 && streak.longestStreak == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFF8C00).withValues(alpha: isDark ? 0.2 : 0.1),
            const Color(0xFFFFD700).withValues(alpha: isDark ? 0.15 : 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFF8C00).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          // Fire icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFFF8C00).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              LucideIcons.flame,
              color: Color(0xFFFF8C00),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          // Streak text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${streak.currentStreak} Gün Seri!',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: const Color(0xFFFF8C00),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'En uzun seri: ${streak.longestStreak} gün',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          // Streak count badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFF8C00),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '🔥 ${streak.currentStreak}',
              style: AppTextStyles.labelLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
