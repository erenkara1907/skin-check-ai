import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Share destination options.
enum ShareDestination { instagram, whatsapp, other }

/// Bottom sheet with share destination options.
class ShareOptionsSheet extends StatelessWidget {
  const ShareOptionsSheet({
    super.key,
    required this.onSelected,
  });

  /// Callback when a destination is selected.
  final ValueChanged<ShareDestination> onSelected;

  /// Shows the share options bottom sheet.
  static Future<ShareDestination?> show(BuildContext context) {
    return showModalBottomSheet<ShareDestination>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => ShareOptionsSheet(
        onSelected: (dest) => Navigator.of(context).pop(dest),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.borderDark
                      : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Paylas',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ShareOption(
                    icon: LucideIcons.instagram,
                    label: 'Instagram',
                    color: const Color(0xFFE1306C),
                    onTap: () => onSelected(ShareDestination.instagram),
                  ),
                  _ShareOption(
                    icon: LucideIcons.messageCircle,
                    label: 'WhatsApp',
                    color: const Color(0xFF25D366),
                    onTap: () => onSelected(ShareDestination.whatsapp),
                  ),
                  _ShareOption(
                    icon: LucideIcons.share2,
                    label: 'Diger',
                    color: AppColors.primary,
                    onTap: () => onSelected(ShareDestination.other),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShareOption extends StatelessWidget {
  const _ShareOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
