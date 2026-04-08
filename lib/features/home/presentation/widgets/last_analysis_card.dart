import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/score_circle.dart';
import '../../../analysis/domain/entities/analysis_entity.dart';

/// Card showing the latest analysis score and a "re-analyze" CTA.
class LastAnalysisCard extends StatelessWidget {
  const LastAnalysisCard({
    super.key,
    required this.analysis,
    required this.onReanalyze,
  });

  /// Latest analysis result.
  final AnalysisEntity analysis;

  /// Called when user taps "Tekrar analiz et".
  final VoidCallback onReanalyze;

  String _daysAgoText() {
    if (analysis.createdAt == null) return '';
    final diff = DateTime.now().difference(analysis.createdAt!).inDays;
    if (diff == 0) return 'Bugun';
    if (diff == 1) return '1 gun once';
    return '$diff gun once';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Son Analiz',
            style: AppTextStyles.titleMedium.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ScoreCircle(
                score: analysis.overallScore,
                size: 80,
                strokeWidth: 8,
                label: 'Skor',
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cilt Yasi: ${analysis.skinAge}',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _daysAgoText(),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.5),
                      ),
                    ),
                    if (analysis.summary.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        analysis.summary,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Tekrar Analiz Et',
            onPressed: onReanalyze,
            variant: AppButtonVariant.outline,
            icon: LucideIcons.refreshCw,
            fullWidth: true,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0);
  }
}
