import 'package:flutter/material.dart';

import '../../domain/entities/progress_summary_entity.dart';
import 'metric_card.dart';

/// Horizontal row of three metric cards.
class MetricCardsRow extends StatelessWidget {
  const MetricCardsRow({super.key, required this.summary});

  /// Dashboard summary data.
  final ProgressSummaryEntity summary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MetricCard.score(summary.currentScore),
        const SizedBox(width: 12),
        MetricCard.skinAge(summary.skinAge),
        const SizedBox(width: 12),
        MetricCard.totalAnalyses(summary.totalAnalyses),
      ],
    );
  }
}
