import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';

/// Badge highlighting the most improved zone.
class MostImprovedBadge extends StatelessWidget {
  const MostImprovedBadge({
    super.key,
    required this.zoneName,
    required this.changePercent,
  });

  /// Turkish display name of the zone.
  final String zoneName;

  /// Percent improvement.
  final double changePercent;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              LucideIcons.star,
              size: 18,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'En Cok Gelisen Bolge',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$zoneName  +${changePercent.toStringAsFixed(1)}%',
                  style: AppTextStyles.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
