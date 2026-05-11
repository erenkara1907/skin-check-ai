import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Theme mode radio selector (System / Light / Dark).
class ThemeSelector extends StatelessWidget {
  const ThemeSelector({
    super.key,
    required this.currentMode,
    required this.onChanged,
  });

  /// Currently selected theme mode.
  final ThemeMode currentMode;

  /// Callback when mode changes.
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final border = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Column(
      children: [
        _ThemeOption(
          icon: LucideIcons.smartphone,
          label: context.l10n.systemTheme,
          isSelected: currentMode == ThemeMode.system,
          onTap: () => onChanged(ThemeMode.system),
          textColor: textColor,
          showDivider: true,
          border: border,
        ),
        _ThemeOption(
          icon: LucideIcons.sun,
          label: context.l10n.lightTheme,
          isSelected: currentMode == ThemeMode.light,
          onTap: () => onChanged(ThemeMode.light),
          textColor: textColor,
          showDivider: true,
          border: border,
        ),
        _ThemeOption(
          icon: LucideIcons.moon,
          label: context.l10n.darkTheme,
          isSelected: currentMode == ThemeMode.dark,
          onTap: () => onChanged(ThemeMode.dark),
          textColor: textColor,
          showDivider: false,
          border: border,
        ),
      ],
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.textColor,
    required this.showDivider,
    required this.border,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color textColor;
  final bool showDivider;
  final Color border;

  @override
  Widget build(BuildContext context) {
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
                  Icon(icon, size: 20, color: AppColors.primary),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      label,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: textColor,
                      ),
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      LucideIcons.check,
                      size: 20,
                      color: AppColors.primary,
                    ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider) Divider(height: 1, color: border, indent: 50),
      ],
    );
  }
}
