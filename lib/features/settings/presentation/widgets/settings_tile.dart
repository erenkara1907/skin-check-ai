import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// A single settings row with icon, label, optional value, and trailing.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.onTap,
    this.trailing,
    this.iconColor,
    this.textColor,
    this.showDivider = true,
  });

  /// Leading icon.
  final IconData icon;

  /// Tile label.
  final String label;

  /// Optional value text shown on the right.
  final String? value;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Custom trailing widget (defaults to chevron if onTap is set).
  final Widget? trailing;

  /// Custom icon color.
  final Color? iconColor;

  /// Custom text color.
  final Color? textColor;

  /// Whether to show a bottom divider.
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultTextColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final subtextColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final border = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: iconColor ?? AppColors.primary,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      label,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: textColor ?? defaultTextColor,
                      ),
                    ),
                  ),
                  if (value != null) ...[
                    Text(
                      value!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: subtextColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                  if (trailing != null)
                    trailing!
                  else if (onTap != null)
                    Icon(
                      LucideIcons.chevronRight,
                      size: 18,
                      color: subtextColor,
                    ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(height: 1, color: border, indent: 50),
      ],
    );
  }
}
