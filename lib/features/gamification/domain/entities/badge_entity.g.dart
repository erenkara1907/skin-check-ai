// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BadgeEntityImpl _$$BadgeEntityImplFromJson(Map<String, dynamic> json) =>
    _$BadgeEntityImpl(
      id: json['id'] as String,
      titleKey: json['titleKey'] as String,
      descriptionKey: json['descriptionKey'] as String,
      iconName: json['iconName'] as String,
      unlockedAt: json['unlockedAt'] == null
          ? null
          : DateTime.parse(json['unlockedAt'] as String),
    );

Map<String, dynamic> _$$BadgeEntityImplToJson(_$BadgeEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titleKey': instance.titleKey,
      'descriptionKey': instance.descriptionKey,
      'iconName': instance.iconName,
      'unlockedAt': instance.unlockedAt?.toIso8601String(),
    };
