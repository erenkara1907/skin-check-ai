import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../subscription/presentation/providers/subscription_provider.dart';
import '../providers/home_provider.dart';
import '../widgets/daily_routine_card.dart';
import '../widgets/first_analysis_card.dart';
import '../widgets/greeting_header.dart';
import '../widgets/last_analysis_card.dart';
import '../widgets/mini_progress_chart.dart';
import '../widgets/weekly_tip_card.dart';

/// Home dashboard screen with cards for analysis, routine, tips, progress.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _onStartAnalysis(BuildContext context, WidgetRef ref) async {
    final canAnalyze = await ref.read(canAnalyzeProvider.future);
    if (!context.mounted) return;
    if (canAnalyze) {
      context.go('${AppRoutes.analyze}/camera');
    } else {
      context.push(AppRoutes.paywall);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider).valueOrNull;
    final userId = ref.watch(authNotifierProvider).valueOrNull?.id;

    if (userId == null) return const SizedBox.shrink();

    final hasAnalysisAsync = ref.watch(hasAnalysisProvider(userId));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: hasAnalysisAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (e, _) => Center(child: Text('Hata: $e')),
            data: (hasAnalysis) => _buildContent(
              context,
              ref,
              userId: userId,
              userName: user?.name,
              hasAnalysis: hasAnalysis,
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
    required bool hasAnalysis,
  }) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(hasAnalysisProvider(userId));
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
          if (!hasAnalysis)
            FirstAnalysisCard(
              onStartAnalysis: () => _onStartAnalysis(context, ref),
            )
          else
            _buildDashboardCards(context, ref, userId),
          const SizedBox(height: 24),
          const WeeklyTipCard(),
          const SizedBox(height: 100), // Bottom nav clearance
        ],
      ),
    );
  }

  Widget _buildDashboardCards(
    BuildContext context,
    WidgetRef ref,
    String userId,
  ) {
    return Column(
      children: [
        // Last analysis card
        ref.watch(latestAnalysisProvider(userId)).when(
              loading: () => const SizedBox(
                height: 120,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => const SizedBox.shrink(),
              data: (analysis) => analysis != null
                  ? LastAnalysisCard(
                      analysis: analysis,
                      onReanalyze: () =>
                          _onStartAnalysis(context, ref),
                    )
                  : const SizedBox.shrink(),
            ),
        const SizedBox(height: 16),

        // Daily routine card
        ref.watch(homeRoutinesProvider(userId)).when(
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

        // Mini progress chart
        ref.watch(homeTrendProvider(userId)).when(
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
