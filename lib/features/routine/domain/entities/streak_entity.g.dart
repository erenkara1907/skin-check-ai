// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StreakEntityImpl _$$StreakEntityImplFromJson(Map<String, dynamic> json) =>
    _$StreakEntityImpl(
      currentStreak: (json['current_streak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longest_streak'] as num?)?.toInt() ?? 0,
      lastCompletedDate: json['last_completed_date'] == null
          ? null
          : DateTime.parse(json['last_completed_date'] as String),
    );

Map<String, dynamic> _$$StreakEntityImplToJson(_$StreakEntityImpl instance) =>
    <String, dynamic>{
      'current_streak': instance.currentStreak,
      'longest_streak': instance.longestStreak,
      'last_completed_date': instance.lastCompletedDate?.toIso8601String(),
    };
