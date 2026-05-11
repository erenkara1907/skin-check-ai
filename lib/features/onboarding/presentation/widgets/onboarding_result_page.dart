import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/score_circle.dart';
import '../../../analysis/presentation/providers/analysis_provider.dart';

/// Onboarding page 6 — Analysis results showcase.
class OnboardingResultPage extends ConsumerWidget {
  const OnboardingResultPage({super.key, required this.onNext});

  /// Called to advance to the next page.
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final analysisAsync = ref.watch(analysisNotifierProvider);

    return analysisAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (analysis) {
        if (analysis == null) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Title
              Text(
                context.l10n.onboardingResultTitle,
                style: AppTextStyles.displaySmall.copyWith(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(
                    begin: 0.15,
                    end: 0,
                  ),
              const SizedBox(height: 24),
              // Score circle
              ScoreCircle(
                score: analysis.overallScore,
                size: 150,
                strokeWidth: 12,
                label: context.l10n.onboardingResultScoreLabel,
              ).animate(delay: 300.ms).fadeIn(duration: 600.ms).scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.0, 1.0),
                    curve: Curves.easeOutBack,
                  ),
              const SizedBox(height: 12),
              // Skin age badge
              _SkinAgeBadge(
                age: analysis.skinAge,
                isDark: isDark,
              ).animate(delay: 600.ms).fadeIn(duration: 400.ms).slideY(
                    begin: 0.2,
                    end: 0,
                  ),
              const SizedBox(height: 20),
              // Summary card
              AppCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          LucideIcons.fileText,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          context.l10n.analysisResultsTitle,
                          style: AppTextStyles.titleMedium.copyWith(
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      analysis.summary,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                        height: 1.5,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ).animate(delay: 800.ms).fadeIn(duration: 400.ms).slideY(
                    begin: 0.15,
                    end: 0,
                  ),
              const SizedBox(height: 16),
              // Zone count indicator
              _ZoneCountRow(
                zoneCount: analysis.zones.length,
                isDark: isDark,
              ).animate(delay: 1000.ms).fadeIn(duration: 400.ms),
              const Spacer(),
              // CTA
              AppButton(
                label: context.l10n.onboardingResultNext,
                onPressed: onNext,
              ).animate(delay: 1200.ms).fadeIn(duration: 400.ms).slideY(
                    begin: 0.2,
                    end: 0,
                  ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

/// Skin age badge with gradient background.
class _SkinAgeBadge extends StatelessWidget {
  const _SkinAgeBadge({required this.age, required this.isDark});

  final int age;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.12),
            AppColors.secondary.withValues(alpha: 0.12),
          ],
        ),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.clock,
            size: 16,
            color: isDark ? AppColors.primaryLight : AppColors.primary,
          ),
          const SizedBox(width: 6),
          Text(
            context.l10n.onboardingResultSkinAge(age),
            style: AppTextStyles.labelLarge.copyWith(
              color: isDark ? AppColors.primaryLight : AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Row showing how many zones were analyzed.
class _ZoneCountRow extends StatelessWidget {
  const _ZoneCountRow({required this.zoneCount, required this.isDark});

  final int zoneCount;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          LucideIcons.layoutGrid,
          size: 16,
          color: AppColors.secondary,
        ),
        const SizedBox(width: 6),
        Text(
          '$zoneCount ${context.l10n.zoneAnalysisTitle.toLowerCase()}',
          style: AppTextStyles.bodySmall.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}
