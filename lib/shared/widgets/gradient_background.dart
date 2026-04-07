import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Full-screen gradient background wrapper.
class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});

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
                  AppColors.backgroundDark,
                  const Color(0xFF151830),
                  AppColors.backgroundDark,
                ]
              : [
                  AppColors.backgroundLight,
                  const Color(0xFFEDE9FF),
                  AppColors.backgroundLight,
                ],
        ),
      ),
      child: child,
    );
  }
}
