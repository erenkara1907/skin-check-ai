import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/notification_scheduler.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/logger.dart';
import '../../../gamification/presentation/providers/badge_provider.dart';
import '../../data/datasources/analysis_datasource.dart';
import '../../data/repositories/analysis_repository_impl.dart';
import '../../domain/entities/analysis_entity.dart';
import '../../domain/repositories/analysis_repository.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../../progress/presentation/providers/progress_provider.dart';

part 'analysis_provider.g.dart';

/// Provides the [AnalysisRepository] instance.
@Riverpod(keepAlive: true)
AnalysisRepository analysisRepository(Ref ref) {
  return AnalysisRepositoryImpl(
    AnalysisDataSource(SupabaseService.client),
  );
}

/// Manages the full analysis pipeline: upload → analyze → result.
@Riverpod(keepAlive: true)
class AnalysisNotifier extends _$AnalysisNotifier {
  /// Last userId/photoPath pair that was uploaded successfully.
  /// Used by [retryAnalyze] so we don't re-upload the photo on retry —
  /// we only re-run the (expensive, transient-prone) AI analysis call.
  String? _lastUserId;
  String? _lastPhotoPath;

  @override
  FutureOr<AnalysisEntity?> build() => null;

  /// Upload the photo, then analyze. On failure, [retryAnalyze] can
  /// re-run the analyze step without re-uploading.
  Future<void> runAnalysis({
    required String userId,
    required Uint8List photoBytes,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(analysisRepositoryProvider);
      log.i('Uploading photo...');
      final photoPath = await repo.uploadPhoto(
        userId: userId,
        photoBytes: photoBytes,
      );
      _lastUserId = userId;
      _lastPhotoPath = photoPath;
    } catch (e, st) {
      log.e('Photo upload failed', e, st);
      state = AsyncError(e, st);
      return;
    }
    await _analyzeAndFinalize();
  }

  /// Re-run only the analyze step against the last uploaded photo.
  /// No-ops with an error state if [runAnalysis] hasn't completed its
  /// upload stage yet.
  Future<void> retryAnalyze() async {
    if (_lastUserId == null || _lastPhotoPath == null) {
      state = AsyncError(
        StateError('No uploaded photo to retry'),
        StackTrace.current,
      );
      return;
    }
    log.i('Retrying analysis for $_lastPhotoPath');
    await _analyzeAndFinalize();
  }

  Future<void> _analyzeAndFinalize() async {
    final userId = _lastUserId;
    final photoPath = _lastPhotoPath;
    if (userId == null || photoPath == null) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(analysisRepositoryProvider);

      log.i('Analyzing skin...');
      final analysis = await repo.analyzeSkin(
        userId: userId,
        photoPath: photoPath,
      );
      log.i('Analysis complete: score=${analysis.overallScore}');

      // Score improvement notification
      final history = await repo.getHistory(userId);
      if (history.length >= 2) {
        final previous = history[1];
        await NotificationScheduler.checkScoreImprovement(
          previousScore: previous.overallScore,
          currentScore: analysis.overallScore,
        );
      }

      // Badge unlocks
      final scoreImprovement = history.length >= 2
          ? analysis.overallScore - history[1].overallScore
          : null;
      await ref.read(badgeNotifierProvider.notifier).checkAndUnlock(
            currentStreak: 0,
            totalAnalyses: history.length,
            hasRoutine: false,
            currentScore: analysis.overallScore,
            scoreImprovement: scoreImprovement,
          );

      // Invalidate dependent providers so they refetch fresh data
      ref.invalidate(analysisHistoryProvider(userId));
      ref.invalidate(latestAnalysisProvider(userId));
      ref.invalidate(homeRoutinesProvider(userId));
      ref.invalidate(homeTrendProvider(userId));
      ref.invalidate(progressSummaryNotifierProvider(userId));
      ref.invalidate(scoreTrendNotifierProvider(userId));
      ref.invalidate(zoneProgressNotifierProvider(userId));
      ref.invalidate(photoComparisonNotifierProvider(userId));

      return analysis;
    });
  }

  /// Load an existing analysis by ID.
  Future<void> loadAnalysis(String analysisId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(analysisRepositoryProvider);
      return repo.getAnalysis(analysisId);
    });
  }
}

/// Fetches a single analysis by ID (read-only, does not affect global state).
@riverpod
FutureOr<AnalysisEntity?> analysisDetail(Ref ref, String analysisId) async {
  final repo = ref.read(analysisRepositoryProvider);
  return repo.getAnalysis(analysisId);
}

/// Provides analysis history for the current user.
@riverpod
class AnalysisHistory extends _$AnalysisHistory {
  @override
  FutureOr<List<AnalysisEntity>> build(String userId) async {
    final repo = ref.read(analysisRepositoryProvider);
    return repo.getHistory(userId);
  }

  /// Refresh the history list.
  Future<void> refresh(String userId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(analysisRepositoryProvider);
      return repo.getHistory(userId);
    });
  }
}
