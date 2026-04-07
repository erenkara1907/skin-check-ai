import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Animated dot indicator for onboarding pages.
class OnboardingDotIndicator extends StatelessWidget {
  const OnboardingDotIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  /// Currently active page index.
  final int currentPage;

  /// Total number of pages.
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isActive
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.25),
          ),
        );
      }),
    );
  }
}
