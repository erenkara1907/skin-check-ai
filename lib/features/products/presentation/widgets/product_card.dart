import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/product_entity.dart';
import 'product_reason_dialog.dart';

/// Compact product card for horizontal scroll lists.
class ProductCard extends StatelessWidget {
  /// Creates a [ProductCard] for the given [product].
  const ProductCard({
    super.key,
    required this.product,
    this.userConcerns = const [],
  });

  /// The product to display.
  final ProductEntity product;

  /// User's skin concerns for "why this product" explanation.
  final List<String> userConcerns;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                height: 120,
                color: isDark
                    ? AppColors.surfaceDark.withValues(alpha: 0.5)
                    : AppColors.backgroundLight,
                child: const Center(
                  child: Icon(LucideIcons.image, size: 32),
                ),
              ),
              errorWidget: (_, __, ___) => Container(
                height: 120,
                color: isDark
                    ? AppColors.surfaceDark.withValues(alpha: 0.5)
                    : AppColors.backgroundLight,
                child: const Center(
                  child: Icon(LucideIcons.imageOff, size: 32),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand
                Text(
                  product.brand,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),

                // Name
                Text(
                  product.name,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // Rating
                _RatingStars(rating: product.rating),
                const SizedBox(height: 4),

                // Price
                Text(
                  product.priceRange,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 8),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: _BuyButton(url: product.affiliateUrl),
                    ),
                    const SizedBox(width: 4),
                    _WhyButton(
                      product: product,
                      userConcerns: userConcerns,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingStars extends StatelessWidget {
  const _RatingStars({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final starValue = index + 1;
        IconData icon;
        if (rating >= starValue) {
          icon = Icons.star_rounded;
        } else if (rating >= starValue - 0.5) {
          icon = Icons.star_half_rounded;
        } else {
          icon = Icons.star_outline_rounded;
        }
        return Icon(icon, size: 14, color: AppColors.warning);
      }),
    );
  }
}

class _BuyButton extends StatelessWidget {
  const _BuyButton({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: ElevatedButton(
        onPressed: () => _openUrl(url),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppTextStyles.labelSmall.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        child: const Text('Satın Al'),
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      log.w('Could not launch URL: $url');
    }
  }
}

class _WhyButton extends StatelessWidget {
  const _WhyButton({
    required this.product,
    required this.userConcerns,
  });

  final ProductEntity product;
  final List<String> userConcerns;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      width: 28,
      child: IconButton.filled(
        onPressed: () => ProductReasonDialog.show(
          context,
          product: product,
          userConcerns: userConcerns,
        ),
        icon: const Icon(LucideIcons.helpCircle, size: 14),
        style: IconButton.styleFrom(
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          foregroundColor: AppColors.primary,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
