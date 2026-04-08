// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_step_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoutineStepEntityImpl _$$RoutineStepEntityImplFromJson(
  Map<String, dynamic> json,
) => _$RoutineStepEntityImpl(
  step: json['step'] as String,
  productType: json['product_type'] as String,
  reason: json['reason'] as String,
);

Map<String, dynamic> _$$RoutineStepEntityImplToJson(
  _$RoutineStepEntityImpl instance,
) => <String, dynamic>{
  'step': instance.step,
  'product_type': instance.productType,
  'reason': instance.reason,
};
