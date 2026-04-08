// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_score_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ZoneScoreEntityImpl _$$ZoneScoreEntityImplFromJson(
  Map<String, dynamic> json,
) => _$ZoneScoreEntityImpl(
  zone: json['zone'] as String,
  score: (json['score'] as num).toDouble(),
  concerns:
      (json['concerns'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  severity: (json['severity'] as num?)?.toInt() ?? 5,
  recommendations:
      (json['recommendations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$ZoneScoreEntityImplToJson(
  _$ZoneScoreEntityImpl instance,
) => <String, dynamic>{
  'zone': instance.zone,
  'score': instance.score,
  'concerns': instance.concerns,
  'severity': instance.severity,
  'recommendations': instance.recommendations,
};
