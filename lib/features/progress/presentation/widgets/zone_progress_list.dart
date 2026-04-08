import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/entities/zone_progress_entity.dart';
import 'zone_progress_item.dart';

/// Card containing all 7 zone progress bars.
class ZoneProgressList extends StatelessWidget {
  const ZoneProgressList({super.key, required this.zones});

  /// Zone progress data.
  final List<ZoneProgressEntity> zones;

  @override
  Widget build(BuildContext context) {
    if (zones.isEmpty) return const SizedBox.shrink();

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bolge Bazli Ilerleme',
            style: AppTextStyles.titleLarge,
          ),
          const SizedBox(height: 12),
          ...zones.map((z) => ZoneProgressItem(zone: z)),
        ],
      ),
    );
  }
}
