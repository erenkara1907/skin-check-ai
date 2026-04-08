import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/logger.dart';
import '../../data/datasources/analysis_datasource.dart';
import '../../data/repositories/analysis_repository_impl.dart';
import '../../domain/entities/analysis_entity.dart';
import '../../domain/repositories/analysis_repository.dart';

part 'analysis_provider.g.dart';

/// Provides the [AnalysisRepository] instance.
@Riverpod(keepAlive: true)
AnalysisRepository analysisRepository(Ref ref) {
  return AnalysisRepositoryImpl(
    AnalysisDataSource(SupabaseService.client),
  );
}

/// Manages the full analysis pipeline: upload → analyze → result.
@riverpod
class AnalysisNotifier extends _$AnalysisNotifier {
  @override
  FutureOr<AnalysisEntity?> build() => null;

  /// Run the full analysis pipeline.
  Future<void> runAnalysis({
    required String userId,
    required Uint8List photoBytes,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(analysisRepositoryProvider);

      log.i('Uploading photo...');
      final photoPath = await repo.uploadPhoto(
        userId: userId,
        photoBytes: photoBytes,
      );

      log.i('Analyzing skin...');
      final analysis = await repo.analyzeSkin(
        userId: userId,
        photoPath: photoPath,
      );

      log.i('Analysis complete: score=${analysis.overallScore}');
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
