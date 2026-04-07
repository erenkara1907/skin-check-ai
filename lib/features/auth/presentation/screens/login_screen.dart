import 'package:flutter/material.dart';

import '../../../../shared/widgets/gradient_background.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Placeholder login screen.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Text('Login', style: AppTextStyles.displaySmall),
        ),
      ),
    );
  }
}
