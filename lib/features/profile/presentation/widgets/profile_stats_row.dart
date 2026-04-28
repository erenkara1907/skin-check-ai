import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Displays analysis count and membership date side by side.
class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.analysisCount,
    this.joinDate,
  });

  /// Total number of analyses.
  final int analysisCount;

  /// Account creation date.
  final DateTime? joinDate;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final subtextColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final surface = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.white;
    final border = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            value: '$analysisCount',
            label: context.l10n.totalAnalysesLabel,
            surface: surface,
            border: border,
            textColor: textColor,
            subtextColor: subtextColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            value: joinDate != null
                ? DateFormat('MMM yyyy', 'tr').format(joinDate!)
                : '-',
            label: context.l10n.membershipDateLabel,
            surface: surface,
            border: border,
            textColor: textColor,
            subtextColor: subtextColor,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.surface,
    required this.border,
    required this.textColor,
    required this.subtextColor,
  });

  final String value;
  final String label;
  final Color surface;
  final Color border;
  final Color textColor;
  final Color subtextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.headlineMedium.copyWith(
              color: textColor,
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
    );
  }
}
