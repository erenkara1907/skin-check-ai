import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../providers/onboarding_provider.dart';

/// Onboarding page 8 — Celebration & get started.
class OnboardingCompletionPage extends ConsumerWidget {
  const OnboardingCompletionPage({super.key, required this.onComplete});

  /// Called when user taps "Start Exploring".
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(onboardingNotifierProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(flex: 2),
          // Celebration animation
          _CelebrationOrb(isDark: isDark)
              .animate()
              .fadeIn(duration: 700.ms)
              .scale(
                begin: const Offset(0.6, 0.6),
                end: const Offset(1.0, 1.0),
                duration: 800.ms,
                curve: Curves.easeOutBack,
              ),
          const SizedBox(height: 28),
          // Title
          Text(
            context.l10n.onboardingCompletionTitle,
            style: AppTextStyles.displayMedium.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ).animate(delay: 400.ms).fadeIn(duration: 500.ms).slideY(
                begin: 0.15,
                end: 0,
              ),
          const SizedBox(height: 8),
          Text(
            context.l10n.onboardingCompletionSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ).animate(delay: 550.ms).fadeIn(duration: 400.ms),
          const SizedBox(height: 32),
          // Feature list
          ..._buildFeatures(context, isDark),
          const Spacer(flex: 3),
          // CTA
          AppButton(
            label: context.l10n.onboardingStartExploring,
            isLoading: state.isLoading,
            onPressed: state.isLoading ? null : onComplete,
          ).animate(delay: 1000.ms).fadeIn(duration: 400.ms).slideY(
                begin: 0.2,
                end: 0,
              ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  List<Widget> _buildFeatures(BuildContext context, bool isDark) {
    final features = [
      (LucideIcons.bell, context.l10n.onboardingCompletionFeature1),
      (LucideIcons.calendarCheck, context.l10n.onboardingCompletionFeature2),
      (LucideIcons.heart, context.l10n.onboardingCompletionFeature3),
    ];

    return features.asMap().entries.map((entry) {
      final i = entry.key;
      final (icon, text) = entry.value;
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withValues(alpha: 0.12),
              ),
              child: Icon(icon, size: 16, color: AppColors.secondary),
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ).animate(delay: (650 + i * 120).ms).fadeIn(duration: 400.ms).slideX(
              begin: 0.1,
              end: 0,
            ),
      );
    }).toList();
  }
}

/// Celebration orb with multiple animated rings and checkmark.
class _CelebrationOrb extends StatelessWidget {
  const _CelebrationOrb({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer ring 1
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.secondary.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(0.95, 0.95),
                end: const Offset(1.1, 1.1),
                duration: 2500.ms,
                curve: Curves.easeInOut,
              ),
          // Outer ring 2
          Container(
            width: 115,
            height: 115,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.12),
                width: 1,
              ),
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.08, 1.08),
                duration: 2000.ms,
                curve: Curves.easeInOut,
              ),
          // Core gradient
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.secondary, AppColors.primary],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha: 0.35),
                  blurRadius: 28,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              LucideIcons.check,
              size: 44,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
