import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/zone_progress_entity.dart';

/// A single zone progress row with bar and change indicator.
class ZoneProgressItem extends StatelessWidget {
  const ZoneProgressItem({super.key, required this.zone});

  /// Zone progress data.
  final ZoneProgressEntity zone;

  String _translateZone(BuildContext context, String zone) {
    final map = {
      'forehead': context.l10n.zoneForehead,
      'left_cheek': context.l10n.zoneLeftCheek,
      'right_cheek': context.l10n.zoneRightCheek,
      'nose': context.l10n.zoneNose,
      'chin': context.l10n.zoneChin,
      'under_eyes': context.l10n.zoneUnderEyes,
      'jawline': context.l10n.zoneJawline,
    };
    return map[zone] ?? zone;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPositive = zone.changePercent >= 0;
    final changeColor = isPositive ? AppColors.success : AppColors.error;
    final changeIcon =
        isPositive ? LucideIcons.trendingUp : LucideIcons.trendingDown;
    final barColor = AppColors.scoreColor(zone.currentScore);
    final trackColor = isDark
        ? AppColors.borderDark
        : AppColors.borderLight;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              _translateZone(context, zone.zone),
              style: AppTextStyles.bodySmall.copyWith(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (zone.currentScore / 100).clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor: trackColor,
                valueColor: AlwaysStoppedAnimation(barColor),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(changeIcon, size: 14, color: changeColor),
          const SizedBox(width: 4),
          SizedBox(
            width: 48,
            child: Text(
              '${isPositive ? '+' : ''}${zone.changePercent.toStringAsFixed(1)}%',
              style: AppTextStyles.labelSmall.copyWith(
                color: changeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
