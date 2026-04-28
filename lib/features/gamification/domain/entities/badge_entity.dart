import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge_entity.freezed.dart';
part 'badge_entity.g.dart';

/// Represents an achievement badge.
@freezed
class BadgeEntity with _$BadgeEntity {
  const factory BadgeEntity({
    required String id,
    required String titleKey,
    required String descriptionKey,
    required String iconName,
    DateTime? unlockedAt,
  }) = _BadgeEntity;

  factory BadgeEntity.fromJson(Map<String, dynamic> json) =>
      _$BadgeEntityFromJson(json);
}
