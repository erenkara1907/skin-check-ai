import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../routine/domain/entities/routine_entity.dart';

/// Card showing today's routine steps with a completion progress bar.
class DailyRoutineCard extends StatelessWidget {
  const DailyRoutineCard({
    super.key,
    required this.routines,
    required this.onTap,
  });

  /// Active routines (morning + evening).
  final List<RoutineEntity> routines;

  /// Called when user taps the card.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Pick the current routine based on time of day
    final hour = DateTime.now().hour;
    final currentType = hour < 14 ? 'morning' : 'evening';
    final routine = routines.where((r) => r.type == currentType).firstOrNull;

    if (routine == null || routine.steps.isEmpty) {
      return const SizedBox.shrink();
    }

    final totalSteps = routine.steps.length;
    final completedSteps =
        routine.steps.where((s) => s.isCompleted).length;
    final progress = totalSteps > 0 ? completedSteps / totalSteps : 0.0;
    final label = currentType == 'morning' ? 'Sabah Rutini' : 'Aksam Rutini';

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                currentType == 'morning'
                    ? LucideIcons.sun
                    : LucideIcons.moon,
                size: 18,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.titleMedium.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const Spacer(),
              Text(
                '$completedSteps/$totalSteps',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor:
                  theme.colorScheme.outline.withValues(alpha: 0.15),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.secondary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Show first 3 steps as preview
          ...routine.steps.take(3).map(
                (step) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(
                        step.isCompleted
                            ? LucideIcons.checkCircle2
                            : LucideIcons.circle,
                        size: 16,
                        color: step.isCompleted
                            ? AppColors.success
                            : theme.colorScheme.onSurface
                                .withValues(alpha: 0.35),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          step.step,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: step.isCompleted
                                ? theme.colorScheme.onSurface
                                    .withValues(alpha: 0.5)
                                : theme.colorScheme.onSurface,
                            decoration: step.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          if (totalSteps > 3)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '+${totalSteps - 3} adim daha',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms).slideY(
          begin: 0.05,
          end: 0,
        );
  }
}
