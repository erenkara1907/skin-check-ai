// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnalysisEntityImpl _$$AnalysisEntityImplFromJson(
  Map<String, dynamic> json,
) => _$AnalysisEntityImpl(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  photoUrl: json['photo_url'] as String?,
  overallScore: (json['overall_score'] as num).toDouble(),
  skinAge: (json['skin_age'] as num).toInt(),
  summary: json['summary'] as String? ?? '',
  zones:
      (json['zones'] as List<dynamic>?)
          ?.map((e) => ZoneScoreEntity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  morningRoutine:
      (json['morning_routine'] as List<dynamic>?)
          ?.map((e) => RoutineStepEntity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  eveningRoutine:
      (json['evening_routine'] as List<dynamic>?)
          ?.map((e) => RoutineStepEntity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$AnalysisEntityImplToJson(
  _$AnalysisEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'photo_url': instance.photoUrl,
  'overall_score': instance.overallScore,
  'skin_age': instance.skinAge,
  'summary': instance.summary,
  'zones': instance.zones,
  'morning_routine': instance.morningRoutine,
  'evening_routine': instance.eveningRoutine,
  'created_at': instance.createdAt?.toIso8601String(),
};
