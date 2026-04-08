// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoutineEntityImpl _$$RoutineEntityImplFromJson(Map<String, dynamic> json) =>
    _$RoutineEntityImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: json['type'] as String,
      steps:
          (json['steps'] as List<dynamic>?)
              ?.map(
                (e) =>
                    RoutineStepDetailEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$RoutineEntityImplToJson(_$RoutineEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'type': instance.type,
      'steps': instance.steps,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
