import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Free vs Pro feature comparison table.
class FeatureComparisonTable extends StatelessWidget {
  const FeatureComparisonTable({super.key});

  static const _features = [
    _Feature('Haftalik 1 Analiz', true, true),
    _Feature('Genel Skor', true, true),
    _Feature('Paylasim Karti', true, true),
    _Feature('Sinirsiz Analiz', false, true),
    _Feature('Bolge Haritasi', false, true),
    _Feature('Cilt Yasi', false, true),
    _Feature('Rutin Olusturucu', false, true),
    _Feature('Ilerleme Takibi', false, true),
    _Feature('Time-lapse', false, true),
    _Feature('Reklamsiz', false, true),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final subtleColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return Column(
      children: [
        // Header row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Ozellikler',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: subtleColor,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Free',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: subtleColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Pro',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: const Color(0xFFFFD700),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Feature rows
        ...List.generate(_features.length, (i) {
          final f = _features[i];
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: i.isEven
                  ? (isDark
                      ? Colors.white.withValues(alpha: 0.03)
                      : Colors.black.withValues(alpha: 0.02))
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    f.name,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: textColor,
                    ),
                  ),
                ),
                Expanded(child: _buildIcon(f.free)),
                Expanded(child: _buildIcon(f.pro)),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildIcon(bool available) {
    return Center(
      child: Icon(
        available ? LucideIcons.check : LucideIcons.x,
        size: 18,
        color: available ? AppColors.success : AppColors.error,
      ),
    );
  }
}

class _Feature {
  const _Feature(this.name, this.free, this.pro);
  final String name;
  final bool free;
  final bool pro;
}
