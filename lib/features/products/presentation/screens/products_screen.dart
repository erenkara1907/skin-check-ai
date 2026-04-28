import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../domain/entities/product_entity.dart';
import '../providers/product_provider.dart';
import '../widgets/product_category_section.dart';

/// Full product catalog screen grouped by category.
class ProductsScreen extends ConsumerWidget {
  /// Creates a [ProductsScreen].
  const ProductsScreen({super.key, this.concerns = const []});

  /// Optional pre-filter concerns from analysis.
  final List<String> concerns;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = concerns.isEmpty
        ? ref.watch(allProductsProvider)
        : ref.watch(recommendedProductsProvider(concerns));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          concerns.isEmpty
              ? context.l10n.productCatalogTitle
              : context.l10n.recommendedProductsTitle,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Content
              Expanded(
                child: productsAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                  error: (e, _) => _ErrorView(
                    message: e.toString(),
                    onRetry: () => concerns.isEmpty
                        ? ref.invalidate(allProductsProvider)
                        : ref.invalidate(
                            recommendedProductsProvider(concerns),
                          ),
                  ),
                  data: (grouped) => grouped.isEmpty
                      ? _EmptyView(hasConcerns: concerns.isNotEmpty)
                      : _ProductList(
                          grouped: grouped,
                          userConcerns: concerns,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductList extends StatelessWidget {
  const _ProductList({
    required this.grouped,
    required this.userConcerns,
  });

  final Map<ProductCategory, List<ProductEntity>> grouped;
  final List<String> userConcerns;

  @override
  Widget build(BuildContext context) {
    final categories = grouped.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ProductCategorySection(
          category: category,
          products: grouped[category]!,
          userConcerns: userConcerns,
          animationDelay: Duration(milliseconds: index * 100),
        );
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.alertTriangle,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.productsLoadError,
              style: AppTextStyles.titleMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTextStyles.bodySmall.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(LucideIcons.refreshCw, size: 16),
              label: Text(context.l10n.retryButton),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.hasConcerns});

  final bool hasConcerns;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.package,
              size: 48,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              hasConcerns
                  ? context.l10n.noMatchingProducts
                  : context.l10n.noProductsAdded,
              style: AppTextStyles.titleMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
