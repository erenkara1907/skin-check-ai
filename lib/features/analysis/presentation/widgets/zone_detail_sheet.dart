import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/concern_step_matcher.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/score_circle.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../routine/presentation/providers/routine_provider.dart';
import '../../domain/entities/skin_zone.dart';
import '../../domain/entities/zone_score_entity.dart';
import 'concern_routine_link.dart';

/// Bottom sheet showing detailed info for a single face zone.
class ZoneDetailSheet extends ConsumerWidget {
  const ZoneDetailSheet({super.key, required this.zone});

  final ZoneScoreEntity zone;

  /// Show this sheet as a modal bottom sheet.
  static Future<void> show(
    BuildContext context,
    WidgetRef ref,
    ZoneScoreEntity zone,
  ) {
    return showAppBottomSheet<void>(
      context: context,
      ref: ref,
      barrierColor: Colors.black54,
      builder: (ctx) => GestureDetector(
        onTap: () => Navigator.of(ctx).pop(),
        behavior: HitTestBehavior.opaque,
        child: GestureDetector(
          onTap: () {},
          child: ZoneDetailSheet(zone: zone),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final zoneName = _translateZone(context, zone.zone);
    final scoreColor = AppColors.scoreColor(zone.score);
    final userId = ref.watch(authNotifierProvider).valueOrNull?.id;

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
                context.l10n.detectedConcerns,
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
                    label: Text(
                      _translateConcern(context, c),
                      style: AppTextStyles.labelMedium,
                    ),
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
                context.l10n.recommendationsTitle,
                style: AppTextStyles.titleMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              ...zone.recommendations.map(_buildRecommendationCard),
            ],
            // Related routine steps
            if (userId != null && zone.concerns.isNotEmpty)
              _buildRoutineLinks(context, ref, userId),
          ],
        ),
      ),
    );
  }

  /// Builds the related routine steps section for this zone's concerns.
  Widget _buildRoutineLinks(
    BuildContext context,
    WidgetRef ref,
    String userId,
  ) {
    final routinesAsync = ref.watch(routineNotifierProvider(userId));
    final routines = routinesAsync.valueOrNull ?? [];
    if (routines.isEmpty) return const SizedBox.shrink();

    final morningSteps = routines
        .where((r) => r.type == 'morning')
        .expand((r) => r.steps)
        .toList();
    final eveningSteps = routines
        .where((r) => r.type == 'evening')
        .expand((r) => r.steps)
        .toList();

    final matches = zone.concerns
        .expand(
          (c) => ConcernStepMatcher.match(
            concern: c,
            morningSteps: morningSteps,
            eveningSteps: eveningSteps,
          ),
        )
        .toList();

    if (matches.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          context.l10n.relatedRoutineSteps,
          style: AppTextStyles.titleMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        ...matches.map((m) => ConcernRoutineLink(match: m)),
      ],
    );
  }

  /// Translates a zone API key to the localized label.
  String _translateZone(BuildContext context, String zone) {
    final map = {
      'forehead': context.l10n.zoneForehead,
      'left_cheek': context.l10n.zoneLeftCheek,
      'right_cheek': context.l10n.zoneRightCheek,
      'nose': context.l10n.zoneNose,
      'chin': context.l10n.zoneChin,
      'under_eyes': context.l10n.zoneUnderEyes,
      'jawline': context.l10n.zoneJawline,
    };
    return map[zone] ?? SkinZone.fromValue(zone).label;
  }

  /// Translates an English concern key to the localized label.
  String _translateConcern(BuildContext context, String concern) {
    final key = concern.toLowerCase().trim();
    final map = {
      'dryness': context.l10n.concernDryness,
      'oiliness': context.l10n.concernOiliness,
      'acne': context.l10n.concernAcne,
      'wrinkles': context.l10n.concernWrinkles,
      'fine lines': context.l10n.concernFinelines,
      'spots': context.l10n.concernSpots,
      'pores': context.l10n.concernPores,
      'visible pores': context.l10n.concernPores,
      'redness': context.l10n.concernRedness,
      'dark circles': context.l10n.concernDarkCircles,
      'uneven tone': context.l10n.concernUnevenTone,
      'uneven skin tone': context.l10n.concernUnevenTone,
      'sagging': context.l10n.concernSagging,
      'sensitivity': context.l10n.concernSensitivity,
      'dehydration': context.l10n.concernDehydration,
      'hyperpigmentation': context.l10n.concernHyperpigmentation,
      'texture': context.l10n.concernTexture,
    };
    return map[key] ?? concern;
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
              context.l10n.severityLabel,
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
