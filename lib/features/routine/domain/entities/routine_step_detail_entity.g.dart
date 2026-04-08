// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_step_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoutineStepDetailEntityImpl _$$RoutineStepDetailEntityImplFromJson(
  Map<String, dynamic> json,
) => _$RoutineStepDetailEntityImpl(
  step: json['step'] as String,
  productType: json['product_type'] as String,
  reason: json['reason'] as String,
  howToApply: json['how_to_apply'] as String? ?? '',
  iconName: json['icon_name'] as String? ?? 'droplets',
  isCompleted: json['is_completed'] as bool? ?? false,
);

Map<String, dynamic> _$$RoutineStepDetailEntityImplToJson(
  _$RoutineStepDetailEntityImpl instance,
) => <String, dynamic>{
  'step': instance.step,
  'product_type': instance.productType,
  'reason': instance.reason,
  'how_to_apply': instance.howToApply,
  'icon_name': instance.iconName,
  'is_completed': instance.isCompleted,
};
