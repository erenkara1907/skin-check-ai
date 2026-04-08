// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_summary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgressSummaryEntityImpl _$$ProgressSummaryEntityImplFromJson(
  Map<String, dynamic> json,
) => _$ProgressSummaryEntityImpl(
  currentScore: (json['currentScore'] as num?)?.toDouble() ?? 0,
  skinAge: (json['skinAge'] as num?)?.toInt() ?? 0,
  totalAnalyses: (json['totalAnalyses'] as num?)?.toInt() ?? 0,
  mostImprovedZone: json['mostImprovedZone'] as String?,
  mostImprovedZoneChange:
      (json['mostImprovedZoneChange'] as num?)?.toDouble() ?? 0,
  streak: (json['streak'] as num?)?.toInt() ?? 0,
  lastAnalysisDate: json['lastAnalysisDate'] == null
      ? null
      : DateTime.parse(json['lastAnalysisDate'] as String),
);

Map<String, dynamic> _$$ProgressSummaryEntityImplToJson(
  _$ProgressSummaryEntityImpl instance,
) => <String, dynamic>{
  'currentScore': instance.currentScore,
  'skinAge': instance.skinAge,
  'totalAnalyses': instance.totalAnalyses,
  'mostImprovedZone': instance.mostImprovedZone,
  'mostImprovedZoneChange': instance.mostImprovedZoneChange,
  'streak': instance.streak,
  'lastAnalysisDate': instance.lastAnalysisDate?.toIso8601String(),
};
