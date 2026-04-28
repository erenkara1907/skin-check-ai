import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/errors/analysis_failure.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../routine/presentation/providers/routine_provider.dart';
import '../../../sharing/domain/entities/share_card_data.dart';
import '../../../sharing/presentation/providers/share_card_provider.dart';
import '../../../sharing/presentation/widgets/share_card.dart';
import '../../../sharing/presentation/widgets/share_options_sheet.dart';
import '../../../../core/utils/routine_diff.dart';
import '../../../routine/presentation/widgets/routine_diff_sheet.dart';
import '../../domain/entities/analysis_entity.dart';
import '../../domain/entities/routine_step_entity.dart';
import '../providers/analysis_provider.dart';
import '../../../../shared/widgets/paywall_gate.dart';
import '../widgets/analysis_error_view.dart';
import '../widgets/analysis_loading.dart';
import '../widgets/ambient_orbs.dart';
import '../widgets/recommended_products_section.dart';
import '../widgets/result_score_section.dart';
import '../widgets/result_summary_card.dart';
import '../widgets/result_zone_section.dart';

/// Displays analysis results with animated score reveal.
class AnalysisResultScreen extends ConsumerWidget {
  const AnalysisResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysisState = ref.watch(analysisNotifierProvider);

    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            const AmbientOrbs(),
            SafeArea(
              child: analysisState.when(
                loading: () => const AnalysisLoading(),
                error: (e, _) {
                  final failure = e is AnalysisFailure
                      ? e
                      : UnknownAnalysisFailure(e);
                  return AnalysisErrorView(
                    failure: failure,
                    onRetry: () => ref
                        .read(analysisNotifierProvider.notifier)
                        .retryAnalyze(),
                    onHome: () => context.go(AppRoutes.analyze),
                  );
                },
                data: (analysis) {
                  if (analysis == null) return const AnalysisLoading();
                  return _ResultContent(analysis: analysis);
                },
              ),
            ),
          ],
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
    final destination = await ShareOptionsSheet.show(context, ref);
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

    final shareCardData = ShareCardData(
      overallScore: analysis.overallScore,
      skinAge: analysis.skinAge,
      zones: analysis.zones,
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
              data: shareCardData,
              repaintKey: _shareCardKey,
            ),
          ),
        ),
        // Visible content
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            // Title
            Text(
              context.l10n.analysisResultsTitle,
              style: AppTextStyles.displaySmall.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: -0.1, end: 0),
            const SizedBox(height: 28),

            // Score + skin age (extracted widget with confetti)
            ResultScoreSection(
              overallScore: analysis.overallScore,
              skinAge: analysis.skinAge,
            ),
            const SizedBox(height: 16),

            // Summary
            ResultSummaryCard(summary: analysis.summary),
            const SizedBox(height: 20),

            // Divider
            Center(
              child: Container(
                width: 60,
                height: 0.5,
                color: isDark
                    ? AppColors.glassBorderDark
                    : AppColors.glassBorderLight,
              ),
            ).animate().fadeIn(delay: 700.ms, duration: 400.ms),
            const SizedBox(height: 20),

            // Zone map (Pro only)
            PaywallGate(
              label: context.l10n.zoneMapLabel,
              child: ResultZoneSection(zones: analysis.zones),
            ),
            const SizedBox(height: 40),

            // Action buttons — staggered
            Row(
              children: [
                Expanded(
                  child: _RoutineActionButton(analysis: widget.analysis)
                      .animate()
                      .fadeIn(delay: 1000.ms, duration: 400.ms)
                      .slideY(begin: 0.3, end: 0),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    label: context.l10n.shareButton,
                    onPressed: _onShare,
                    variant: AppButtonVariant.outline,
                    icon: LucideIcons.share2,
                  )
                      .animate()
                      .fadeIn(delay: 1100.ms, duration: 400.ms)
                      .slideY(begin: 0.3, end: 0),
                ),
              ],
            ),
            const SizedBox(height: 40),

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

/// Smart button that shows "Create" or "Update" based on existing routines.
class _RoutineActionButton extends ConsumerWidget {
  const _RoutineActionButton({required this.analysis});

  final AnalysisEntity analysis;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authNotifierProvider).valueOrNull?.id;
    if (userId == null) return const SizedBox.shrink();

    final routines =
        ref.watch(routineNotifierProvider(userId)).valueOrNull ?? [];
    final hasExisting = routines.isNotEmpty;

    return AppButton(
      label: hasExisting
          ? context.l10n.updateRoutineButton
          : context.l10n.createRoutineButton,
      icon: hasExisting ? LucideIcons.refreshCw : LucideIcons.sparkles,
      variant: AppButtonVariant.primary,
      onPressed: () => _onPressed(context, ref, userId, routines),
    );
  }

  Future<void> _onPressed(
    BuildContext context,
    WidgetRef ref,
    String userId,
    List<dynamic> routines,
  ) async {
    if (routines.isEmpty) {
      await ref
          .read(routineNotifierProvider(userId).notifier)
          .createFromAnalysis(analysis);
      if (context.mounted) context.go('/routine');
      return;
    }

    // Compute diffs
    final oldMorning = routines
        .where((r) => r.type == 'morning')
        .expand((r) => r.steps)
        .toList();
    final oldEvening = routines
        .where((r) => r.type == 'evening')
        .expand((r) => r.steps)
        .toList();

    final morningDiff = computeRoutineDiff(
      oldSteps: oldMorning
          .map((s) => RoutineStepEntity(
                step: s.step,
                productType: s.productType,
                reason: s.reason,
              ))
          .toList(),
      newSteps: analysis.morningRoutine,
    );
    final eveningDiff = computeRoutineDiff(
      oldSteps: oldEvening
          .map((s) => RoutineStepEntity(
                step: s.step,
                productType: s.productType,
                reason: s.reason,
              ))
          .toList(),
      newSteps: analysis.eveningRoutine,
    );

    if (!morningDiff.hasChanges && !eveningDiff.hasChanges) {
      if (context.mounted) context.go('/routine');
      return;
    }

    if (!context.mounted) return;
    await RoutineDiffSheet.show(
      context,
      ref,
      morningDiff: morningDiff,
      eveningDiff: eveningDiff,
      onApply: () async {
        await ref
            .read(routineNotifierProvider(userId).notifier)
            .createFromAnalysis(analysis);
        if (context.mounted) context.go('/routine');
      },
      onSkip: () {},
    );
  }
}
