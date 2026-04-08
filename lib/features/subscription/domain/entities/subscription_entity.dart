import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_entity.freezed.dart';
part 'subscription_entity.g.dart';

/// Represents the user's current subscription state.
@freezed
abstract class SubscriptionEntity with _$SubscriptionEntity {
  const factory SubscriptionEntity({
    @Default('free') String tier,
    @Default(false) bool isActive,
    DateTime? expiresAt,
    @Default(false) bool hasProEntitlement,
  }) = _SubscriptionEntity;

  factory SubscriptionEntity.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionEntityFromJson(json);
}
