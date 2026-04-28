import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Phase-aware dot indicator for onboarding.
///
/// Groups: Setup (0-3), Results (5-6), Completion (7).
/// Loading page (4) is hidden by the parent.
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
    // Map visual dots: skip loading page (index 1) in display
    final displayPages = <int>[];
    for (var i = 0; i < pageCount; i++) {
      if (i != 1) displayPages.add(i);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: displayPages.map((pageIndex) {
        final isActive = pageIndex == currentPage;
        final isPast = pageIndex < currentPage;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3.5),
          width: isActive ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: isActive
                ? const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  )
                : null,
            color: isActive
                ? null
                : isPast
                    ? AppColors.primary.withValues(alpha: 0.45)
                    : AppColors.primary.withValues(alpha: 0.18),
          ),
        );
      }).toList(),
    );
  }
}
