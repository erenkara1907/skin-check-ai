// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_progress_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ZoneProgressEntityImpl _$$ZoneProgressEntityImplFromJson(
  Map<String, dynamic> json,
) => _$ZoneProgressEntityImpl(
  zone: json['zone'] as String,
  zoneName: json['zoneName'] as String,
  currentScore: (json['currentScore'] as num).toDouble(),
  previousScore: (json['previousScore'] as num).toDouble(),
  changePercent: (json['changePercent'] as num).toDouble(),
);

Map<String, dynamic> _$$ZoneProgressEntityImplToJson(
  _$ZoneProgressEntityImpl instance,
) => <String, dynamic>{
  'zone': instance.zone,
  'zoneName': instance.zoneName,
  'currentScore': instance.currentScore,
  'previousScore': instance.previousScore,
  'changePercent': instance.changePercent,
};
