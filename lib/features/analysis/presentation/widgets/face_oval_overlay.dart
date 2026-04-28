import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Minimal viewfinder overlay — just what's needed to frame a face.
///
/// Layers (back → front):
///   1. Soft radial vignette (cinematic edge darkening)
///   2. Oval cutout with dark fill
///   3. Four hairline corner arcs
///   4. Single soft aurora glow (only when face detected)
///
/// No tick marks, rotating rings, or multi-layer chrome — the oval itself
/// is the interface. Calm over busy.
class FaceOvalOverlay extends StatefulWidget {
  const FaceOvalOverlay({super.key, this.faceDetected = false});

  final bool faceDetected;

  @override
  State<FaceOvalOverlay> createState() => _FaceOvalOverlayState();
}

class _FaceOvalOverlayState extends State<FaceOvalOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (context, _) {
          return CustomPaint(
            size: Size.infinite,
            painter: _ViewfinderPainter(
              faceDetected: widget.faceDetected,
              pulse: Curves.easeInOut.transform(_pulse.value),
            ),
          );
        },
      ),
    );
  }
}

class _ViewfinderPainter extends CustomPainter {
  _ViewfinderPainter({
    required this.faceDetected,
    required this.pulse,
  });

  final bool faceDetected;
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.40);
    final ovalWidth = size.width * 0.68;
    final ovalHeight = ovalWidth * 1.32;
    final ovalRect = Rect.fromCenter(
      center: center,
      width: ovalWidth,
      height: ovalHeight,
    );

    _paintVignette(canvas, size, ovalRect);
    _paintCutout(canvas, size, ovalRect);
    if (faceDetected) {
      _paintSoftAura(canvas, ovalRect);
    }
    _paintCornerArcs(canvas, ovalRect);
  }

  void _paintVignette(Canvas canvas, Size size, Rect ovalRect) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = RadialGradient(
      center: Alignment(0, ovalRect.center.dy / size.height * 2 - 1),
      radius: 1.0,
      colors: const [
        Color(0x00000000),
        Color(0x22000000),
        Color(0x66000000),
      ],
      stops: const [0.0, 0.6, 1.0],
    );
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
  }

  void _paintCutout(Canvas canvas, Size size, Rect ovalRect) {
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(ovalRect)
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(
      path,
      Paint()..color = const Color(0xA6000000),
    );
  }

  /// Four slim corner arcs — just enough to suggest a viewfinder.
  void _paintCornerArcs(Canvas canvas, Rect ovalRect) {
    final color = faceDetected
        ? AppColors.secondary.withValues(alpha: 0.95)
        : Colors.white.withValues(alpha: 0.75);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    final rect = ovalRect.inflate(8);
    const sweep = pi / 7; // 25.7° — shorter, more refined

    // Top-left
    canvas.drawArc(rect, pi + pi / 8, sweep, false, paint);
    // Top-right
    canvas.drawArc(rect, -pi / 2 + pi / 22, sweep, false, paint);
    // Bottom-left
    canvas.drawArc(rect, pi / 2 + pi / 22, sweep, false, paint);
    // Bottom-right
    canvas.drawArc(rect, -pi / 8 - sweep + pi / 22, sweep, false, paint);
  }

  /// Single soft aura glow when face detected — warm confirmation, not alarm.
  void _paintSoftAura(Canvas canvas, Rect ovalRect) {
    final alpha = 0.18 + pulse * 0.14;
    canvas.drawOval(
      ovalRect.inflate(22),
      Paint()
        ..color = AppColors.secondary.withValues(alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20),
    );
  }

  @override
  bool shouldRepaint(_ViewfinderPainter old) =>
      faceDetected != old.faceDetected || pulse != old.pulse;
}
