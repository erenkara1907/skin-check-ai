import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/skin_zone.dart';
import '../../domain/entities/zone_score_entity.dart';

/// Interactive face silhouette with 7 tappable zones.
class FaceZoneMap extends StatelessWidget {
  const FaceZoneMap({
    super.key,
    required this.zones,
    required this.onZoneTap,
  });

  final List<ZoneScoreEntity> zones;
  final ValueChanged<ZoneScoreEntity> onZoneTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 360,
      child: CustomPaint(
        painter: _FaceSilhouettePainter(
          brightness: Theme.of(context).brightness,
        ),
        child: Stack(children: _buildZoneButtons()),
      ),
    );
  }

  List<Widget> _buildZoneButtons() {
    final zonePositions = <String, _ZonePosition>{
      'forehead': _ZonePosition(0.5, 0.12, 100, 44),
      'left_cheek': _ZonePosition(0.22, 0.45, 60, 70),
      'right_cheek': _ZonePosition(0.78, 0.45, 60, 70),
      'nose': _ZonePosition(0.5, 0.42, 44, 56),
      'chin': _ZonePosition(0.5, 0.78, 70, 44),
      'under_eyes': _ZonePosition(0.5, 0.3, 110, 34),
      'jawline': _ZonePosition(0.5, 0.65, 130, 36),
    };

    return zones.map((zone) {
      final pos = zonePositions[zone.zone];
      if (pos == null) return const SizedBox.shrink();

      final color = AppColors.scoreColor(zone.score);

      return Positioned(
        left: (280 * pos.cx) - (pos.w / 2),
        top: (360 * pos.cy) - (pos.h / 2),
        child: GestureDetector(
          onTap: () => onZoneTap(zone),
          child: Container(
            width: pos.w,
            height: pos.h,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(pos.h / 2),
              border: Border.all(
                color: color.withValues(alpha: 0.6),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                '${zone.score.round()}',
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}

class _ZonePosition {
  const _ZonePosition(this.cx, this.cy, this.w, this.h);
  final double cx, cy, w, h;
}

class _FaceSilhouettePainter extends CustomPainter {
  _FaceSilhouettePainter({required this.brightness});

  final Brightness brightness;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;

    final paint = Paint()
      ..color = brightness == Brightness.dark
          ? Colors.white.withValues(alpha: 0.08)
          : Colors.black.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = brightness == Brightness.dark
          ? Colors.white.withValues(alpha: 0.15)
          : Colors.black.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Face oval
    final faceRect = Rect.fromCenter(
      center: Offset(cx, h * 0.45),
      width: w * 0.72,
      height: h * 0.85,
    );

    canvas.drawOval(faceRect, paint);
    canvas.drawOval(faceRect, borderPaint);
  }

  @override
  bool shouldRepaint(_FaceSilhouettePainter old) =>
      brightness != old.brightness;
}

/// Helper to find a [ZoneScoreEntity] by zone name.
ZoneScoreEntity? findZone(List<ZoneScoreEntity> zones, SkinZone zone) {
  try {
    return zones.firstWhere((z) => z.zone == zone.value);
  } catch (_) {
    return null;
  }
}
