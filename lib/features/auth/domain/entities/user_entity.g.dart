// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserEntityImpl _$$UserEntityImplFromJson(Map<String, dynamic> json) =>
    _$UserEntityImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      skinType: json['skinType'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      subscriptionTier: json['subscriptionTier'] as String? ?? 'free',
      onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
      skinConcerns:
          (json['skinConcerns'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserEntityImplToJson(_$UserEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'skinType': instance.skinType,
      'avatarUrl': instance.avatarUrl,
      'birthDate': instance.birthDate?.toIso8601String(),
      'subscriptionTier': instance.subscriptionTier,
      'onboardingCompleted': instance.onboardingCompleted,
      'skinConcerns': instance.skinConcerns,
    };
