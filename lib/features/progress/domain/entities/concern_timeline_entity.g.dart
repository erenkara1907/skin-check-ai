// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concern_timeline_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConcernTimelineEntityImpl _$$ConcernTimelineEntityImplFromJson(
  Map<String, dynamic> json,
) => _$ConcernTimelineEntityImpl(
  date: DateTime.parse(json['date'] as String),
  concern: json['concern'] as String,
  severity: (json['severity'] as num).toInt(),
  zone: json['zone'] as String,
);

Map<String, dynamic> _$$ConcernTimelineEntityImplToJson(
  _$ConcernTimelineEntityImpl instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'concern': instance.concern,
  'severity': instance.severity,
  'zone': instance.zone,
};
