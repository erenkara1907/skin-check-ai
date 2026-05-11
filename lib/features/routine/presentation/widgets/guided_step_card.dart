import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/routine_step_detail_entity.dart';

/// Large-format step card for the guided routine mode.
class GuidedStepCard extends StatelessWidget {
  const GuidedStepCard({super.key, required this.step, required this.index});

  final RoutineStepDetailEntity step;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.glassDark : AppColors.glassLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? AppColors.glassBorderDark
              : AppColors.glassBorderLight,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              _resolveIcon(step.iconName),
              size: 28,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          // Step number + name
          Text(
            '${index + 1}. ${step.step}',
            style: AppTextStyles.headlineSmall.copyWith(color: onSurface),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // Why section
          _Section(
            icon: LucideIcons.helpCircle,
            title: context.l10n.whyThisStep,
            content: step.reason,
          ),
          const SizedBox(height: 12),
          // How section
          if (step.howToApply.isNotEmpty)
            _Section(
              icon: LucideIcons.hand,
              title: context.l10n.howToApply,
              content: step.howToApply,
            ),
        ],
      ),
    );
  }

  IconData _resolveIcon(String name) {
    const map = {
      'droplets': LucideIcons.droplets,
      'droplet': LucideIcons.droplet,
      'spray-can': LucideIcons.sprayCan,
      'flask-round': LucideIcons.flaskRound,
      'cloud': LucideIcons.cloud,
      'sun': LucideIcons.sun,
      'eye': LucideIcons.eye,
      'smile': LucideIcons.smile,
      'sparkles': LucideIcons.sparkles,
      'moon': LucideIcons.moon,
      'pill': LucideIcons.pill,
    };
    return map[name] ?? LucideIcons.droplets;
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.icon,
    required this.title,
    required this.content,
  });

  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.secondary),
            const SizedBox(width: 6),
            Text(
              title,
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          content,
          style: AppTextStyles.bodyMedium.copyWith(
            color: onSurface.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
