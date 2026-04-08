import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_text_styles.dart';

/// Greeting header: "Merhaba, [name]!" + formatted date.
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key, required this.name});

  /// User's display name.
  final String? name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayName = (name != null && name!.isNotEmpty) ? name! : 'Kullanici';
    final dateStr = DateFormat('d MMMM yyyy, EEEE').format(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Merhaba, $displayName!',
          style: AppTextStyles.headlineLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          dateStr,
          style: AppTextStyles.bodyMedium.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
