import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/logger.dart';
import '../../../../shared/widgets/app_button.dart';

/// Onboarding page 0 — Welcome + first analysis intro with 3-step flow.
class FirstAnalysisPage extends StatelessWidget {
  const FirstAnalysisPage({
    super.key,
    required this.onStartCamera,
    required this.onSkip,
  });

  /// Called after camera permission granted.
  final VoidCallback onStartCamera;

  /// Called when user wants to skip analysis.
  final VoidCallback onSkip;

  Future<void> _handleStart(BuildContext context) async {
    // Request camera permission
    final status = await Permission.camera.request();
    log.d('Camera permission status: $status');

    if (!status.isGranted && !status.isLimited) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.cameraInitError)),
        );
      }
      return;
    }

    onStartCamera();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(flex: 1),
          // Animated scanner icon
          _ScannerOrb(isDark: isDark)
              .animate()
              .fadeIn(duration: 600.ms)
              .scale(
                begin: const Offset(0.7, 0.7),
                end: const Offset(1.0, 1.0),
                curve: Curves.easeOutBack,
              ),
          const SizedBox(height: 28),
          // Title
          Text(
            context.l10n.onboardingFirstAnalysisTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.displayMedium.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ).animate(delay: 300.ms).fadeIn(duration: 500.ms).slideY(
                begin: 0.15,
                end: 0,
              ),
          const SizedBox(height: 8),
          Text(
            context.l10n.onboardingFirstAnalysisSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ).animate(delay: 450.ms).fadeIn(duration: 400.ms),
          const SizedBox(height: 32),
          // 3-step flow
          ..._buildSteps(context, isDark),
          const Spacer(flex: 2),
          // CTA
          AppButton(
            label: context.l10n.onboardingOpenCamera,
            icon: LucideIcons.camera,
            onPressed: () => _handleStart(context),
          ).animate(delay: 800.ms).fadeIn(duration: 400.ms).slideY(
                begin: 0.2,
                end: 0,
              ),
          const SizedBox(height: 12),
          AppButton(
            label: context.l10n.onboardingSkipAnalysis,
            variant: AppButtonVariant.text,
            onPressed: onSkip,
          ).animate(delay: 900.ms).fadeIn(duration: 300.ms),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  List<Widget> _buildSteps(BuildContext context, bool isDark) {
    final steps = [
      (LucideIcons.camera, context.l10n.onboardingStep1Label,
          context.l10n.onboardingStep1Desc),
      (LucideIcons.sparkles, context.l10n.onboardingStep2Label,
          context.l10n.onboardingStep2Desc),
      (LucideIcons.barChart2, context.l10n.onboardingStep3Label,
          context.l10n.onboardingStep3Desc),
    ];

    return steps.asMap().entries.map((entry) {
      final i = entry.key;
      final (icon, label, desc) = entry.value;
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: _StepRow(
          index: i + 1,
          icon: icon,
          label: label,
          description: desc,
          isDark: isDark,
        ).animate(delay: (500 + i * 120).ms).fadeIn(duration: 400.ms).slideX(
              begin: 0.1,
              end: 0,
            ),
      );
    }).toList();
  }
}

/// Animated scanner orb with pulse rings.
class _ScannerOrb extends StatelessWidget {
  const _ScannerOrb({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer pulse ring
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.12),
                width: 1.5,
              ),
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(0.95, 0.95),
                end: const Offset(1.08, 1.08),
                duration: 2200.ms,
                curve: Curves.easeInOut,
              ),
          // Middle ring
          Container(
            width: 105,
            height: 105,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.secondary.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.1, 1.1),
                duration: 1800.ms,
                curve: Curves.easeInOut,
              ),
          // Core circle
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.secondary],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(
              LucideIcons.scanFace,
              size: 38,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/// Single step row: number badge + icon + text.
class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.index,
    required this.icon,
    required this.label,
    required this.description,
    required this.isDark,
  });

  final int index;
  final IconData icon;
  final String label;
  final String description;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Number badge
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.15),
                AppColors.secondary.withValues(alpha: 0.15),
              ],
            ),
          ),
          child: Center(
            child: Text(
              '$index',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        // Icon
        Icon(icon, size: 22, color: AppColors.secondary),
        const SizedBox(width: 12),
        // Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.titleMedium.copyWith(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
              Text(
                description,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
