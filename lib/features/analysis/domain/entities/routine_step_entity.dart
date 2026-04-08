import 'package:freezed_annotation/freezed_annotation.dart';

part 'routine_step_entity.freezed.dart';
part 'routine_step_entity.g.dart';

/// A single step in a suggested skincare routine.
@freezed
class RoutineStepEntity with _$RoutineStepEntity {
  const factory RoutineStepEntity({
    required String step,
    @JsonKey(name: 'product_type') required String productType,
    required String reason,
  }) = _RoutineStepEntity;

  factory RoutineStepEntity.fromJson(Map<String, dynamic> json) =>
      _$RoutineStepEntityFromJson(json);
}
