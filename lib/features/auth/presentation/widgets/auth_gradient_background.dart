import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Auth-specific gradient background (diagonal purple → teal).
class AuthGradientBackground extends StatelessWidget {
  const AuthGradientBackground({super.key, required this.child});

  /// The widget below this in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF1A1040),
                  const Color(0xFF0A2A2A),
                  const Color(0xFF0F1117),
                ]
              : [
                  AppColors.primary.withValues(alpha: 0.15),
                  AppColors.secondary.withValues(alpha: 0.1),
                  AppColors.backgroundLight,
                ],
        ),
      ),
      child: child,
    );
  }
}
