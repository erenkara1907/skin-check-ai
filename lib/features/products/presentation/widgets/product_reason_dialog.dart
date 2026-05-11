import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/product_entity.dart';

/// Dialog explaining why a product was recommended.
class ProductReasonDialog extends StatelessWidget {
  /// Creates a [ProductReasonDialog].
  const ProductReasonDialog({
    super.key,
    required this.product,
    required this.userConcerns,
  });

  /// The recommended product.
  final ProductEntity product;

  /// The user's skin concerns.
  final List<String> userConcerns;

  /// Shows the dialog.
  static void show(
    BuildContext context, {
    required ProductEntity product,
    required List<String> userConcerns,
  }) {
    showDialog(
      context: context,
      builder: (_) => ProductReasonDialog(
        product: product,
        userConcerns: userConcerns,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final matchingConcerns = product.suitableConcerns
        .where((c) => userConcerns.contains(c))
        .toList();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Icon(
              LucideIcons.sparkles,
              color: AppColors.primary,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              context.l10n.whyProductTitle(product.name),
              style: AppTextStyles.titleMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              product.brand,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              product.description,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Matching concerns
            if (matchingConcerns.isNotEmpty) ...[
              Text(
                context.l10n.matchingConcerns,
                style: AppTextStyles.labelMedium.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                alignment: WrapAlignment.center,
                children: matchingConcerns
                    .map((c) => _ConcernChip(concern: c))
                    .toList(),
              ),
              const SizedBox(height: 16),
            ],

            // Close button
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                context.l10n.closeButton,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Returns localized concern label for the given concern key.
String _concernLabel(BuildContext context, String concern) {
  final labels = {
    'acne': context.l10n.acneConcern,
    'wrinkles': context.l10n.wrinklesConcern,
    'spots': context.l10n.spotsConcern,
    'pores': context.l10n.poresConcern,
    'dryness': context.l10n.drynessConcern,
    'oiliness': context.l10n.oilinessConcern,
    'darkCircles': context.l10n.darkCirclesConcern,
    'redness': context.l10n.rednessConcern,
  };
  return labels[concern] ?? concern;
}

class _ConcernChip extends StatelessWidget {
  const _ConcernChip({required this.concern});

  final String concern;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _concernLabel(context, concern),
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.secondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
