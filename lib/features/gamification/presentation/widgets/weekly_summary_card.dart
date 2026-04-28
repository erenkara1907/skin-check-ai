import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../providers/weekly_summary_provider.dart';

/// Card showing weekly routine completion summary.
class WeeklySummaryCard extends ConsumerWidget {
  const WeeklySummaryCard({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(weeklySummaryNotifierProvider(userId));

    return summaryAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (summary) {
        final total = summary.morningCompleted + summary.eveningCompleted;
        if (total == 0) return const SizedBox.shrink();

        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.weeklySummaryTitle,
                style: AppTextStyles.titleMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              // Morning progress
              _ProgressRow(
                label: context.l10n.morningTab,
                completed: summary.morningCompleted,
                total: summary.totalDays,
                color: AppColors.secondary,
              ),
              const SizedBox(height: 8),
              // Evening progress
              _ProgressRow(
                label: context.l10n.eveningTab,
                completed: summary.eveningCompleted,
                total: summary.totalDays,
                color: AppColors.primary,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({
    required this.label,
    required this.completed,
    required this.total,
    required this.color,
  });

  final String label;
  final int completed;
  final int total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fraction = total > 0 ? completed / total : 0.0;

    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.7),
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fraction,
              backgroundColor:
                  isDark ? AppColors.borderDark : AppColors.borderLight,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$completed/$total',
          style: AppTextStyles.labelMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
