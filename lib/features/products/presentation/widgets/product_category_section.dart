import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/product_entity.dart';
import 'product_card.dart';

/// A horizontal-scroll section for a single product category.
class ProductCategorySection extends StatelessWidget {
  /// Creates a [ProductCategorySection].
  const ProductCategorySection({
    super.key,
    required this.category,
    required this.products,
    this.userConcerns = const [],
    this.animationDelay = Duration.zero,
  });

  /// Category enum for the title.
  final ProductCategory category;

  /// Products in this category.
  final List<ProductEntity> products;

  /// User concerns passed to each card.
  final List<String> userConcerns;

  /// Staggered animation delay.
  final Duration animationDelay;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            category.label,
            style: AppTextStyles.titleLarge.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 290,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => ProductCard(
              product: products[index],
              userConcerns: userConcerns,
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    )
        .animate()
        .fadeIn(delay: animationDelay, duration: 400.ms)
        .slideY(begin: 0.1, end: 0);
  }
}
