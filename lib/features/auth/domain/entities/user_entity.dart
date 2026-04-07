import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

/// Domain entity representing an authenticated user.
@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    String? name,
    String? skinType,
    String? avatarUrl,
    DateTime? birthDate,
    @Default('free') String subscriptionTier,
    @Default(false) bool onboardingCompleted,
    @Default([]) List<String> skinConcerns,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
