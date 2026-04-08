// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShareCardDataImpl _$$ShareCardDataImplFromJson(Map<String, dynamic> json) =>
    _$ShareCardDataImpl(
      overallScore: (json['overallScore'] as num).toDouble(),
      skinAge: (json['skinAge'] as num).toInt(),
      zones:
          (json['zones'] as List<dynamic>?)
              ?.map((e) => ZoneScoreEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      label: json['label'] as String? ?? 'Analiz Sonucu',
    );

Map<String, dynamic> _$$ShareCardDataImplToJson(_$ShareCardDataImpl instance) =>
    <String, dynamic>{
      'overallScore': instance.overallScore,
      'skinAge': instance.skinAge,
      'zones': instance.zones,
      'label': instance.label,
    };
