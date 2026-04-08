import 'package:flutter/material.dart';

import '../../core/theme/app_text_styles.dart';

/// Small golden "PRO" badge for premium features.
class ProBadge extends StatelessWidget {
  const ProBadge({super.key, this.size = ProBadgeSize.small});

  /// Badge size variant.
  final ProBadgeSize size;

  @override
  Widget build(BuildContext context) {
    final (fontSize, hPad, vPad) = switch (size) {
      ProBadgeSize.small => (9.0, 6.0, 2.0),
      ProBadgeSize.medium => (11.0, 8.0, 3.0),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'PRO',
        style: AppTextStyles.labelSmall.copyWith(
          fontSize: fontSize,
          color: Colors.black87,
          fontWeight: FontWeight.w800,
          height: 1,
        ),
      ),
    );
  }
}

/// Size variant for [ProBadge].
enum ProBadgeSize { small, medium }
