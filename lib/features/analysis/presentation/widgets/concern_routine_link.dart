import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/concern_step_matcher.dart';

/// Compact card showing a routine step that addresses a concern.
class ConcernRoutineLink extends StatelessWidget {
  const ConcernRoutineLink({super.key, required this.match});

  final MatchedRoutineStep match;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMorning = match.routineType == 'morning';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.glassDark : AppColors.glassLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppColors.glassBorderDark
              : AppColors.glassBorderLight,
        ),
      ),
      child: Row(
        children: [
          // Step icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _resolveIcon(match.step.iconName),
              size: 18,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 10),
          // Step name + reason
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  match.step.step,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  match.step.reason,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Routine type badge
          _RoutineTypeBadge(isMorning: isMorning),
        ],
      ),
    );
  }

  IconData _resolveIcon(String name) {
    const map = {
      'droplets': LucideIcons.droplets,
      'droplet': LucideIcons.droplet,
      'spray-can': LucideIcons.sprayCan,
      'flask-round': LucideIcons.flaskRound,
      'cloud': LucideIcons.cloud,
      'sun': LucideIcons.sun,
      'eye': LucideIcons.eye,
      'smile': LucideIcons.smile,
      'sparkles': LucideIcons.sparkles,
      'moon': LucideIcons.moon,
      'pill': LucideIcons.pill,
    };
    return map[name] ?? LucideIcons.droplets;
  }
}

class _RoutineTypeBadge extends StatelessWidget {
  const _RoutineTypeBadge({required this.isMorning});

  final bool isMorning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isMorning
            ? AppColors.secondary.withValues(alpha: 0.15)
            : AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMorning ? LucideIcons.sun : LucideIcons.moon,
            size: 12,
            color: isMorning ? AppColors.secondary : AppColors.primary,
          ),
          const SizedBox(width: 4),
          Text(
            isMorning ? 'Sabah' : 'Akşam',
            style: AppTextStyles.labelSmall.copyWith(
              color: isMorning ? AppColors.secondary : AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
