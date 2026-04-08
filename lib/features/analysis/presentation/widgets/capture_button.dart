import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Large round capture button with countdown overlay.
class CaptureButton extends StatelessWidget {
  const CaptureButton({
    super.key,
    required this.onPressed,
    this.enabled = true,
    this.countdown = 0,
  });

  final VoidCallback onPressed;
  final bool enabled;

  /// Current countdown value (3, 2, 1). 0 = no countdown.
  final int countdown;

  @override
  Widget build(BuildContext context) {
    final isCountingDown = countdown > 0;

    return GestureDetector(
      onTap: enabled && !isCountingDown ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled
                ? Colors.white
                : Colors.white.withValues(alpha: 0.3),
            width: 4,
          ),
        ),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isCountingDown ? 80 : 64,
            height: isCountingDown ? 80 : 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCountingDown
                  ? Colors.transparent
                  : (enabled
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.3)),
              gradient: isCountingDown
                  ? const LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    )
                  : null,
            ),
            child: isCountingDown
                ? Center(
                    child: Text(
                      '$countdown',
                      style: AppTextStyles.displaySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
