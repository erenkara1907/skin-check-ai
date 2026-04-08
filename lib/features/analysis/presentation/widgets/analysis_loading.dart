import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Shimmer loading animation shown during skin analysis.
class AnalysisLoading extends StatelessWidget {
  const AnalysisLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated face silhouette
          Container(
            width: 120,
            height: 120,
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
            child: Icon(
              Icons.face,
              size: 64,
              color: isDark ? AppColors.primaryLight : AppColors.primary,
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(0.95, 0.95),
                end: const Offset(1.05, 1.05),
                duration: 1200.ms,
                curve: Curves.easeInOut,
              )
              .shimmer(
                duration: 1500.ms,
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
          const SizedBox(height: 32),
          Text(
            'Cildiniz analiz ediliyor...',
            style: AppTextStyles.titleLarge.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: 12),
          // Progress bar shimmer
          Container(
            width: 200,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: isDark
                  ? AppColors.surfaceDark
                  : AppColors.borderLight,
            ),
          )
              .animate(onPlay: (c) => c.repeat())
              .shimmer(
                duration: 1500.ms,
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
          const SizedBox(height: 16),
          Text(
            'AI modelimiz cildinizi 7 bölgede inceliyor',
            style: AppTextStyles.bodySmall.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.5),
            ),
          ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
        ],
      ),
    );
  }
}
