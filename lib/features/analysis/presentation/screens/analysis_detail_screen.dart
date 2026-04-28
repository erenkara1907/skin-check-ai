import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../../shared/widgets/paywall_gate.dart';
import '../../../../shared/widgets/score_circle.dart';
import '../../../sharing/domain/entities/share_card_data.dart';
import '../../../sharing/presentation/providers/share_card_provider.dart';
import '../../../sharing/presentation/widgets/share_card.dart';
import '../../../sharing/presentation/widgets/share_options_sheet.dart';
import '../../domain/entities/analysis_entity.dart';
import '../providers/analysis_provider.dart';
import '../widgets/recommended_products_section.dart';
import '../widgets/result_zone_section.dart';

/// Displays a past analysis with interactive zone map.
class AnalysisDetailScreen extends ConsumerStatefulWidget {
  const AnalysisDetailScreen({super.key, required this.analysisId});

  /// ID of the analysis to display.
  final String analysisId;

  @override
  ConsumerState<AnalysisDetailScreen> createState() =>
      _AnalysisDetailScreenState();
}

class _AnalysisDetailScreenState extends ConsumerState<AnalysisDetailScreen> {
  final _shareCardKey = GlobalKey();

  Future<void> _onShare(AnalysisEntity analysis) async {
    final destination = await ShareOptionsSheet.show(context, ref);
    if (destination == null || !mounted) return;

    await ref.read(shareCardNotifierProvider.notifier).captureAndShare(
          _shareCardKey,
          destination,
        );
  }

  @override
  Widget build(BuildContext context) {
    final asyncAnalysis =
        ref.watch(analysisDetailProvider(widget.analysisId));

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.analysisDetailTitle),
        actions: [
          asyncAnalysis.maybeWhen(
            data: (analysis) => analysis == null
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () => _onShare(analysis),
                    icon: const Icon(LucideIcons.share2),
                    tooltip: context.l10n.shareButton,
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: GradientBackground(
        child: SafeArea(
          child: asyncAnalysis.when(
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Text(context.l10n.errorDisplay(e.toString())),
            ),
            data: (analysis) {
              if (analysis == null) {
                return Center(
                  child: Text(context.l10n.errorDisplay('Not found')),
                );
              }
              return _DetailContent(
                analysis: analysis,
                shareCardKey: _shareCardKey,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({
    required this.analysis,
    required this.shareCardKey,
  });

  final AnalysisEntity analysis;
  final GlobalKey shareCardKey;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final shareData = ShareCardData(
      overallScore: analysis.overallScore,
      skinAge: analysis.skinAge,
      zones: analysis.zones,
    );

    return Stack(
      children: [
        // Off-screen share card
        Positioned(
          left: -1200,
          child: SizedBox(
            width: 1080,
            height: 1920,
            child: ShareCard(data: shareData, repaintKey: shareCardKey),
          ),
        ),
        ListView(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Score
            Center(
              child: ScoreCircle(
                score: analysis.overallScore,
                size: 140,
                strokeWidth: 12,
                label: context.l10n.overallScoreLabel,
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
            const SizedBox(height: 16),

            // Skin age
            PaywallGate(
              label: context.l10n.skinAgeLabel,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.glassDark
                        : AppColors.glassLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? AppColors.glassBorderDark
                          : AppColors.glassBorderLight,
                    ),
                  ),
                  child: Text(
                    context.l10n.skinAgeDisplay(analysis.skinAge),
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
            const SizedBox(height: 12),

            // Summary
            if (analysis.summary.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.glassDark
                      : AppColors.glassLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark
                        ? AppColors.glassBorderDark
                        : AppColors.glassBorderLight,
                  ),
                ),
                child: Text(
                  analysis.summary,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
            const SizedBox(height: 32),

            // Zone map
            PaywallGate(
              label: context.l10n.zoneMapLabel,
              child: ResultZoneSection(zones: analysis.zones),
            ),
            const SizedBox(height: 32),

            // Recommended products
            RecommendedProductsSection(
              concerns: analysis.zones
                  .expand((z) => z.concerns)
                  .toSet()
                  .toList(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ],
    );
  }
}
