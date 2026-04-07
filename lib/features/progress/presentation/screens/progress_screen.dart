import 'package:flutter/material.dart';

import '../../../../shared/widgets/gradient_background.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Placeholder progress screen.
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Text('Progress', style: AppTextStyles.displaySmall),
        ),
      ),
    );
  }
}
