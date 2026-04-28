import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/routine_diff.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../analysis/domain/entities/routine_step_entity.dart';

/// Modal bottom sheet showing the diff between old and new routines.
class RoutineDiffSheet extends StatelessWidget {
  const RoutineDiffSheet({
    super.key,
    required this.morningDiff,
    required this.eveningDiff,
    required this.onApply,
    required this.onSkip,
  });

  final RoutineDiff morningDiff;
  final RoutineDiff eveningDiff;
  final VoidCallback onApply;
  final VoidCallback onSkip;

  /// Shows this sheet as a modal bottom sheet.
  static Future<bool?> show(
    BuildContext context,
    WidgetRef ref, {
    required RoutineDiff morningDiff,
    required RoutineDiff eveningDiff,
    required VoidCallback onApply,
    required VoidCallback onSkip,
  }) {
    return showAppBottomSheet<bool>(
      context: context,
      ref: ref,
      builder: (ctx) => RoutineDiffSheet(
        morningDiff: morningDiff,
        eveningDiff: eveningDiff,
        onApply: onApply,
        onSkip: onSkip,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.borderDark
                      : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Title
            Text(
              context.l10n.updateRoutineTitle,
              style:
                  AppTextStyles.headlineMedium.copyWith(color: onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.updateRoutinePrompt,
              style: AppTextStyles.bodyMedium.copyWith(
                color: onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 20),
            // Morning diff
            if (morningDiff.hasChanges) ...[
              _SectionHeader(
                label: context.l10n.morningRoutineLabel,
                icon: LucideIcons.sunrise,
              ),
              _buildDiffItems(context, morningDiff),
              const SizedBox(height: 16),
            ],
            // Evening diff
            if (eveningDiff.hasChanges) ...[
              _SectionHeader(
                label: context.l10n.eveningRoutineLabel,
                icon: LucideIcons.sunset,
              ),
              _buildDiffItems(context, eveningDiff),
              const SizedBox(height: 16),
            ],
            if (!morningDiff.hasChanges && !eveningDiff.hasChanges)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  context.l10n.noChangesMessage,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: onSurface.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 8),
            // Buttons
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: context.l10n.skipUpdateButton,
                    variant: AppButtonVariant.outline,
                    onPressed: () {
                      onSkip();
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    label: context.l10n.applyUpdateButton,
                    onPressed: () {
                      onApply();
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiffItems(BuildContext context, RoutineDiff diff) {
    return Column(
      children: [
        ...diff.addedSteps.map(
          (s) => _DiffRow(step: s, type: _DiffType.added),
        ),
        ...diff.removedSteps.map(
          (s) => _DiffRow(step: s, type: _DiffType.removed),
        ),
        ...diff.changedSteps.map(
          (c) => _DiffRow(step: c.updated, type: _DiffType.changed),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.titleMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

enum _DiffType { added, removed, changed }

class _DiffRow extends StatelessWidget {
  const _DiffRow({required this.step, required this.type});

  final RoutineStepEntity step;
  final _DiffType type;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (type) {
      _DiffType.added => (LucideIcons.plus, AppColors.success),
      _DiffType.removed => (LucideIcons.minus, AppColors.error),
      _DiffType.changed => (LucideIcons.refreshCw, AppColors.warning),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.step,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  step.reason,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
