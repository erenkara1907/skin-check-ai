import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/concern_timeline_entity.dart';

/// Direction a single concern is trending.
enum TrendDirection {
  improving,
  worsening,
  stable,
  firstMeasurement,
}

/// Computed per-concern summary used by [ConcernTrendCard].
///
/// Collapses the raw timeline points for one concern into: the latest
/// severity, the change vs. the first measurement, and a sparkline.
/// Keeping this pure data class lets the card be a simple stateless
/// renderer and makes the math unit-testable.
class ConcernTrendData {
  const ConcernTrendData({
    required this.concern,
    required this.color,
    required this.currentSeverity,
    required this.firstSeverity,
    required this.changePercent,
    required this.direction,
    required this.sparklineSpots,
  });

  final String concern;
  final Color color;

  /// Latest severity value on a 0–10 scale (averaged if multiple on
  /// the same day).
  final double currentSeverity;

  /// Earliest severity value, used as the baseline.
  final double firstSeverity;

  /// Percent change from [firstSeverity] to [currentSeverity].
  /// Negative = improving (severity down), positive = worsening.
  final int changePercent;

  final TrendDirection direction;

  /// Sparkline points. X = date millis, Y = avg severity on that day.
  final List<FlSpot> sparklineSpots;

  /// Stable threshold: change within ±5% counts as "no change".
  static const _stableThreshold = 5;

  /// Collapses raw [timeline] rows into one [ConcernTrendData] per
  /// distinct concern. Returns cards sorted so the most-improved
  /// concerns appear first and worsening ones last — users reading
  /// top-to-bottom immediately see wins before regressions.
  static List<ConcernTrendData> fromTimeline(
    List<ConcernTimelineEntity> timeline,
  ) {
    if (timeline.isEmpty) return const [];

    final byConcern = <String, List<ConcernTimelineEntity>>{};
    for (final row in timeline) {
      byConcern.putIfAbsent(row.concern, () => []).add(row);
    }

    final cards = <ConcernTrendData>[];
    for (final entry in byConcern.entries) {
      final rows = entry.value..sort((a, b) => a.date.compareTo(b.date));

      // Average severity per day so two measurements the same day
      // don't create a zig-zag.
      final byDate = <DateTime, List<int>>{};
      for (final row in rows) {
        final day = DateTime(row.date.year, row.date.month, row.date.day);
        byDate.putIfAbsent(day, () => []).add(row.severity);
      }
      final dailyPoints = byDate.entries
          .map((e) {
            final avg = e.value.reduce((a, b) => a + b) / e.value.length;
            return MapEntry(e.key, avg);
          })
          .toList()
        ..sort((a, b) => a.key.compareTo(b.key));

      if (dailyPoints.isEmpty) continue;

      final first = dailyPoints.first.value;
      final current = dailyPoints.last.value;

      final TrendDirection direction;
      final int percent;
      if (dailyPoints.length == 1) {
        direction = TrendDirection.firstMeasurement;
        percent = 0;
      } else if (first == 0) {
        // Baseline was "none" — any increase is worsening, equal is stable.
        if (current == 0) {
          direction = TrendDirection.stable;
          percent = 0;
        } else {
          direction = TrendDirection.worsening;
          percent = 100;
        }
      } else {
        final raw = ((current - first) / first) * 100;
        final rounded = raw.round();
        if (rounded.abs() <= _stableThreshold) {
          direction = TrendDirection.stable;
          percent = 0;
        } else if (rounded < 0) {
          direction = TrendDirection.improving;
          percent = rounded; // negative
        } else {
          direction = TrendDirection.worsening;
          percent = rounded; // positive
        }
      }

      final spots = dailyPoints
          .map((e) =>
              FlSpot(e.key.millisecondsSinceEpoch.toDouble(), e.value))
          .toList();

      cards.add(ConcernTrendData(
        concern: entry.key,
        color: _colorFor(entry.key),
        currentSeverity: current,
        firstSeverity: first,
        changePercent: percent,
        direction: direction,
        sparklineSpots: spots,
      ));
    }

    // Sort: improving first (biggest improvement), then stable, then
    // worsening (worst last).
    cards.sort((a, b) {
      int rank(TrendDirection d) {
        switch (d) {
          case TrendDirection.improving:
            return 0;
          case TrendDirection.stable:
          case TrendDirection.firstMeasurement:
            return 1;
          case TrendDirection.worsening:
            return 2;
        }
      }

      final cmp = rank(a.direction).compareTo(rank(b.direction));
      if (cmp != 0) return cmp;
      // Within improving: bigger improvement first (more negative percent).
      // Within worsening: worst first (bigger positive percent).
      if (a.direction == TrendDirection.improving) {
        return a.changePercent.compareTo(b.changePercent);
      }
      if (a.direction == TrendDirection.worsening) {
        return b.changePercent.compareTo(a.changePercent);
      }
      return a.concern.compareTo(b.concern);
    });

    return cards;
  }

  static Color _colorFor(String concern) {
    const colors = {
      'dryness': Color(0xFFE8A838),
      'acne': Color(0xFFE84855),
      'wrinkles': Color(0xFF6C63FF),
      'oiliness': Color(0xFF4CAF50),
      'spots': Color(0xFFFF9800),
      'pores': Color(0xFF9C27B0),
      'redness': Color(0xFFF44336),
      'dark circles': Color(0xFF795548),
      'sensitivity': Color(0xFFE91E63),
      'texture': Color(0xFF00BCD4),
    };
    return colors[concern.toLowerCase()] ?? AppColors.primary;
  }
}
