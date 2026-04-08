import 'package:freezed_annotation/freezed_annotation.dart';

import 'routine_step_detail_entity.dart';

part 'routine_entity.freezed.dart';
part 'routine_entity.g.dart';

/// A user's skincare routine (morning or evening).
@freezed
class RoutineEntity with _$RoutineEntity {
  const factory RoutineEntity({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String type,
    @Default([]) List<RoutineStepDetailEntity> steps,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _RoutineEntity;

  factory RoutineEntity.fromJson(Map<String, dynamic> json) =>
      _$RoutineEntityFromJson(json);
}
