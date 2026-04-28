import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/entities/score_trend_entity.dart';

/// Smooth curved line chart showing score trend over time.
class ScoreTrendChart extends StatelessWidget {
  const ScoreTrendChart({super.key, required this.data});

  /// Trend data points ordered by date.
  final List<ScoreTrendEntity> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isUpward = data.length >= 2 &&
        data.last.score >= data.first.score;
    final lineColor = isUpward ? AppColors.success : AppColors.error;
    final gradientColors = [
      lineColor.withValues(alpha: 0.3),
      lineColor.withValues(alpha: 0.0),
    ];

    final spots = data.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.score);
    }).toList();

    final axisTextStyle = AppTextStyles.labelSmall.copyWith(
      color: isDark
          ? AppColors.textSecondaryDark
          : AppColors.textSecondaryLight,
      fontSize: 9,
    );

    return AppCard(
      padding: const EdgeInsets.fromLTRB(8, 20, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 16),
            child: Text(
              context.l10n.scoreLabel,
              style: AppTextStyles.titleLarge,
            ),
          ),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 100,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: (isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight)
                        .withValues(alpha: 0.5),
                    strokeWidth: 0.5,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      interval: 25,
                      getTitlesWidget: (value, meta) => Text(
                        value.toInt().toString(),
                        style: axisTextStyle,
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 24,
                      interval: _bottomInterval,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx < 0 || idx >= data.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            DateFormat('dd/MM', 'tr')
                                .format(data[idx].date),
                            style: axisTextStyle,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (spots) => spots.map((s) {
                      final idx = s.x.toInt();
                      final dateStr = idx < data.length
                          ? DateFormat('dd MMM', 'tr')
                              .format(data[idx].date)
                          : '';
                      return LineTooltipItem(
                        '$dateStr\n${s.y.toStringAsFixed(0)}',
                        AppTextStyles.labelSmall.copyWith(
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness: 0.3,
                    color: lineColor,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: data.length <= 10,
                      getDotPainter: (s, _, __, ___) =>
                          FlDotCirclePainter(
                        radius: 3,
                        color: lineColor,
                        strokeWidth: 1.5,
                        strokeColor: isDark
                            ? AppColors.surfaceDark
                            : AppColors.surfaceLight,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: gradientColors,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double get _bottomInterval {
    if (data.length <= 5) return 1;
    return (data.length / 5).ceilToDouble();
  }
}
