import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Onboarding page 5 — Premium analysis loading with staged animation.
class OnboardingLoadingPage extends StatefulWidget {
  const OnboardingLoadingPage({super.key});

  @override
  State<OnboardingLoadingPage> createState() => _OnboardingLoadingPageState();
}

class _OnboardingLoadingPageState extends State<OnboardingLoadingPage> {
  int _stage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_stage < 3 && mounted) {
        setState(() => _stage++);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<(IconData, String)> _stages(BuildContext context) => [
        (LucideIcons.scanFace, context.l10n.onboardingAnalyzingStage1),
        (LucideIcons.layers, context.l10n.onboardingAnalyzingStage2),
        (LucideIcons.sparkles, context.l10n.onboardingAnalyzingStage3),
        (LucideIcons.checkCircle2, context.l10n.onboardingAnalyzingStage4),
      ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final stages = _stages(context);
    final (icon, message) = stages[_stage];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(flex: 2),
          // Title
          Text(
            context.l10n.onboardingAnalyzingTitle,
            style: AppTextStyles.displaySmall.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ).animate().fadeIn(duration: 500.ms),
          const SizedBox(height: 40),
          // Animated orb with icon
          _AnalysisOrb(icon: icon, stage: _stage),
          const SizedBox(height: 36),
          // Stage message
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: Text(
              message,
              key: ValueKey(_stage),
              style: AppTextStyles.titleLarge.copyWith(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          // Progress bar
          _GradientProgressBar(progress: (_stage + 1) / stages.length),
          const SizedBox(height: 16),
          Text(
            context.l10n.onboardingAnalyzingFooter,
            style: AppTextStyles.bodySmall.copyWith(
              color: (isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight)
                  .withValues(alpha: 0.7),
            ),
          ).animate(delay: 300.ms).fadeIn(duration: 400.ms),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}

/// Animated analysis orb with pulsing rings and rotating icon.
class _AnalysisOrb extends StatelessWidget {
  const _AnalysisOrb({required this.icon, required this.stage});

  final IconData icon;
  final int stage;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer pulse
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.08),
                width: 1.5,
              ),
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(0.9, 0.9),
                end: const Offset(1.1, 1.1),
                duration: 2500.ms,
                curve: Curves.easeInOut,
              ),
          // Middle ring
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.secondary.withValues(alpha: 0.12),
                width: 1,
              ),
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.12, 1.12),
                duration: 2000.ms,
                curve: Curves.easeInOut,
              ),
          // Core gradient
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.2),
                  AppColors.secondary.withValues(alpha: 0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Icon(
                icon,
                key: ValueKey(stage),
                size: 48,
                color: isDark ? AppColors.primaryLight : AppColors.primary,
              ),
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .rotate(
                begin: -0.02,
                end: 0.02,
                duration: 3000.ms,
                curve: Curves.easeInOut,
              )
              .shimmer(
                duration: 1800.ms,
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
        ],
      ),
    );
  }
}

/// Gradient progress bar.
class _GradientProgressBar extends StatelessWidget {
  const _GradientProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 240,
      height: 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: isDark ? AppColors.surfaceDark : AppColors.borderLight,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedFractionallySizedBox(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
          widthFactor: progress.clamp(0.05, 0.95),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
