// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_comparison_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PhotoComparisonEntityImpl _$$PhotoComparisonEntityImplFromJson(
  Map<String, dynamic> json,
) => _$PhotoComparisonEntityImpl(
  firstPhotoUrl: json['firstPhotoUrl'] as String?,
  firstDate: json['firstDate'] == null
      ? null
      : DateTime.parse(json['firstDate'] as String),
  firstScore: (json['firstScore'] as num?)?.toDouble() ?? 0,
  latestPhotoUrl: json['latestPhotoUrl'] as String?,
  latestDate: json['latestDate'] == null
      ? null
      : DateTime.parse(json['latestDate'] as String),
  latestScore: (json['latestScore'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$$PhotoComparisonEntityImplToJson(
  _$PhotoComparisonEntityImpl instance,
) => <String, dynamic>{
  'firstPhotoUrl': instance.firstPhotoUrl,
  'firstDate': instance.firstDate?.toIso8601String(),
  'firstScore': instance.firstScore,
  'latestPhotoUrl': instance.latestPhotoUrl,
  'latestDate': instance.latestDate?.toIso8601String(),
  'latestScore': instance.latestScore,
};
