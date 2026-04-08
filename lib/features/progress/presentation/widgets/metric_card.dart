import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';

/// A single glassmorphism metric card for the dashboard.
class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.valueColor,
  });

  /// Icon shown at the top.
  final IconData icon;

  /// Main metric value.
  final String value;

  /// Label below the value.
  final String label;

  /// Optional color override for the value text.
  final Color? valueColor;

  /// Creates a score variant.
  factory MetricCard.score(double score) {
    return MetricCard(
      icon: LucideIcons.target,
      value: score.toStringAsFixed(0),
      label: 'Skor',
      valueColor: AppColors.scoreColor(score),
    );
  }

  /// Creates a skin age variant.
  factory MetricCard.skinAge(int age) {
    return MetricCard(
      icon: LucideIcons.clock,
      value: '$age',
      label: 'Cilt Yasi',
    );
  }

  /// Creates a total analyses variant.
  factory MetricCard.totalAnalyses(int count) {
    return MetricCard(
      icon: LucideIcons.barChart3,
      value: '$count',
      label: 'Analiz',
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final subtextColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return Expanded(
      child: AppCard(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTextStyles.displaySmall.copyWith(
                color: valueColor ?? textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: subtextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
