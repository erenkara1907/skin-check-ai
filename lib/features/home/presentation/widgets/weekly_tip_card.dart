import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';

/// Hardcoded weekly skincare tip card.
class WeeklyTipCard extends StatelessWidget {
  const WeeklyTipCard({super.key});

  List<String> _tips(BuildContext context) => [
    context.l10n.tip1,
    context.l10n.tip2,
    context.l10n.tip3,
    context.l10n.tip4,
    context.l10n.tip5,
    context.l10n.tip6,
    context.l10n.tip7,
  ];

  String _currentTip(BuildContext context) {
    final tips = _tips(context);
    final weekOfYear = DateTime.now().difference(
      DateTime(DateTime.now().year),
    ).inDays ~/ 7;
    return tips[weekOfYear % tips.length];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              LucideIcons.lightbulb,
              size: 20,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.weeklyTipTitle,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: theme.colorScheme.onSurface
                        .withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _currentTip(context),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: theme.colorScheme.onSurface,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(
          begin: 0.05,
          end: 0,
        );
  }
}
