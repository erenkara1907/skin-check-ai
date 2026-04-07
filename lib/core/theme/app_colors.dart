import 'package:flutter/material.dart';

/// Centralized color constants for SkinCheck AI.
abstract final class AppColors {
  // Brand
  static const primary = Color(0xFF6C63FF);
  static const primaryLight = Color(0xFF9D97FF);
  static const primaryDark = Color(0xFF4A42DB);
  static const secondary = Color(0xFF00D9A6);
  static const secondaryLight = Color(0xFF5EEFC8);
  static const secondaryDark = Color(0xFF00B88A);

  // Neutral — Light
  static const backgroundLight = Color(0xFFF8F9FE);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const textPrimaryLight = Color(0xFF1A1D2E);
  static const textSecondaryLight = Color(0xFF6B7088);
  static const borderLight = Color(0xFFE8E9F0);

  // Neutral — Dark
  static const backgroundDark = Color(0xFF0F1117);
  static const surfaceDark = Color(0xFF1A1D2E);
  static const textPrimaryDark = Color(0xFFF0F1F5);
  static const textSecondaryDark = Color(0xFF9399B2);
  static const borderDark = Color(0xFF2A2D3E);

  // Semantic
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFFBBF24);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);

  // Score colors
  static const scoreLow = Color(0xFFEF4444);
  static const scoreMedium = Color(0xFFFBBF24);
  static const scoreHigh = Color(0xFF22C55E);

  // Glassmorphism
  static const glassLight = Color(0x80FFFFFF);
  static const glassDark = Color(0x33FFFFFF);
  static const glassBorderLight = Color(0x40FFFFFF);
  static const glassBorderDark = Color(0x1AFFFFFF);

  /// Returns score color based on value: red <40, yellow 40-70, green >70.
  static Color scoreColor(double score) {
    if (score < 40) return scoreLow;
    if (score <= 70) return scoreMedium;
    return scoreHigh;
  }
}
