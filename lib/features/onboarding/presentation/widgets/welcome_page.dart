import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';

/// Onboarding screen 1 — Welcome page with animated logo.
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, required this.onStart});

  /// Called when "Başla" button is pressed.
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(flex: 2),
          // Animated logo
          _buildLogo(isDark)
              .animate()
              .fadeIn(duration: 600.ms)
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                duration: 600.ms,
                curve: Curves.easeOutBack,
              ),
          const SizedBox(height: 32),
          // Illustration icons
          _buildIllustration(isDark)
              .animate(delay: 300.ms)
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.2, end: 0),
          const SizedBox(height: 40),
          // Tagline
          Text(
            'Cildini tanı,\ngüzelliğini keşfet',
            textAlign: TextAlign.center,
            style: AppTextStyles.displayMedium.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          )
              .animate(delay: 500.ms)
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.15, end: 0),
          const SizedBox(height: 12),
          Text(
            'Yapay zeka destekli cilt analizi',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ).animate(delay: 650.ms).fadeIn(duration: 400.ms),
          const Spacer(flex: 3),
          // CTA button
          AppButton(
            label: 'Başla',
            onPressed: onStart,
          ).animate(delay: 800.ms).fadeIn(duration: 400.ms).slideY(
                begin: 0.3,
                end: 0,
              ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLogo(bool isDark) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.secondary],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(
        LucideIcons.sparkles,
        size: 48,
        color: Colors.white,
      ),
    );
  }

  Widget _buildIllustration(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          LucideIcons.scan,
          size: 36,
          color: AppColors.primary.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 16),
        Icon(
          LucideIcons.heart,
          size: 28,
          color: AppColors.secondary.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 16),
        Icon(
          LucideIcons.sparkles,
          size: 36,
          color: AppColors.primary.withValues(alpha: 0.6),
        ),
      ],
    );
  }
}
