import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/supabase_service.dart';
import '../../data/datasources/progress_datasource.dart';
import '../../data/repositories/progress_repository_impl.dart';
import '../../domain/entities/concern_timeline_entity.dart';
import '../../domain/entities/photo_comparison_entity.dart';
import '../../domain/entities/progress_summary_entity.dart';
import '../../domain/entities/score_trend_entity.dart';
import '../../domain/entities/zone_progress_entity.dart';
import '../../domain/repositories/progress_repository.dart';

part 'progress_provider.g.dart';

/// Provides the [ProgressRepository] instance.
@Riverpod(keepAlive: true)
ProgressRepository progressRepository(Ref ref) {
  return ProgressRepositoryImpl(
    ProgressDataSource(SupabaseService.client),
  );
}

/// Loads the progress dashboard summary.
@riverpod
class ProgressSummaryNotifier extends _$ProgressSummaryNotifier {
  @override
  FutureOr<ProgressSummaryEntity> build(String userId) async {
    final repo = ref.read(progressRepositoryProvider);
    return repo.getProgressSummary(userId);
  }

  /// Refresh summary data.
  Future<void> refresh(String userId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(progressRepositoryProvider);
      return repo.getProgressSummary(userId);
    });
  }
}

/// Loads score trend data for the chart.
@riverpod
class ScoreTrendNotifier extends _$ScoreTrendNotifier {
  @override
  FutureOr<List<ScoreTrendEntity>> build(String userId) async {
    final repo = ref.read(progressRepositoryProvider);
    return repo.getScoreTrend(userId);
  }
}

/// Loads zone-by-zone progress data.
@riverpod
class ZoneProgressNotifier extends _$ZoneProgressNotifier {
  @override
  FutureOr<List<ZoneProgressEntity>> build(String userId) async {
    final repo = ref.read(progressRepositoryProvider);
    return repo.getZoneProgress(userId);
  }
}

/// Loads photo comparison data.
@riverpod
class PhotoComparisonNotifier extends _$PhotoComparisonNotifier {
  @override
  FutureOr<PhotoComparisonEntity> build(String userId) async {
    final repo = ref.read(progressRepositoryProvider);
    return repo.getPhotoComparison(userId);
  }
}

/// Loads concern severity timeline across all analyses.
@riverpod
class ConcernTimelineNotifier extends _$ConcernTimelineNotifier {
  @override
  FutureOr<List<ConcernTimelineEntity>> build(String userId) async {
    final repo = ref.read(progressRepositoryProvider);
    return repo.getConcernTimeline(userId);
  }
}
