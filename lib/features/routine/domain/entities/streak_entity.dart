import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_entity.freezed.dart';
part 'streak_entity.g.dart';

/// Tracks a user's routine completion streak.
@freezed
class StreakEntity with _$StreakEntity {
  const factory StreakEntity({
    @JsonKey(name: 'current_streak') @Default(0) int currentStreak,
    @JsonKey(name: 'longest_streak') @Default(0) int longestStreak,
    @JsonKey(name: 'last_completed_date') DateTime? lastCompletedDate,
  }) = _StreakEntity;

  factory StreakEntity.fromJson(Map<String, dynamic> json) =>
      _$StreakEntityFromJson(json);
}
