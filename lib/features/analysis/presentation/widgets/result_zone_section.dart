import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/zone_score_entity.dart';
import 'face_zone_map.dart';
import 'zone_detail_sheet.dart';

/// Zone analysis section of the result screen.
class ResultZoneSection extends StatelessWidget {
  const ResultZoneSection({super.key, required this.zones});

  /// Zone scores to display.
  final List<ZoneScoreEntity> zones;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bölge Analizi',
          style: AppTextStyles.headlineSmall.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
        const SizedBox(height: 16),
        Center(
          child: FaceZoneMap(
            zones: zones,
            onZoneTap: (zone) =>
                ZoneDetailSheet.show(context, zone),
          ),
        ).animate().fadeIn(delay: 700.ms, duration: 500.ms),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'Detaylar için bölgelere dokunun',
            style: AppTextStyles.labelSmall.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.5),
            ),
          ),
        ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
      ],
    );
  }
}
