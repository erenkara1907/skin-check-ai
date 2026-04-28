import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/entities/skin_concern.dart';
import '../providers/onboarding_provider.dart';
import 'concern_chip.dart';

/// Onboarding screen 3 — Skin concerns multi-select.
class SkinConcernsPage extends ConsumerWidget {
  const SkinConcernsPage({super.key, required this.onNext});

  /// Called when user selects concerns and proceeds.
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(onboardingNotifierProvider);
    final notifier = ref.read(onboardingNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(
            context.l10n.skinConcernsTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.displaySmall.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.15, end: 0),
          const SizedBox(height: 8),
          Text(
            context.l10n.skinConcernsSubtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ).animate(delay: 150.ms).fadeIn(duration: 300.ms),
          const SizedBox(height: 32),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: SkinConcern.values.asMap().entries.map((entry) {
                  final concern = entry.value;
                  return ConcernChip(
                    label: concern.label,
                    isSelected: state.selectedConcerns.contains(concern),
                    onTap: () => notifier.toggleConcern(concern),
                  ).animate(delay: (150 + entry.key * 60).ms).fadeIn(
                        duration: 300.ms,
                      ).scale(
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1.0, 1.0),
                      );
                }).toList(),
              ),
            ),
          ),
          AppButton(
            label: context.l10n.continueButton,
            onPressed: state.canProceed ? onNext : null,
          ).animate(delay: 600.ms).fadeIn(duration: 300.ms),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
