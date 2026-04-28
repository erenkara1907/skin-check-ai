import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Circular countdown timer with play/pause for guided routine.
class GuidedTimer extends StatefulWidget {
  const GuidedTimer({
    super.key,
    required this.durationSeconds,
    required this.elapsedSeconds,
    required this.isRunning,
    required this.onTick,
    required this.onToggle,
  });

  final int durationSeconds;
  final int elapsedSeconds;
  final bool isRunning;
  final VoidCallback onTick;
  final VoidCallback onToggle;

  @override
  State<GuidedTimer> createState() => _GuidedTimerState();
}

class _GuidedTimerState extends State<GuidedTimer> {
  Timer? _timer;

  @override
  void didUpdateWidget(GuidedTimer old) {
    super.didUpdateWidget(old);
    if (widget.isRunning && !old.isRunning) {
      _startTimer();
    } else if (!widget.isRunning && old.isRunning) {
      _stopTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => widget.onTick(),
    );
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remaining = (widget.durationSeconds - widget.elapsedSeconds)
        .clamp(0, widget.durationSeconds);
    final minutes = remaining ~/ 60;
    final seconds = remaining % 60;
    final progress = widget.durationSeconds > 0
        ? widget.elapsedSeconds / widget.durationSeconds
        : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Progress ring
              CustomPaint(
                size: const Size(120, 120),
                painter: _TimerPainter(
                  progress: progress.clamp(0.0, 1.0),
                  isDark:
                      Theme.of(context).brightness == Brightness.dark,
                ),
              ),
              // Time display
              Text(
                '${minutes.toString().padLeft(2, '0')}:'
                '${seconds.toString().padLeft(2, '0')}',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Play/pause button
        GestureDetector(
          onTap: widget.onToggle,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              widget.isRunning ? LucideIcons.pause : LucideIcons.play,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}

class _TimerPainter extends CustomPainter {
  _TimerPainter({required this.progress, required this.isDark});

  final double progress;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;

    // Background ring
    final bgPaint = Paint()
      ..color = isDark ? AppColors.borderDark : AppColors.borderLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [AppColors.primary, AppColors.secondary],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_TimerPainter old) => old.progress != progress;
}
