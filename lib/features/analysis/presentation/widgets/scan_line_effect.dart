import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Single, calm scan line that drifts gently inside the oval.
///
/// No particles, no comet tail — just a soft hairline with a gentle bloom.
/// Sweeps top-to-bottom in a slow ping-pong.
class ScanLineEffect extends StatefulWidget {
  const ScanLineEffect({super.key, required this.faceDetected});

  final bool faceDetected;

  @override
  State<ScanLineEffect> createState() => _ScanLineEffectState();
}

class _ScanLineEffectState extends State<ScanLineEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );
    if (widget.faceDetected) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(ScanLineEffect old) {
    super.didUpdateWidget(old);
    if (widget.faceDetected && !old.faceDetected) {
      _controller.repeat(reverse: true);
    } else if (!widget.faceDetected && old.faceDetected) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.faceDetected) return const SizedBox.shrink();

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            size: Size.infinite,
            painter: _ScanLinePainter(
              progress: Curves.easeInOut.transform(_controller.value),
            ),
          );
        },
      ),
    );
  }
}

class _ScanLinePainter extends CustomPainter {
  _ScanLinePainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final ovalCenterY = size.height * 0.40;
    final ovalWidth = size.width * 0.68;
    final ovalHeight = ovalWidth * 1.32;
    final ovalTop = ovalCenterY - ovalHeight / 2;

    final scanWidth = ovalWidth * 0.78;
    final scanLeft = (size.width - scanWidth) / 2;
    final scanY = ovalTop + ovalHeight * progress;

    // Clip to oval
    final ovalRect = Rect.fromCenter(
      center: Offset(size.width / 2, ovalCenterY),
      width: ovalWidth,
      height: ovalHeight,
    );
    canvas.save();
    canvas.clipPath(Path()..addOval(ovalRect));

    // Soft bloom
    final bloomRect = Rect.fromLTWH(scanLeft, scanY - 4, scanWidth, 8);
    canvas.drawRect(
      bloomRect,
      Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.secondary.withValues(alpha: 0.45),
            Colors.transparent,
          ],
        ).createShader(bloomRect)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );

    // Core hairline
    final coreRect = Rect.fromLTWH(scanLeft, scanY - 0.4, scanWidth, 0.9);
    canvas.drawRect(
      coreRect,
      Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.secondaryLight.withValues(alpha: 0.85),
            Colors.transparent,
          ],
        ).createShader(coreRect),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(_ScanLinePainter old) => progress != old.progress;
}
