// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_completion_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoutineCompletionEntityImpl _$$RoutineCompletionEntityImplFromJson(
  Map<String, dynamic> json,
) => _$RoutineCompletionEntityImpl(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  routineId: json['routine_id'] as String,
  completedAt: DateTime.parse(json['completed_at'] as String),
  completedSteps:
      (json['completed_steps'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$RoutineCompletionEntityImplToJson(
  _$RoutineCompletionEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'routine_id': instance.routineId,
  'completed_at': instance.completedAt.toIso8601String(),
  'completed_steps': instance.completedSteps,
};
