import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../features/subscription/presentation/providers/subscription_provider.dart';
import '../../features/subscription/presentation/screens/paywall_screen.dart';
import 'pro_badge.dart';

/// Wraps content that requires Pro. Shows a locked overlay for free users.
class PaywallGate extends ConsumerWidget {
  const PaywallGate({
    super.key,
    required this.child,
    this.label = 'Pro ozelligi',
  });

  /// The pro-only content.
  final Widget child;

  /// Label shown on the lock overlay.
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPro = ref.watch(isProProvider);
    if (isPro) return child;

    return GestureDetector(
      onTap: () => _showPaywall(context),
      child: Stack(
        children: [
          // Blurred child
          IgnorePointer(
            child: Opacity(opacity: 0.3, child: child),
          ),
          // Lock overlay
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      LucideIcons.lock,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const ProBadge(size: ProBadgeSize.medium),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPaywall(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<bool>(
        fullscreenDialog: true,
        builder: (_) => const PaywallScreen(),
      ),
    );
  }
}
