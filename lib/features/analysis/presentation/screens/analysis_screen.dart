import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../subscription/presentation/providers/subscription_provider.dart';

/// Home / analysis hub screen — start a new analysis or view history.
class AnalysisScreen extends ConsumerWidget {
  const AnalysisScreen({super.key});

  void _onStartAnalysis(BuildContext context, WidgetRef ref) async {
    final canAnalyze = await ref.read(canAnalyzeProvider.future);
    if (!context.mounted) return;
    if (canAnalyze) {
      context.go('${AppRoutes.analyze}/camera');
    } else {
      context.push(AppRoutes.paywall);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'SkinCheck AI',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ).animate().fadeIn(duration: 400.ms),
                const SizedBox(height: 4),
                Text(
                  'Cildinizi yapay zeka ile analiz edin',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
                ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                const Spacer(),

                // Hero card
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.glassDark
                          : AppColors.glassLight,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark
                            ? AppColors.glassBorderDark
                            : AppColors.glassBorderLight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          blurRadius: 40,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.secondary,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary
                                    .withValues(alpha: 0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            LucideIcons.scan,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Yeni Analiz Başlat',
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Selfie çekin, AI cildinizi 7 bölgede analiz etsin',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        AppButton(
                          label: 'Kamerayı Aç',
                          onPressed: () => _onStartAnalysis(context, ref),
                          variant: AppButtonVariant.primary,
                          icon: LucideIcons.camera,
                          fullWidth: true,
                        ),
                      ],
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 500.ms)
                    .slideY(begin: 0.1, end: 0),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
