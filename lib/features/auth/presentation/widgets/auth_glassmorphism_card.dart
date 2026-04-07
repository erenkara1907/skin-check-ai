import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Glassmorphism card used on auth screens.
class AuthGlassmorphismCard extends StatelessWidget {
  const AuthGlassmorphismCard({super.key, required this.child});

  /// Card content.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.glassDark : AppColors.glassLight,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark
                  ? AppColors.glassBorderDark
                  : AppColors.glassBorderLight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: isDark ? 0.2 : 0.06),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: child,
        ),
      ),
    );
  }
}
