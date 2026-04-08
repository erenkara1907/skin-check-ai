import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/routine_step_detail_entity.dart';

/// Single routine step card with gradient accent, checkbox, and details.
class RoutineStepCard extends StatelessWidget {
  const RoutineStepCard({
    super.key,
    required this.step,
    required this.index,
    required this.totalSteps,
    required this.isCompleted,
    required this.onToggle,
    this.onDelete,
  });

  /// The step data.
  final RoutineStepDetailEntity step;

  /// Zero-based index of this step.
  final int index;

  /// Total number of steps in the routine.
  final int totalSteps;

  /// Whether this step is completed.
  final bool isCompleted;

  /// Called when the checkbox is tapped.
  final VoidCallback onToggle;

  /// Called to delete this step. Null hides the button.
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = totalSteps > 1 ? index / (totalSteps - 1) : 0.0;
    final accentColor = Color.lerp(
      AppColors.primary,
      AppColors.secondary,
      progress,
    )!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted
              ? accentColor.withValues(alpha: 0.4)
              : (isDark ? AppColors.borderDark : AppColors.borderLight),
        ),
        boxShadow: [
          BoxShadow(
            color: isCompleted
                ? accentColor.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: isDark ? 0.15 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Left accent bar
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    _buildCheckbox(accentColor),
                    const SizedBox(width: 12),
                    _buildIcon(accentColor, isDark),
                    const SizedBox(width: 12),
                    Expanded(child: _buildText(isDark)),
                    if (onDelete != null) _buildDeleteBtn(isDark),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox(Color accentColor) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: isCompleted ? accentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isCompleted
                ? accentColor
                : accentColor.withValues(alpha: 0.4),
            width: 2,
          ),
        ),
        child: isCompleted
            ? const Icon(Icons.check_rounded, size: 18, color: Colors.white)
            : null,
      ),
    );
  }

  Widget _buildIcon(Color accentColor, bool isDark) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        _resolveIcon(step.iconName),
        size: 20,
        color: accentColor,
      ),
    );
  }

  Widget _buildText(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${index + 1}.',
              style: AppTextStyles.labelSmall.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                step.step,
                style: AppTextStyles.titleSmall.copyWith(
                  decoration:
                      isCompleted ? TextDecoration.lineThrough : null,
                  color: isCompleted
                      ? (isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight)
                      : null,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          step.reason,
          style: AppTextStyles.bodySmall.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (step.howToApply.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            step.howToApply,
            style: AppTextStyles.labelSmall.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark.withValues(alpha: 0.7)
                  : AppColors.textSecondaryLight.withValues(alpha: 0.7),
              fontStyle: FontStyle.italic,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildDeleteBtn(bool isDark) {
    return IconButton(
      onPressed: onDelete,
      icon: Icon(
        LucideIcons.trash2,
        size: 18,
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
      ),
      visualDensity: VisualDensity.compact,
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
