import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../analysis/domain/entities/analysis_entity.dart';
import '../../../analysis/presentation/helpers/start_analysis.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../progress/domain/entities/score_trend_entity.dart';
import '../../../routine/domain/entities/routine_entity.dart';
import '../providers/home_provider.dart';
import '../widgets/daily_routine_card.dart';
import '../widgets/first_analysis_card.dart';
import '../widgets/greeting_header.dart';
import '../widgets/last_analysis_card.dart';
import '../widgets/mini_progress_chart.dart';
import '../../../gamification/presentation/widgets/weekly_summary_card.dart';
import '../widgets/weekly_tip_card.dart';

/// Home dashboard screen with cards for analysis, routine, tips, progress.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _onStartAnalysis(BuildContext context, WidgetRef ref) {
    return startAnalysisFlow(context, ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider).valueOrNull;
    final userId = ref.watch(authNotifierProvider).valueOrNull?.id;

    if (userId == null) return const SizedBox.shrink();

    // Watch all providers at top level so Riverpod loads them in parallel
    final latestAsync = ref.watch(latestAnalysisProvider(userId));
    final routinesAsync = ref.watch(homeRoutinesProvider(userId));
    final trendAsync = ref.watch(homeTrendProvider(userId));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: latestAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (e, _) => Center(child: Text(context.l10n.errorDisplay(e.toString()))),
            data: (latest) => _buildContent(
              context,
              ref,
              userId: userId,
              userName: user?.name,
              latestAnalysis: latest,
              routinesAsync: routinesAsync,
              trendAsync: trendAsync,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref, {
    required String userId,
    required String? userName,
    required AnalysisEntity? latestAnalysis,
    required AsyncValue<List<RoutineEntity>> routinesAsync,
    required AsyncValue<List<ScoreTrendEntity>> trendAsync,
  }) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(latestAnalysisProvider(userId));
        ref.invalidate(homeRoutinesProvider(userId));
        ref.invalidate(homeTrendProvider(userId));
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 16),
          GreetingHeader(name: userName)
              .animate()
              .fadeIn(duration: 400.ms),
          const SizedBox(height: 24),
          if (latestAnalysis == null)
            FirstAnalysisCard(
              onStartAnalysis: () => _onStartAnalysis(context, ref),
            )
          else
            _buildDashboardCards(
              context, ref,
              latestAnalysis: latestAnalysis,
              routinesAsync: routinesAsync,
              trendAsync: trendAsync,
            ),
          const SizedBox(height: 24),
          const WeeklyTipCard(),
          const SizedBox(height: 100), // Bottom nav clearance
        ],
      ),
    );
  }

  Widget _buildDashboardCards(
    BuildContext context,
    WidgetRef ref, {
    required AnalysisEntity latestAnalysis,
    required AsyncValue<List<RoutineEntity>> routinesAsync,
    required AsyncValue<List<ScoreTrendEntity>> trendAsync,
  }) {
    return Column(
      children: [
        // Last analysis card
        LastAnalysisCard(
          analysis: latestAnalysis,
          onReanalyze: () => _onStartAnalysis(context, ref),
          onTap: () => context.push(
            '/progress/detail/${latestAnalysis.id}',
          ),
        ),
        const SizedBox(height: 16),

        // Daily routine card
        routinesAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (routines) => routines.isNotEmpty
              ? DailyRoutineCard(
                  routines: routines,
                  onTap: () => context.go(AppRoutes.routine),
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(height: 16),

        // Weekly summary
        WeeklySummaryCard(userId: latestAnalysis.userId),
        const SizedBox(height: 16),

        // Mini progress chart
        trendAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (trend) => trend.length >= 2
              ? MiniProgressChart(
                  trend: trend,
                  onTap: () => context.go(AppRoutes.progress),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
