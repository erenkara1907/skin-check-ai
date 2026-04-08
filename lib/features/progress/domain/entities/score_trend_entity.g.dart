// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_trend_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScoreTrendEntityImpl _$$ScoreTrendEntityImplFromJson(
  Map<String, dynamic> json,
) => _$ScoreTrendEntityImpl(
  date: DateTime.parse(json['date'] as String),
  score: (json['score'] as num).toDouble(),
);

Map<String, dynamic> _$$ScoreTrendEntityImplToJson(
  _$ScoreTrendEntityImpl instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'score': instance.score,
};
