import 'package:freezed_annotation/freezed_annotation.dart';

part 'routine_step_detail_entity.freezed.dart';
part 'routine_step_detail_entity.g.dart';

/// A single step in a skincare routine with full details.
@freezed
class RoutineStepDetailEntity with _$RoutineStepDetailEntity {
  const factory RoutineStepDetailEntity({
    required String step,
    @JsonKey(name: 'product_type') required String productType,
    required String reason,
    @JsonKey(name: 'how_to_apply') @Default('') String howToApply,
    @JsonKey(name: 'icon_name') @Default('droplets') String iconName,
    @JsonKey(name: 'is_completed') @Default(false) bool isCompleted,
  }) = _RoutineStepDetailEntity;

  factory RoutineStepDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$RoutineStepDetailEntityFromJson(json);
}
