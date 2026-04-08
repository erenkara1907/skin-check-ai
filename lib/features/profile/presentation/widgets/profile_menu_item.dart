import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// A single menu row in the profile screen.
class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.textColor,
    this.trailing,
    this.showDivider = true,
  });

  /// Leading icon.
  final IconData icon;

  /// Menu label.
  final String label;

  /// Tap callback.
  final VoidCallback onTap;

  /// Custom icon color.
  final Color? iconColor;

  /// Custom text color.
  final Color? textColor;

  /// Custom trailing widget (defaults to chevron).
  final Widget? trailing;

  /// Whether to show a bottom divider.
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultTextColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final border = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 14,
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: iconColor ??
                        (isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight),
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
                  trailing ??
                      Icon(
                        LucideIcons.chevronRight,
                        size: 18,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(height: 1, color: border, indent: 38),
      ],
    );
  }
}
