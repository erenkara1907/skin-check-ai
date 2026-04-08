import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/progress_provider.dart';
import '../widgets/metric_cards_row.dart';
import '../widgets/most_improved_badge.dart';
import '../widgets/photo_comparison_slider.dart';
import '../widgets/progress_empty_state.dart';
import '../widgets/score_trend_chart.dart';
import '../widgets/zone_progress_list.dart';

/// Main progress dashboard screen.
class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider).valueOrNull;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: user == null
              ? const ProgressEmptyState()
              : _ProgressBody(userId: user.id),
        ),
      ),
    );
  }
}

class _ProgressBody extends ConsumerWidget {
  const _ProgressBody({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync =
        ref.watch(progressSummaryNotifierProvider(userId));

    return summaryAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, _) => Center(
        child: Text('Bir hata olustu: $e'),
      ),
      data: (summary) {
        if (summary.totalAnalyses == 0) {
          return const ProgressEmptyState();
        }

        final trendAsync =
            ref.watch(scoreTrendNotifierProvider(userId));
        final zonesAsync =
            ref.watch(zoneProgressNotifierProvider(userId));
        final photosAsync =
            ref.watch(photoComparisonNotifierProvider(userId));

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(
              progressSummaryNotifierProvider(userId),
            );
            ref.invalidate(scoreTrendNotifierProvider(userId));
            ref.invalidate(zoneProgressNotifierProvider(userId));
            ref.invalidate(
              photoComparisonNotifierProvider(userId),
            );
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Ilerleme',
                style: AppTextStyles.displaySmall,
              ),
              const SizedBox(height: 16),
              MetricCardsRow(summary: summary),
              const SizedBox(height: 16),
              // Score trend chart
              trendAsync.when(
                loading: () => const SizedBox(
                  height: 240,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (_, __) => const SizedBox.shrink(),
                data: (trend) => ScoreTrendChart(data: trend),
              ),
              const SizedBox(height: 12),
              // Most improved badge
              if (summary.mostImprovedZone != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MostImprovedBadge(
                    zoneName: summary.mostImprovedZone!,
                    changePercent:
                        summary.mostImprovedZoneChange,
                  ),
                ),
              // Photo comparison
              photosAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (photos) =>
                    PhotoComparisonSlider(comparison: photos),
              ),
              const SizedBox(height: 16),
              // Zone progress
              zonesAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (zones) => ZoneProgressList(zones: zones),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
