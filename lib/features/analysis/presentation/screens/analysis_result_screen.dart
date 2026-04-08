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
import '../../domain/entities/analysis_entity.dart';
import '../providers/analysis_provider.dart';
import '../widgets/analysis_error_view.dart';
import '../widgets/analysis_loading.dart';
import '../widgets/face_zone_map.dart';
import '../widgets/zone_detail_sheet.dart';

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

class _ResultContent extends StatelessWidget {
  const _ResultContent({required this.analysis});

  final AnalysisEntity analysis;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView(
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

        // Skin age
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: isDark ? AppColors.glassDark : AppColors.glassLight,
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
        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
        const SizedBox(height: 12),

        // Summary
        if (analysis.summary.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.glassDark : AppColors.glassLight,
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

        // Interactive face zone map
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
            zones: analysis.zones,
            onZoneTap: (zone) => ZoneDetailSheet.show(context, zone),
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
                onPressed: () => context.go('/sharing'),
                variant: AppButtonVariant.outline,
                icon: LucideIcons.share2,
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 1000.ms, duration: 400.ms)
            .slideY(begin: 0.3, end: 0),
        const SizedBox(height: 24),
      ],
    );
  }
}

