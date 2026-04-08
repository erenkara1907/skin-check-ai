import 'package:freezed_annotation/freezed_annotation.dart';

import 'routine_step_entity.dart';
import 'zone_score_entity.dart';

part 'analysis_entity.freezed.dart';
part 'analysis_entity.g.dart';

/// Complete skin analysis result.
@freezed
class AnalysisEntity with _$AnalysisEntity {
  const factory AnalysisEntity({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'photo_url') String? photoUrl,
    @JsonKey(name: 'overall_score') required double overallScore,
    @JsonKey(name: 'skin_age') required int skinAge,
    @Default('') String summary,
    @Default([]) List<ZoneScoreEntity> zones,
    @JsonKey(name: 'morning_routine')
    @Default([])
    List<RoutineStepEntity> morningRoutine,
    @JsonKey(name: 'evening_routine')
    @Default([])
    List<RoutineStepEntity> eveningRoutine,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _AnalysisEntity;

  factory AnalysisEntity.fromJson(Map<String, dynamic> json) =>
      _$AnalysisEntityFromJson(json);
}
