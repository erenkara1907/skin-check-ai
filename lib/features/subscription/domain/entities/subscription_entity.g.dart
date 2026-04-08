// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionEntityImpl _$$SubscriptionEntityImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionEntityImpl(
  tier: json['tier'] as String? ?? 'free',
  isActive: json['isActive'] as bool? ?? false,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  hasProEntitlement: json['hasProEntitlement'] as bool? ?? false,
);

Map<String, dynamic> _$$SubscriptionEntityImplToJson(
  _$SubscriptionEntityImpl instance,
) => <String, dynamic>{
  'tier': instance.tier,
  'isActive': instance.isActive,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'hasProEntitlement': instance.hasProEntitlement,
};
