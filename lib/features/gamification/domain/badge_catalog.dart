import 'entities/badge_entity.dart';

/// Static catalog of all available badges.
abstract final class BadgeCatalog {
  static const allBadges = [
    BadgeEntity(
      id: 'first_analysis',
      titleKey: 'badgeFirstAnalysis',
      descriptionKey: 'badgeFirstAnalysisDesc',
      iconName: 'scan',
    ),
    BadgeEntity(
      id: 'first_routine',
      titleKey: 'badgeFirstRoutine',
      descriptionKey: 'badgeFirstRoutineDesc',
      iconName: 'sparkles',
    ),
    BadgeEntity(
      id: 'streak_7',
      titleKey: 'badgeStreak7',
      descriptionKey: 'badgeStreak7Desc',
      iconName: 'flame',
    ),
    BadgeEntity(
      id: 'streak_14',
      titleKey: 'badgeStreak14',
      descriptionKey: 'badgeStreak14Desc',
      iconName: 'flame',
    ),
    BadgeEntity(
      id: 'streak_30',
      titleKey: 'badgeStreak30',
      descriptionKey: 'badgeStreak30Desc',
      iconName: 'trophy',
    ),
    BadgeEntity(
      id: 'streak_60',
      titleKey: 'badgeStreak60',
      descriptionKey: 'badgeStreak60Desc',
      iconName: 'star',
    ),
    BadgeEntity(
      id: 'score_80',
      titleKey: 'badgeScore80',
      descriptionKey: 'badgeScore80Desc',
      iconName: 'sun',
    ),
    BadgeEntity(
      id: 'score_improved_10',
      titleKey: 'badgeScoreImproved10',
      descriptionKey: 'badgeScoreImproved10Desc',
      iconName: 'trending-up',
    ),
  ];
}
