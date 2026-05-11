import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Hero section with headline, subtitle, CTA and app mockup.
class LandingHeroSection extends StatelessWidget {
  const LandingHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDesktop = screenWidth > 1024;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [AppColors.backgroundDark, const Color(0xFF1A1535)]
              : [AppColors.backgroundLight, const Color(0xFFEDE9FF)],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: isDesktop ? 80 : 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isDesktop
              ? Row(
                  children: [
                    Expanded(child: _buildContent(context, isDark)),
                    const SizedBox(width: 60),
                    Expanded(child: _buildMockup(context, isDark)),
                  ],
                )
              : Column(
                  children: [
                    _buildContent(context, isDark),
                    const SizedBox(height: 40),
                    _buildMockup(context, isDark),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ).createShader(bounds),
          child: Text(
            context.l10n.landingHeroTitle,
            style: AppTextStyles.displayLarge.copyWith(
              fontSize: 48,
              color: Colors.white,
              height: 1.1,
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideX(begin: -0.1, end: 0),
        const SizedBox(height: 16),
        Text(
          context.l10n.landingHeroDescription,
          style: AppTextStyles.bodyLarge.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            height: 1.6,
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _CtaButton(
              label: context.l10n.getStartedButton,
              onPressed: () {},
            ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
            if (kIsWeb) ...[
              _StoreBadge(
                icon: LucideIcons.apple,
                label: context.l10n.appStoreBadge,
                isDark: isDark,
              ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
              _StoreBadge(
                icon: LucideIcons.playCircle,
                label: context.l10n.googlePlayBadge,
                isDark: isDark,
              ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildMockup(BuildContext context, bool isDark) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.secondary],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 200,
          height: 360,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(LucideIcons.scanFace,
                  size: 64,
                  color: Colors.white.withValues(alpha: 0.9)),
              const SizedBox(height: 16),
              Text('SkinCheck AI',
                  style: AppTextStyles.headlineMedium
                      .copyWith(color: Colors.white)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Skor: 85/100',
                    style: AppTextStyles.labelLarge
                        .copyWith(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 800.ms).scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
        );
  }
}

class _CtaButton extends StatelessWidget {
  const _CtaButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        shadowColor: AppColors.primary.withValues(alpha: 0.4),
      ),
      child: Text(label, style: AppTextStyles.titleLarge),
    );
  }
}

class _StoreBadge extends StatelessWidget {
  const _StoreBadge({
    required this.icon,
    required this.label,
    required this.isDark,
  });

  final IconData icon;
  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label, style: AppTextStyles.titleMedium),
        ],
      ),
    );
  }
}
