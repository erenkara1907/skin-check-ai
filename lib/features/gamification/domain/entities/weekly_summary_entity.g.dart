// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_summary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeeklySummaryEntityImpl _$$WeeklySummaryEntityImplFromJson(
  Map<String, dynamic> json,
) => _$WeeklySummaryEntityImpl(
  morningCompleted: (json['morningCompleted'] as num?)?.toInt() ?? 0,
  eveningCompleted: (json['eveningCompleted'] as num?)?.toInt() ?? 0,
  totalDays: (json['totalDays'] as num?)?.toInt() ?? 7,
  analysisCount: (json['analysisCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$WeeklySummaryEntityImplToJson(
  _$WeeklySummaryEntityImpl instance,
) => <String, dynamic>{
  'morningCompleted': instance.morningCompleted,
  'eveningCompleted': instance.eveningCompleted,
  'totalDays': instance.totalDays,
  'analysisCount': instance.analysisCount,
};
