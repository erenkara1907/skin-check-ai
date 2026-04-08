import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/score_circle.dart';
import '../../domain/entities/skin_zone.dart';
import '../../domain/entities/zone_score_entity.dart';

/// Bottom sheet showing detailed info for a single face zone.
class ZoneDetailSheet extends StatelessWidget {
  const ZoneDetailSheet({super.key, required this.zone});

  final ZoneScoreEntity zone;

  /// Show this sheet as a modal bottom sheet.
  static Future<void> show(BuildContext context, ZoneScoreEntity zone) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ZoneDetailSheet(zone: zone),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final zoneName = SkinZone.fromValue(zone.zone).label;
    final scoreColor = AppColors.scoreColor(zone.score);

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.borderDark
                      : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Zone name + score
            Row(
              children: [
                Expanded(
                  child: Text(
                    zoneName,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                ScoreCircle(
                  score: zone.score,
                  size: 64,
                  strokeWidth: 6,
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Severity bar
            _SeverityBar(severity: zone.severity),
            const SizedBox(height: 24),
            // Concerns
            if (zone.concerns.isNotEmpty) ...[
              Text(
                'Tespit Edilen Sorunlar',
                style: AppTextStyles.titleMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: zone.concerns.map((c) {
                  return Chip(
                    label: Text(c, style: AppTextStyles.labelMedium),
                    backgroundColor: scoreColor.withValues(alpha: 0.12),
                    side: BorderSide(
                      color: scoreColor.withValues(alpha: 0.3),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],
            // Recommendations
            if (zone.recommendations.isNotEmpty) ...[
              Text(
                'Öneriler',
                style: AppTextStyles.titleMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              ...zone.recommendations.map(_buildRecommendationCard),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(String text) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.glassDark
                : AppColors.glassLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark
                  ? AppColors.glassBorderDark
                  : AppColors.glassBorderLight,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.lightbulb_outline,
                size: 18,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SeverityBar extends StatelessWidget {
  const _SeverityBar({required this.severity});

  final int severity;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fraction = severity.clamp(1, 10) / 10;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ciddiyet',
              style: AppTextStyles.labelLarge.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.7),
              ),
            ),
            Text(
              '$severity/10',
              style: AppTextStyles.labelLarge.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 8,
            child: Stack(
              children: [
                // Background
                Container(
                  color: isDark
                      ? AppColors.borderDark
                      : AppColors.borderLight,
                ),
                // Fill
                FractionallySizedBox(
                  widthFactor: fraction,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.scoreHigh,
                          AppColors.scoreMedium,
                          AppColors.scoreLow,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
