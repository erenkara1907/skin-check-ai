import 'package:flutter/material.dart';

import '../../../analysis/domain/entities/zone_score_entity.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Simplified mini face zone map for share cards.
class MiniFaceMap extends StatelessWidget {
  const MiniFaceMap({
    super.key,
    required this.zones,
    this.size = 140,
  });

  /// Zone scores to display.
  final List<ZoneScoreEntity> zones;

  /// Overall widget size.
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.2,
      child: CustomPaint(
        painter: _FaceOutlinePainter(),
        child: Stack(
          children: zones.map((z) => _buildZoneDot(z)).toList(),
        ),
      ),
    );
  }

  Widget _buildZoneDot(ZoneScoreEntity zone) {
    final pos = _zonePosition(zone.zone);
    final color = AppColors.scoreColor(zone.score);

    return Positioned(
      left: pos.dx * size - 10,
      top: pos.dy * size * 1.2 - 10,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: Center(
          child: Text(
            zone.score.round().toString(),
            style: AppTextStyles.labelSmall.copyWith(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  /// Normalized positions for each zone (0-1 range).
  Offset _zonePosition(String zone) {
    return switch (zone) {
      'forehead' => const Offset(0.5, 0.15),
      'left_cheek' => const Offset(0.25, 0.45),
      'right_cheek' => const Offset(0.75, 0.45),
      'nose' => const Offset(0.5, 0.42),
      'chin' => const Offset(0.5, 0.72),
      'under_eyes' => const Offset(0.5, 0.32),
      'jawline' => const Offset(0.5, 0.62),
      _ => const Offset(0.5, 0.5),
    };
  }
}

class _FaceOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final cx = size.width / 2;
    final ry = size.height * 0.4;
    final rx = size.width * 0.38;

    // Simple face oval
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, size.height * 0.42),
        width: rx * 2,
        height: ry * 2,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
