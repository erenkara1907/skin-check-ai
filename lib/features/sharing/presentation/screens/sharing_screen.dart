import 'package:flutter/material.dart';

import '../../../../shared/widgets/gradient_background.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Placeholder sharing screen.
class SharingScreen extends StatelessWidget {
  const SharingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Text('Sharing', style: AppTextStyles.displaySmall),
        ),
      ),
    );
  }
}
