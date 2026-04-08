import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../analysis/domain/entities/analysis_entity.dart';
import '../../../analysis/presentation/providers/analysis_provider.dart';
import '../../../progress/presentation/providers/progress_provider.dart';
import '../../../routine/domain/entities/routine_entity.dart';
import '../../../routine/presentation/providers/routine_provider.dart';
import '../../../progress/domain/entities/score_trend_entity.dart';

part 'home_provider.g.dart';

/// Provides the latest analysis for the current user.
@riverpod
FutureOr<AnalysisEntity?> latestAnalysis(Ref ref, String userId) async {
  final history = await ref.watch(analysisHistoryProvider(userId).future);
  if (history.isEmpty) return null;
  return history.first;
}

/// Provides today's active routines for the home dashboard.
@riverpod
FutureOr<List<RoutineEntity>> homeRoutines(Ref ref, String userId) async {
  return ref.watch(routineNotifierProvider(userId).future);
}

/// Provides the last 4 weeks of score trend for the mini chart.
@riverpod
FutureOr<List<ScoreTrendEntity>> homeTrend(Ref ref, String userId) async {
  final trend = await ref.watch(scoreTrendNotifierProvider(userId).future);
  // Return last 4 data points max
  if (trend.length <= 4) return trend;
  return trend.sublist(trend.length - 4);
}

/// Whether the current user has any analysis history.
@riverpod
FutureOr<bool> hasAnalysis(Ref ref, String userId) async {
  final history = await ref.watch(analysisHistoryProvider(userId).future);
  return history.isNotEmpty;
}
