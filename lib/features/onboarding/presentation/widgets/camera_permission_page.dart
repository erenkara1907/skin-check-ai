import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/logger.dart';
import '../../../../shared/widgets/app_button.dart';
import '../providers/onboarding_provider.dart';

/// Onboarding screen 4 — Camera permission request.
class CameraPermissionPage extends ConsumerWidget {
  const CameraPermissionPage({
    super.key,
    required this.onComplete,
  });

  /// Called after permission granted and onboarding completed.
  final VoidCallback onComplete;

  Future<void> _requestAndComplete(WidgetRef ref) async {
    final status = await Permission.camera.request();
    log.d('Camera permission status: $status');

    final notifier = ref.read(onboardingNotifierProvider.notifier);
    final success = await notifier.completeOnboarding();
    if (success) {
      onComplete();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(onboardingNotifierProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(flex: 2),
          // Camera icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: const Icon(
              LucideIcons.camera,
              size: 56,
              color: AppColors.primary,
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms)
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                curve: Curves.easeOutBack,
              ),
          const SizedBox(height: 32),
          Text(
            'Cilt analizin için\nkameraya ihtiyacımız var',
            textAlign: TextAlign.center,
            style: AppTextStyles.displaySmall.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ).animate(delay: 300.ms).fadeIn(duration: 400.ms).slideY(
                begin: 0.15,
                end: 0,
              ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.shield,
                size: 16,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
              const SizedBox(width: 6),
              Text(
                'Fotoğrafların güvenle saklanır',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ).animate(delay: 450.ms).fadeIn(duration: 300.ms),
          const Spacer(flex: 3),
          AppButton(
            label: 'Analizimi Başlat',
            isLoading: state.isLoading,
            onPressed:
                state.isLoading ? null : () => _requestAndComplete(ref),
          ).animate(delay: 600.ms).fadeIn(duration: 400.ms).slideY(
                begin: 0.3,
                end: 0,
              ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
