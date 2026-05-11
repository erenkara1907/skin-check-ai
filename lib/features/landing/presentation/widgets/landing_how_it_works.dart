import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// "Nasıl Çalışır?" section with 3 steps.
class LandingHowItWorks extends StatelessWidget {
  const LandingHowItWorks({super.key});

  /// Builds the steps list with localized strings.
  static List<_Step> _buildSteps(BuildContext context) => [
        _Step(
          icon: LucideIcons.camera,
          title: context.l10n.step1Title,
          description: context.l10n.step1Desc,
        ),
        _Step(
          icon: LucideIcons.brain,
          title: context.l10n.step2Title,
          description: context.l10n.step2Desc,
        ),
        _Step(
          icon: LucideIcons.sparkles,
          title: context.l10n.step3Title,
          description: context.l10n.step3Desc,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDesktop = screenWidth > 1024;
    final steps = _buildSteps(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 64,
      ),
      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              _buildSectionTitle(context, isDark),
              const SizedBox(height: 48),
              isDesktop
                  ? Row(
                      children: steps.asMap().entries.map((entry) {
                        return Expanded(
                          child: _StepCard(
                            step: entry.value,
                            index: entry.key,
                            isDark: isDark,
                          ),
                        );
                      }).toList(),
                    )
                  : Column(
                      children: steps.asMap().entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: _StepCard(
                            step: entry.value,
                            index: entry.key,
                            isDark: isDark,
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, bool isDark) {
    return Column(
      children: [
        Text(
          context.l10n.howItWorksTitle,
          style: AppTextStyles.displaySmall.copyWith(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ).animate().fadeIn(duration: 600.ms),
        const SizedBox(height: 8),
        Text(
          context.l10n.howItWorksSubtitle,
          style: AppTextStyles.bodyLarge.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
      ],
    );
  }
}

class _Step {
  const _Step({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.step,
    required this.index,
    required this.isDark,
  });

  final _Step step;
  final int index;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          // Step number circle
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 1}',
              style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          // Icon
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              step.icon,
              size: 32,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            step.title,
            style: AppTextStyles.headlineSmall.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: (200 * index).ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0);
  }
}
