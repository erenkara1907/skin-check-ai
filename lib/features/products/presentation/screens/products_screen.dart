import 'package:flutter/material.dart';

import '../../../../shared/widgets/gradient_background.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Placeholder products screen.
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Text('Products', style: AppTextStyles.displaySmall),
        ),
      ),
    );
  }
}
