import 'dart:typed_data';

import '../../../../core/utils/logger.dart';
import '../../domain/entities/analysis_entity.dart';
import '../../domain/entities/routine_step_entity.dart';
import '../../domain/entities/zone_score_entity.dart';
import '../../domain/repositories/analysis_repository.dart';
import '../datasources/analysis_datasource.dart';

/// Supabase-backed implementation of [AnalysisRepository].
class AnalysisRepositoryImpl implements AnalysisRepository {
  AnalysisRepositoryImpl(this._dataSource);

  final AnalysisDataSource _dataSource;

  @override
  Future<String> uploadPhoto({
    required String userId,
    required Uint8List photoBytes,
  }) async {
    try {
      return await _dataSource.uploadPhoto(
        userId: userId,
        photoBytes: photoBytes,
      );
    } catch (e, st) {
      log.e('Failed to upload photo', e, st);
      rethrow;
    }
  }

  @override
  Future<AnalysisEntity> analyzeSkin({
    required String userId,
    required String photoPath,
  }) async {
    try {
      final data = await _dataSource.invokeSkinAnalysis(
        userId: userId,
        photoPath: photoPath,
      );
      return _mapToEntity(data);
    } catch (e, st) {
      log.e('Failed to analyze skin', e, st);
      rethrow;
    }
  }

  @override
  Future<AnalysisEntity?> getAnalysis(String analysisId) async {
    try {
      final data = await _dataSource.fetchAnalysis(analysisId);
      if (data == null) return null;
      return _mapToEntity(data);
    } catch (e, st) {
      log.e('Failed to fetch analysis', e, st);
      rethrow;
    }
  }

  @override
  Future<List<AnalysisEntity>> getHistory(String userId) async {
    try {
      final rows = await _dataSource.fetchHistory(userId);
      return rows.map(_mapToEntity).toList();
    } catch (e, st) {
      log.e('Failed to fetch history', e, st);
      rethrow;
    }
  }

  AnalysisEntity _mapToEntity(Map<String, dynamic> data) {
    final rawZones = data['zone_scores'] as List<dynamic>? ?? [];
    final zoneScores = <ZoneScoreEntity>[];
    for (final z in rawZones) {
      try {
        final map = Map<String, dynamic>.from(z as Map);
        // Ensure score exists — fall back to severity-based estimate.
        if (map['score'] == null && map['severity'] != null) {
          final severity = (map['severity'] as num).toInt();
          map['score'] = ((10 - severity) / 9 * 100).clamp(0, 100);
        }
        zoneScores.add(ZoneScoreEntity.fromJson(map));
      } catch (e) {
        log.w('Skipped invalid zone entry: $e');
      }
    }

    final aiJson = data['ai_response_json'] as Map<String, dynamic>?;

    final morningSteps = _parseRoutineSteps(
      aiJson?['suggested_routine']?['morning'],
    );
    final eveningSteps = _parseRoutineSteps(
      aiJson?['suggested_routine']?['evening'],
    );

    return AnalysisEntity(
      id: data['id'] as String,
      userId: data['user_id'] as String,
      photoUrl: data['photo_url'] as String?,
      overallScore: (data['overall_score'] as num).toDouble(),
      skinAge: data['skin_age'] as int? ?? 0,
      summary: aiJson?['summary'] as String? ?? '',
      zones: zoneScores,
      morningRoutine: morningSteps,
      eveningRoutine: eveningSteps,
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'] as String)
          : null,
    );
  }

  List<RoutineStepEntity> _parseRoutineSteps(dynamic steps) {
    if (steps == null || steps is! List) return [];
    return steps
        .map((s) => RoutineStepEntity.fromJson(
              Map<String, dynamic>.from(s as Map),
            ))
        .toList();
  }
}
