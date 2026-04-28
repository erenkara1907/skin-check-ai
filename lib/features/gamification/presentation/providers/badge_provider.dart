import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/logger.dart';
import '../../domain/badge_catalog.dart';
import '../../domain/entities/badge_entity.dart';

part 'badge_provider.g.dart';

const _kUnlockedBadgesKey = 'unlocked_badges';

/// Manages badge unlocking and persistence.
@Riverpod(keepAlive: true)
class BadgeNotifier extends _$BadgeNotifier {
  @override
  FutureOr<List<BadgeEntity>> build() async {
    return _loadBadges();
  }

  Future<List<BadgeEntity>> _loadBadges() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_kUnlockedBadgesKey);
    final unlockedMap = <String, DateTime>{};

    if (json != null) {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      for (final entry in decoded.entries) {
        unlockedMap[entry.key] = DateTime.parse(entry.value as String);
      }
    }

    return BadgeCatalog.allBadges.map((b) {
      final unlockedAt = unlockedMap[b.id];
      return unlockedAt != null
          ? b.copyWith(unlockedAt: unlockedAt)
          : b;
    }).toList();
  }

  /// Checks conditions and unlocks newly earned badges.
  /// Returns the list of newly unlocked badges.
  Future<List<BadgeEntity>> checkAndUnlock({
    required int currentStreak,
    required int totalAnalyses,
    required bool hasRoutine,
    required double currentScore,
    double? scoreImprovement,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_kUnlockedBadgesKey);
    final unlockedMap = <String, String>{};

    if (json != null) {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      for (final entry in decoded.entries) {
        unlockedMap[entry.key] = entry.value as String;
      }
    }

    final now = DateTime.now().toIso8601String();
    final newlyUnlocked = <BadgeEntity>[];

    void tryUnlock(String id, bool condition) {
      if (condition && !unlockedMap.containsKey(id)) {
        unlockedMap[id] = now;
        final badge = BadgeCatalog.allBadges.firstWhere((b) => b.id == id);
        newlyUnlocked
            .add(badge.copyWith(unlockedAt: DateTime.parse(now)));
      }
    }

    tryUnlock('first_analysis', totalAnalyses >= 1);
    tryUnlock('first_routine', hasRoutine);
    tryUnlock('streak_7', currentStreak >= 7);
    tryUnlock('streak_14', currentStreak >= 14);
    tryUnlock('streak_30', currentStreak >= 30);
    tryUnlock('streak_60', currentStreak >= 60);
    tryUnlock('score_80', currentScore >= 80);
    tryUnlock(
      'score_improved_10',
      scoreImprovement != null && scoreImprovement >= 10,
    );

    if (newlyUnlocked.isNotEmpty) {
      await prefs.setString(_kUnlockedBadgesKey, jsonEncode(unlockedMap));
      state = AsyncData(await _loadBadges());
      log.i('Unlocked ${newlyUnlocked.length} new badges');
    }

    return newlyUnlocked;
  }
}
