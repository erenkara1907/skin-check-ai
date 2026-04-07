import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

/// Animated logo header for auth screens.
class AuthLogoHeader extends StatelessWidget {
  const AuthLogoHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.gradientColors = const [AppColors.primary, AppColors.secondary],
    this.glowColor,
  });

  /// Icon displayed in the logo circle.
  final IconData icon;

  /// Title text below the logo.
  final String title;

  /// Subtitle text below the title.
  final String subtitle;

  /// Gradient colors for the logo background.
  final List<Color> gradientColors;

  /// Shadow/glow color. Defaults to first gradient color.
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final glow = glowColor ?? gradientColors.first;

    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradientColors),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: glow.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 36),
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOut),
        const SizedBox(height: 16),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
      ],
    );
  }
}
