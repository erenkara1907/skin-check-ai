import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Features section showcasing 4 key app capabilities.
class LandingFeaturesSection extends StatelessWidget {
  const LandingFeaturesSection({super.key});

  static const _features = [
    _Feature(
      icon: LucideIcons.scanFace,
      title: 'AI Cilt Analizi',
      description:
          'Yapay zekâ yüzünü 7 bölgede analiz eder ve detaylı skor verir.',
      gradient: [AppColors.primary, AppColors.primaryLight],
    ),
    _Feature(
      icon: LucideIcons.sparkles,
      title: 'Kişisel Rutin',
      description:
          'Cilt tipine ve sorunlarına özel sabah/akşam bakım rutini oluşturur.',
      gradient: [AppColors.secondary, AppColors.secondaryLight],
    ),
    _Feature(
      icon: LucideIcons.trendingUp,
      title: 'İlerleme Takibi',
      description:
          'Zaman içindeki cilt değişimini grafiklerle takip et.',
      gradient: [AppColors.info, Color(0xFF60A5FA)],
    ),
    _Feature(
      icon: LucideIcons.shoppingBag,
      title: 'Ürün Önerileri',
      description:
          'Cilt sorunlarına uygun ürün önerileri al, hemen satın al.',
      gradient: [AppColors.warning, Color(0xFFFCD34D)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 768;
    final crossAxisCount = isDesktop ? 4 : (isTablet ? 2 : 1);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 64,
      ),
      color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Öne Çıkan Özellikler',
                style: AppTextStyles.displaySmall.copyWith(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 12),
              Text(
                'Cilt bakımında yapay zekâ devrimini keşfet',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 48),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: crossAxisCount == 1 ? 2.2 : 0.85,
                ),
                itemCount: _features.length,
                itemBuilder: (context, index) => _FeatureCard(
                  feature: _features[index],
                  index: index,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Feature {
  const _Feature({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });

  final IconData icon;
  final String title;
  final String description;
  final List<Color> gradient;
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.feature,
    required this.index,
    required this.isDark,
  });

  final _Feature feature;
  final int index;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: feature.gradient),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(feature.icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            feature.title,
            style: AppTextStyles.headlineSmall.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            feature.description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              height: 1.5,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: (150 * index).ms, duration: 600.ms)
        .slideY(begin: 0.15, end: 0);
  }
}
