import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Pricing comparison section: Free vs Pro.
class LandingPricingSection extends StatelessWidget {
  const LandingPricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDesktop = screenWidth > 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 64,
      ),
      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Text(
                'Planını Seç',
                style: AppTextStyles.displaySmall.copyWith(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 12),
              Text(
                'Ücretsiz başla, Pro ile sınırları kaldır',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 48),
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _PricingCard(
                            isDark: isDark,
                            isPro: false,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _PricingCard(
                            isDark: isDark,
                            isPro: true,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _PricingCard(isDark: isDark, isPro: false),
                        const SizedBox(height: 24),
                        _PricingCard(isDark: isDark, isPro: true),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  const _PricingCard({required this.isDark, required this.isPro});

  final bool isDark;
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    final features = isPro
        ? [
            'Sınırsız cilt analizi',
            'Detaylı bakım rutini',
            'Ürün önerileri',
            'İlerleme takibi',
            'Reklamsız deneyim',
            'Öncelikli destek',
          ]
        : [
            'Günde 1 cilt analizi',
            'Temel bakım rutini',
            'Sınırlı ilerleme takibi',
            'Reklam destekli',
          ];

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPro ? AppColors.primary : (isDark ? AppColors.borderDark : AppColors.borderLight),
          width: isPro ? 2 : 1,
        ),
        boxShadow: isPro
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPro)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Popüler',
                style: AppTextStyles.labelMedium.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          Text(
            isPro ? 'Pro' : 'Ücretsiz',
            style: AppTextStyles.headlineLarge.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isPro ? '₺49.99' : '₺0',
                style: AppTextStyles.displayMedium.copyWith(
                  color: isPro
                      ? AppColors.primary
                      : (isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight),
                ),
              ),
              if (isPro)
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 4),
                  child: Text(
                    '/ay',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.check,
                    size: 18,
                    color: isPro ? AppColors.primary : AppColors.secondary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      f,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isPro ? AppColors.primary : Colors.transparent,
                foregroundColor: isPro
                    ? Colors.white
                    : (isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: isPro
                      ? BorderSide.none
                      : BorderSide(
                          color: isDark
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                        ),
                ),
                elevation: isPro ? 4 : 0,
              ),
              child: Text(
                isPro ? 'Pro\'ya Geç' : 'Ücretsiz Başla',
                style: AppTextStyles.titleLarge,
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: isPro ? 300.ms : 100.ms, duration: 600.ms)
        .slideY(begin: 0.1, end: 0);
  }
}
