import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
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
    this.onTap,
  });

  /// Latest analysis result.
  final AnalysisEntity analysis;

  /// Called when user taps "Tekrar analiz et".
  final VoidCallback onReanalyze;

  /// Called when the card is tapped (navigate to detail).
  final VoidCallback? onTap;

  String _daysAgoText(BuildContext context) {
    if (analysis.createdAt == null) return '';
    final diff = DateTime.now().difference(analysis.createdAt!).inDays;
    if (diff == 0) return context.l10n.todayLabel;
    if (diff == 1) return context.l10n.yesterdayLabel;
    return context.l10n.daysAgoLabel(diff);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.lastAnalysisTitle,
                  style: AppTextStyles.titleMedium.copyWith(
                    color:
                        theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ),
              if (onTap != null)
                Icon(
                  LucideIcons.chevronRight,
                  size: 18,
                  color:
                      theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ScoreCircle(
                score: analysis.overallScore,
                size: 80,
                strokeWidth: 8,
                label: context.l10n.scoreLabel,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.skinAgeDisplay(analysis.skinAge),
                      style: AppTextStyles.titleLarge.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _daysAgoText(context),
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
            label: context.l10n.reanalyzeButton,
            onPressed: onReanalyze,
            variant: AppButtonVariant.outline,
            icon: LucideIcons.refreshCw,
            fullWidth: true,
          ),
          if (onTap != null) ...[
            const SizedBox(height: 10),
            Center(
              child: Text(
                '${context.l10n.viewDetailsCta} →',
                style: AppTextStyles.labelMedium.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0);
  }
}
