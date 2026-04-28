import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../analysis/domain/entities/analysis_entity.dart';

/// Displays a list of past analyses with date and score.
class AnalysisHistoryList extends StatelessWidget {
  const AnalysisHistoryList({super.key, required this.analyses});

  /// Past analyses to display.
  final List<AnalysisEntity> analyses;

  @override
  Widget build(BuildContext context) {
    if (analyses.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.pastAnalysesTitle,
          style: AppTextStyles.titleLarge.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        ...analyses.map(
          (a) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _AnalysisHistoryItem(analysis: a),
          ),
        ),
      ],
    );
  }
}

class _AnalysisHistoryItem extends StatelessWidget {
  const _AnalysisHistoryItem({required this.analysis});

  final AnalysisEntity analysis;

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final score = analysis.overallScore.round();

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      onTap: () => context.push('/progress/detail/${analysis.id}'),
      child: Row(
        children: [
          // Score badge
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.scoreColor(analysis.overallScore)
                  .withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$score',
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.scoreColor(analysis.overallScore),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Date and summary
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDate(analysis.createdAt),
                  style: AppTextStyles.titleSmall.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                if (analysis.summary.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    analysis.summary,
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
              ],
            ),
          ),
          Icon(
            LucideIcons.chevronRight,
            size: 20,
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }
}
