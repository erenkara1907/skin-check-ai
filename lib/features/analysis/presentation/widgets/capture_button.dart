import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Clean, quiet shutter — hairline outer ring + inner disc.
///
/// No tick marks, no bezel, no rotating arcs. A single progress ring
/// fills during countdown, and the inner disc swaps to a soft gradient
/// with the countdown numeral inside.
class CaptureButton extends StatefulWidget {
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
  State<CaptureButton> createState() => _CaptureButtonState();
}

class _CaptureButtonState extends State<CaptureButton> {
  int _prevCountdown = 0;
  bool _pressed = false;

  @override
  void didUpdateWidget(CaptureButton old) {
    super.didUpdateWidget(old);
    if (widget.countdown != _prevCountdown && widget.countdown > 0) {
      HapticFeedback.mediumImpact();
    }
    _prevCountdown = widget.countdown;
  }

  void _onTap() {
    if (!widget.enabled || widget.countdown > 0) return;
    HapticFeedback.heavyImpact();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final isCountingDown = widget.countdown > 0;
    final isReady = widget.enabled && !isCountingDown;

    return SizedBox(
      width: 84,
      height: 84,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer hairline ring with progress arc
          CustomPaint(
            size: const Size(84, 84),
            painter: _RingPainter(
              enabled: isReady,
              countdownActive: isCountingDown,
              progress: isCountingDown
                  ? (3 - widget.countdown + 1) / 3
                  : 0,
            ),
          ),

          // Inner shutter disc
          GestureDetector(
            onTapDown: (_) => setState(() => _pressed = true),
            onTapCancel: () => setState(() => _pressed = false),
            onTapUp: (_) => setState(() => _pressed = false),
            onTap: _onTap,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 140),
              scale: _pressed ? 0.92 : 1.0,
              curve: Curves.easeOutCubic,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                width: isCountingDown ? 64 : 62,
                height: isCountingDown ? 64 : 62,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isCountingDown
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.primary, AppColors.secondary],
                        )
                      : null,
                  color: isCountingDown
                      ? null
                      : (isReady
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.35)),
                ),
                child: isCountingDown
                    ? Center(
                        child: Text(
                          '${widget.countdown}',
                          style: AppTextStyles.displaySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Hairline circle + optional progress arc during countdown.
class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.enabled,
    required this.countdownActive,
    required this.progress,
  });

  final bool enabled;
  final bool countdownActive;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    // Base ring — hairline
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = enabled
            ? Colors.white.withValues(alpha: 0.9)
            : Colors.white.withValues(alpha: 0.30)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );

    // Countdown progress arc
    if (countdownActive) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final paint = Paint()
        ..shader = const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.6
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect,
        -3.14159 / 2,
        2 * 3.14159 * progress,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      enabled != old.enabled ||
      countdownActive != old.countdownActive ||
      progress != old.progress;
}
