import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../products/presentation/providers/product_provider.dart';
import '../../../products/presentation/widgets/product_card.dart';

/// "Önerilen Ürünler" section shown at the bottom of analysis results.
class RecommendedProductsSection extends ConsumerWidget {
  /// Creates a [RecommendedProductsSection].
  const RecommendedProductsSection({
    super.key,
    required this.concerns,
  });

  /// Concerns from the analysis zones.
  final List<String> concerns;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (concerns.isEmpty) return const SizedBox.shrink();

    final productsAsync = ref.watch(recommendedProductsProvider(concerns));

    return productsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (grouped) {
        final allProducts = grouped.values.expand((list) => list).toList();
        if (allProducts.isEmpty) {
          final isDark =
              Theme.of(context).brightness == Brightness.dark;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.glassDark
                  : AppColors.glassLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? AppColors.glassBorderDark
                    : AppColors.glassBorderLight,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  LucideIcons.sparkles,
                  size: 32,
                  color: AppColors.secondary,
                ),
                const SizedBox(height: 12),
                Text(
                  context.l10n.productsComingSoon,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        // Show max 6 products
        final displayProducts = allProducts.take(6).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Row(
              children: [
                Icon(
                  LucideIcons.sparkles,
                  size: 20,
                  color: AppColors.secondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    context.l10n.recommendedProductsTitle,
                    style: AppTextStyles.titleLarge.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => context.push(
                    '/products?concerns=${concerns.join(",")}',
                  ),
                  child: Text(
                    context.l10n.viewAllButton,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Horizontal product list
            SizedBox(
              height: 290,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: displayProducts.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) => ProductCard(
                  product: displayProducts[index],
                  userConcerns: concerns,
                ),
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 1100.ms, duration: 400.ms)
            .slideY(begin: 0.2, end: 0);
      },
    );
  }
}
