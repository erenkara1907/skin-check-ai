import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../sharing/domain/entities/share_card_data.dart';
import '../../../sharing/presentation/providers/share_card_provider.dart';
import '../../../sharing/presentation/widgets/share_card.dart';
import '../../../sharing/presentation/widgets/share_options_sheet.dart';
import '../../../analysis/presentation/providers/analysis_provider.dart';
import '../providers/progress_provider.dart';
import '../widgets/analysis_history_list.dart';
import '../widgets/metric_cards_row.dart';
import '../widgets/most_improved_badge.dart';
import '../widgets/photo_comparison_slider.dart';
import '../widgets/progress_empty_state.dart';
import '../widgets/score_trend_chart.dart';
import '../widgets/second_analysis_info_card.dart';
import '../../../../shared/widgets/paywall_gate.dart';
import '../widgets/concern_timeline_chart.dart';
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

class _ProgressBody extends ConsumerStatefulWidget {
  const _ProgressBody({required this.userId});

  final String userId;

  @override
  ConsumerState<_ProgressBody> createState() => _ProgressBodyState();
}

class _ProgressBodyState extends ConsumerState<_ProgressBody> {
  final _shareCardKey = GlobalKey();

  Future<void> _onShare(double score, int skinAge) async {
    final destination = await ShareOptionsSheet.show(context, ref);
    if (destination == null || !mounted) return;

    await ref.read(shareCardNotifierProvider.notifier).captureAndShare(
          _shareCardKey,
          destination,
        );
  }

  @override
  Widget build(BuildContext context) {
    final userId = widget.userId;

    // Watch all providers at top level so Riverpod loads them in parallel
    final summaryAsync =
        ref.watch(progressSummaryNotifierProvider(userId));
    final trendAsync =
        ref.watch(scoreTrendNotifierProvider(userId));
    final zonesAsync =
        ref.watch(zoneProgressNotifierProvider(userId));
    final photosAsync =
        ref.watch(photoComparisonNotifierProvider(userId));
    final historyAsync =
        ref.watch(analysisHistoryProvider(userId));

    return summaryAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, _) => Center(
        child: Text(context.l10n.errorDisplay(e.toString())),
      ),
      data: (summary) {
        if (summary.totalAnalyses == 0) {
          return const ProgressEmptyState();
        }

        final shareData = ShareCardData(
          overallScore: summary.currentScore,
          skinAge: summary.skinAge,
          label: context.l10n.weeklyProgress,
        );

        return Stack(
          children: [
            // Off-screen share card for capture
            Positioned(
              left: -1200,
              child: SizedBox(
                width: 1080,
                height: 1920,
                child: ShareCard(
                  data: shareData,
                  repaintKey: _shareCardKey,
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(
                  progressSummaryNotifierProvider(userId),
                );
                ref.invalidate(
                  scoreTrendNotifierProvider(userId),
                );
                ref.invalidate(
                  zoneProgressNotifierProvider(userId),
                );
                ref.invalidate(
                  photoComparisonNotifierProvider(userId),
                );
                ref.invalidate(
                  analysisHistoryProvider(userId),
                );
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.progressTitle,
                        style: AppTextStyles.displaySmall,
                      ),
                      AppButton(
                        label: context.l10n.shareButton,
                        onPressed: () => _onShare(
                          summary.currentScore,
                          summary.skinAge,
                        ),
                        variant: AppButtonVariant.outline,
                        icon: LucideIcons.share2,
                        fullWidth: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  MetricCardsRow(summary: summary),
                  const SizedBox(height: 16),
                  // Info card when only 1 analysis
                  if (summary.totalAnalyses == 1) ...[
                    const SecondAnalysisInfoCard(),
                    const SizedBox(height: 16),
                  ],
                  // Score trend chart
                  trendAsync.when(
                    loading: () => const SizedBox(
                      height: 240,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (trend) =>
                        ScoreTrendChart(data: trend),
                  ),
                  const SizedBox(height: 12),
                  // Most improved badge
                  if (summary.mostImprovedZone != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 16),
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
                    data: (photos) => PhotoComparisonSlider(
                      comparison: photos,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Zone progress
                  zonesAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (zones) =>
                        ZoneProgressList(zones: zones),
                  ),
                  const SizedBox(height: 16),
                  // Concern timeline (Pro only)
                  PaywallGate(
                    label: context.l10n.concernTimelineTitle,
                    child: ConcernTimelineChart(userId: userId),
                  ),
                  const SizedBox(height: 16),
                  // Past analyses
                  historyAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (history) =>
                        AnalysisHistoryList(analyses: history),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
