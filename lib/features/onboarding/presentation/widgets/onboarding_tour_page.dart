import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';

/// Onboarding page 7 — Feature tour: routines, progress, products.
class OnboardingTourPage extends StatelessWidget {
  const OnboardingTourPage({super.key, required this.onNext});

  /// Called to advance to completion page.
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Title
          Text(
            context.l10n.onboardingTourTitle,
            style: AppTextStyles.displaySmall.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.15, end: 0),
          const SizedBox(height: 24),
          // Feature cards
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _FeatureCard(
                    icon: LucideIcons.sparkles,
                    iconColor: AppColors.primary,
                    title: context.l10n.onboardingTourRoutineTitle,
                    description: context.l10n.onboardingTourRoutineDesc,
                    isDark: isDark,
                    gradient: [
                      AppColors.primary.withValues(alpha: 0.08),
                      AppColors.primaryLight.withValues(alpha: 0.04),
                    ],
                  ).animate(delay: 200.ms).fadeIn(duration: 500.ms).slideX(
                        begin: -0.08,
                        end: 0,
                      ),
                  const SizedBox(height: 14),
                  _FeatureCard(
                    icon: LucideIcons.trendingUp,
                    iconColor: AppColors.secondary,
                    title: context.l10n.onboardingTourProgressTitle,
                    description: context.l10n.onboardingTourProgressDesc,
                    isDark: isDark,
                    gradient: [
                      AppColors.secondary.withValues(alpha: 0.08),
                      AppColors.secondaryLight.withValues(alpha: 0.04),
                    ],
                  ).animate(delay: 400.ms).fadeIn(duration: 500.ms).slideX(
                        begin: 0.08,
                        end: 0,
                      ),
                  const SizedBox(height: 14),
                  _FeatureCard(
                    icon: LucideIcons.shoppingBag,
                    iconColor: AppColors.warning,
                    title: context.l10n.onboardingTourProductsTitle,
                    description: context.l10n.onboardingTourProductsDesc,
                    isDark: isDark,
                    gradient: [
                      AppColors.warning.withValues(alpha: 0.08),
                      AppColors.warning.withValues(alpha: 0.03),
                    ],
                  ).animate(delay: 600.ms).fadeIn(duration: 500.ms).slideX(
                        begin: -0.08,
                        end: 0,
                      ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          AppButton(
            label: context.l10n.continueButton,
            onPressed: onNext,
          ).animate(delay: 800.ms).fadeIn(duration: 400.ms).slideY(
                begin: 0.2,
                end: 0,
              ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

/// Feature showcase card with icon, gradient accent, and description.
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.isDark,
    required this.gradient,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final bool isDark;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon container with gradient
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradient,
              ),
              border: Border.all(
                color: iconColor.withValues(alpha: 0.15),
                width: 0.5,
              ),
            ),
            child: Icon(icon, size: 24, color: iconColor),
          ),
          const SizedBox(width: 14),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
