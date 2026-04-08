import 'package:flutter/material.dart';

/// Full-screen overlay with an oval cutout for face alignment.
class FaceOvalOverlay extends StatelessWidget {
  const FaceOvalOverlay({super.key, this.faceDetected = false});

  /// Whether a face is currently detected inside the oval.
  final bool faceDetected;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: _OvalCutoutPainter(faceDetected: faceDetected),
      ),
    );
  }
}

class _OvalCutoutPainter extends CustomPainter {
  _OvalCutoutPainter({required this.faceDetected});

  final bool faceDetected;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.38);
    final ovalWidth = size.width * 0.65;
    final ovalHeight = ovalWidth * 1.35;

    final ovalRect = Rect.fromCenter(
      center: center,
      width: ovalWidth,
      height: ovalHeight,
    );

    // Dark overlay with oval cutout
    final overlayPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(ovalRect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(
      overlayPath,
      Paint()..color = Colors.black.withValues(alpha: 0.6),
    );

    // Oval border
    final borderColor = faceDetected
        ? const Color(0xFF00D9A6) // secondary green
        : Colors.white.withValues(alpha: 0.6);

    canvas.drawOval(
      ovalRect,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );
  }

  @override
  bool shouldRepaint(_OvalCutoutPainter old) =>
      faceDetected != old.faceDetected;
}
