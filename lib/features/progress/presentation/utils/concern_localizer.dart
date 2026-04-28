import 'package:flutter/widgets.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';

/// Maps backend concern keys (English) to localized display names.
///
/// Concern keys come from the AI pipeline in English (e.g. "dryness",
/// "acne") and are stored that way in the database for analytics
/// stability. UI layer translates them via this mapper — not via ARB
/// placeholders, because the key set is closed and a switch is cleaner.
String localizeConcern(BuildContext context, String key) {
  switch (key.toLowerCase()) {
    case 'dryness':
      return context.l10n.concernDryness;
    case 'acne':
      return context.l10n.concernAcne;
    case 'wrinkles':
      return context.l10n.concernWrinkles;
    case 'oiliness':
      return context.l10n.concernOiliness;
    case 'spots':
      return context.l10n.concernSpots;
    case 'pores':
      return context.l10n.concernPores;
    case 'redness':
      return context.l10n.concernRedness;
    case 'dark circles':
    case 'dark_circles':
    case 'darkcircles':
      return context.l10n.concernDarkCircles;
    case 'sensitivity':
      return context.l10n.concernSensitivity;
    case 'texture':
      return context.l10n.concernTexture;
    default:
      if (key.isEmpty) return key;
      return key[0].toUpperCase() + key.substring(1);
  }
}

/// Maps a 0-10 severity value to a localized semantic label.
///
/// Used for the concern timeline Y-axis so users see "Hafif/Orta/Şiddetli"
/// instead of abstract numbers.
String severityLabel(BuildContext context, double value) {
  if (value <= 1) return context.l10n.severityNone;
  if (value <= 4) return context.l10n.severityMild;
  if (value <= 7) return context.l10n.severityModerate;
  return context.l10n.severitySevere;
}

/// Maps a 0-10 severity value to its semantic color zone.
///
/// Mirrors the same green/amber/red gradient users see on score
/// dials elsewhere, so the bars in the concern card read at a glance:
/// short + green = good, long + red = needs attention.
Color severityZoneColor(double value) {
  if (value <= 1) return AppColors.secondary;
  if (value <= 4) return AppColors.success;
  if (value <= 7) return AppColors.warning;
  return AppColors.error;
}
