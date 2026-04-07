import 'package:flutter/material.dart';

import '../../../../shared/widgets/gradient_background.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Placeholder profile screen.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Text('Profile', style: AppTextStyles.displaySmall),
        ),
      ),
    );
  }
}
