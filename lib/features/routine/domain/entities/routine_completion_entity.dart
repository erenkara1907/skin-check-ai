import 'package:freezed_annotation/freezed_annotation.dart';

part 'routine_completion_entity.freezed.dart';
part 'routine_completion_entity.g.dart';

/// Record of a routine completion for a given day.
@freezed
class RoutineCompletionEntity with _$RoutineCompletionEntity {
  const factory RoutineCompletionEntity({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'routine_id') required String routineId,
    @JsonKey(name: 'completed_at') required DateTime completedAt,
    @JsonKey(name: 'completed_steps') @Default([]) List<String> completedSteps,
  }) = _RoutineCompletionEntity;

  factory RoutineCompletionEntity.fromJson(Map<String, dynamic> json) =>
      _$RoutineCompletionEntityFromJson(json);
}
