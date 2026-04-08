import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../../shared/widgets/score_circle.dart';
import '../../../sharing/domain/entities/share_card_data.dart';
import '../../../sharing/presentation/providers/share_card_provider.dart';
import '../../../sharing/presentation/widgets/share_card.dart';
import '../../../sharing/presentation/widgets/share_options_sheet.dart';
import '../../domain/entities/analysis_entity.dart';
import '../providers/analysis_provider.dart';
import '../../../../shared/widgets/paywall_gate.dart';
import '../widgets/analysis_error_view.dart';
import '../widgets/analysis_loading.dart';
import '../widgets/recommended_products_section.dart';
import '../widgets/result_zone_section.dart';

/// Displays analysis results with animated score reveal.
class AnalysisResultScreen extends ConsumerWidget {
  const AnalysisResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysisState = ref.watch(analysisNotifierProvider);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: analysisState.when(
            loading: () => const AnalysisLoading(),
            error: (e, _) => AnalysisErrorView(
              message: e.toString(),
              onRetry: () => context.pop(),
            ),
            data: (analysis) {
              if (analysis == null) {
                return const AnalysisLoading();
              }
              return _ResultContent(analysis: analysis);
            },
          ),
        ),
      ),
    );
  }
}

class _ResultContent extends ConsumerStatefulWidget {
  const _ResultContent({required this.analysis});

  final AnalysisEntity analysis;

  @override
  ConsumerState<_ResultContent> createState() => _ResultContentState();
}

class _ResultContentState extends ConsumerState<_ResultContent> {
  final _shareCardKey = GlobalKey();

  Future<void> _onShare() async {
    final destination = await ShareOptionsSheet.show(context);
    if (destination == null || !mounted) return;

    await ref.read(shareCardNotifierProvider.notifier).captureAndShare(
          _shareCardKey,
          destination,
        );
  }

  @override
  Widget build(BuildContext context) {
    final analysis = widget.analysis;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Hidden off-screen share card for capture
    final shareCardData = ShareCardData(
      overallScore: analysis.overallScore,
      skinAge: analysis.skinAge,
      zones: analysis.zones,
    );

    return Stack(
      children: [
        // Off-screen share card for RepaintBoundary capture
        Positioned(
          left: -1200,
          child: SizedBox(
            width: 1080,
            height: 1920,
            child: ShareCard(
              data: shareCardData,
              repaintKey: _shareCardKey,
            ),
          ),
        ),
        // Visible content
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Back button
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),

            // Title
            Text(
              'Analiz Sonuçları',
              style: AppTextStyles.headlineLarge.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: -0.2, end: 0),
            const SizedBox(height: 24),

            // Overall score
            Center(
              child: ScoreCircle(
                score: analysis.overallScore,
                size: 160,
                strokeWidth: 14,
                label: 'Genel Skor',
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 500.ms).scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.0, 1.0),
                ),
            const SizedBox(height: 16),

            // Skin age (Pro only)
            PaywallGate(
              label: 'Cilt Yasi',
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
                    'Cilt Yaşın: ${analysis.skinAge}',
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

            // Interactive face zone map (Pro only)
            PaywallGate(
              label: 'Bolge Haritasi',
              child: ResultZoneSection(zones: analysis.zones),
            ),
            const SizedBox(height: 32),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Rutin Oluştur',
                    onPressed: () => context.go('/routine'),
                    variant: AppButtonVariant.primary,
                    icon: LucideIcons.sparkles,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    label: 'Paylaş',
                    onPressed: _onShare,
                    variant: AppButtonVariant.outline,
                    icon: LucideIcons.share2,
                  ),
                ),
              ],
            )
                .animate()
                .fadeIn(delay: 1000.ms, duration: 400.ms)
                .slideY(begin: 0.3, end: 0),
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
