import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/entities/skin_type.dart';
import '../providers/onboarding_provider.dart';
import 'skin_type_card.dart';

/// Onboarding screen 2 — Skin type selection (2x2 grid).
class SkinTypePage extends ConsumerWidget {
  const SkinTypePage({super.key, required this.onNext});

  /// Called when user selects and proceeds.
  final VoidCallback onNext;

  static const _icons = {
    SkinType.normal: LucideIcons.droplet,
    SkinType.oily: LucideIcons.sun,
    SkinType.dry: LucideIcons.wind,
    SkinType.combination: LucideIcons.contrast,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(onboardingNotifierProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(
            context.l10n.skinTypeTitle,
            style: AppTextStyles.displaySmall.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.15, end: 0),
          const SizedBox(height: 8),
          Text(
            context.l10n.skinTypeSubtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ).animate(delay: 150.ms).fadeIn(duration: 300.ms),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.9,
              physics: const NeverScrollableScrollPhysics(),
              children: SkinType.values.asMap().entries.map((entry) {
                final type = entry.value;
                return SkinTypeCard(
                  icon: _icons[type]!,
                  label: type.label,
                  description: type.description,
                  isSelected: state.selectedSkinType == type,
                  onTap: () => ref
                      .read(onboardingNotifierProvider.notifier)
                      .selectSkinType(type),
                ).animate(delay: (200 + entry.key * 100).ms).fadeIn(
                      duration: 400.ms,
                    ).slideY(begin: 0.2, end: 0);
              }).toList(),
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
