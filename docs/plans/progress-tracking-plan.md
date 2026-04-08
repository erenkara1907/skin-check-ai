# Progress Tracking — Implementation Plan

**Feature ID:** `progress-tracking`
**Branch:** `feature/progress-tracking`
**Date:** 2026-04-08

---

## Overview

Haftalık ilerleme takibi ve cilt değişim görselleştirme. Dashboard metrik kartları, skor trend grafiği, fotoğraf karşılaştırma (before/after slider), bölge bazlı ilerleme ve haftalık hatırlatma (streak sistemi).

---

## 1. Domain Layer

### Entities (Freezed)

**`lib/features/progress/domain/entities/progress_summary_entity.dart`**
```dart
- currentScore: double
- skinAge: int
- totalAnalyses: int
- mostImprovedZone: String?
- mostImprovedZoneChange: double?
- streak: int (kaç hafta üst üste analiz)
- lastAnalysisDate: DateTime?
```

**`lib/features/progress/domain/entities/score_trend_entity.dart`**
```dart
- date: DateTime
- score: double
```

**`lib/features/progress/domain/entities/zone_progress_entity.dart`**
```dart
- zone: String
- zoneName: String (Turkish label)
- currentScore: double
- previousScore: double
- changePercent: double
```

**`lib/features/progress/domain/entities/photo_comparison_entity.dart`**
```dart
- firstPhotoUrl: String?
- firstDate: DateTime?
- firstScore: double?
- latestPhotoUrl: String?
- latestDate: DateTime?
- latestScore: double?
```

### Repository Interface

**`lib/features/progress/domain/repositories/progress_repository.dart`**
```dart
- getProgressSummary(userId) → ProgressSummaryEntity
- getScoreTrend(userId) → List<ScoreTrendEntity>
- getZoneProgress(userId) → List<ZoneProgressEntity>
- getPhotoComparison(userId) → PhotoComparisonEntity
- getWeeklyStreak(userId) → int
```

---

## 2. Data Layer

**`lib/features/progress/data/datasources/progress_datasource.dart`**
- Supabase queries on `analyses` table (with `zone_scores` join)
- Fetch analyses ordered by date
- Calculate deltas between first and latest
- Generate signed URLs for photos

**`lib/features/progress/data/repositories/progress_repository_impl.dart`**
- Implements ProgressRepository
- Maps raw Supabase data to domain entities
- Calculates streak from analysis dates (weekly intervals)

---

## 3. Presentation Layer

### Providers (Riverpod)

**`lib/features/progress/presentation/providers/progress_provider.dart`**
```dart
- progressRepositoryProvider → ProgressRepository
- ProgressDashboardNotifier (AsyncNotifier)
  - Loads summary, trend, zones, photos in parallel
- scoreTrendProvider(userId)
- zoneProgressProvider(userId)
- photoComparisonProvider(userId)
```

### Screens

**`lib/features/progress/presentation/screens/progress_screen.dart`** (replace placeholder)
- AppBar: "İlerleme"
- RefreshIndicator for pull-to-refresh
- Vertical scroll:
  1. MetricCardsRow (3 cards)
  2. ScoreTrendChart
  3. MostImprovedBadge
  4. PhotoComparisonSlider
  5. ZoneProgressList
- Loading/error/empty states via AsyncValue

### Widgets (each <250 lines)

**`lib/features/progress/presentation/widgets/metric_card.dart`**
- Glassmorphism card with icon, value, label
- 3 variants: score, skin age, total analyses

**`lib/features/progress/presentation/widgets/metric_cards_row.dart`**
- Row of 3 MetricCard widgets

**`lib/features/progress/presentation/widgets/score_trend_chart.dart`**
- fl_chart LineChart
- X: date, Y: score (0-100)
- Smooth curved line with gradient fill below
- Line color: green if upward trend, red if downward
- Touch tooltip showing date + score
- Dark mode: bright gradient colors

**`lib/features/progress/presentation/widgets/most_improved_badge.dart`**
- Star icon + zone name + percentage change
- Highlighted with secondary color accent

**`lib/features/progress/presentation/widgets/photo_comparison_slider.dart`**
- Stack with first photo (left) and latest photo (right)
- GestureDetector / Draggable divider in the middle
- Date + score label below each side
- Full width container

**`lib/features/progress/presentation/widgets/zone_progress_item.dart`**
- Single zone: name, mini progress bar, arrow icon (up/down), % change
- Green for improvement, red for decline

**`lib/features/progress/presentation/widgets/zone_progress_list.dart`**
- Column of 7 ZoneProgressItem widgets

**`lib/features/progress/presentation/widgets/progress_empty_state.dart`**
- Shown when no analyses exist
- "İlk analizini yap" CTA button

---

## 4. Notification (Weekly Reminder)

**Modify: `lib/core/services/notification_service.dart`**
- Add `scheduleWeeklyAnalysisReminder()` method
- ID: 200
- Day: Every Monday at 10:00
- Title: "Bu hafta analizini yaptın mı? 📸"
- Body: "Haftalık analizini yap ve ilerlemeyi takip et!"
- matchDateTimeComponents: dayOfWeekAndTime

---

## 5. Router Update

**Modify: `lib/core/router/app_router.dart`**
- No changes needed — ProgressScreen route already exists at `/progress`

---

## 6. Database

No new tables needed. All data derived from existing `analyses` + `zone_scores` tables via queries. Streak calculation done client-side from analysis dates.

---

## 7. Files Summary

### New Files (15)
| # | File | Layer |
|---|------|-------|
| 1 | `lib/features/progress/domain/entities/progress_summary_entity.dart` | Domain |
| 2 | `lib/features/progress/domain/entities/score_trend_entity.dart` | Domain |
| 3 | `lib/features/progress/domain/entities/zone_progress_entity.dart` | Domain |
| 4 | `lib/features/progress/domain/entities/photo_comparison_entity.dart` | Domain |
| 5 | `lib/features/progress/domain/repositories/progress_repository.dart` | Domain |
| 6 | `lib/features/progress/data/datasources/progress_datasource.dart` | Data |
| 7 | `lib/features/progress/data/repositories/progress_repository_impl.dart` | Data |
| 8 | `lib/features/progress/presentation/providers/progress_provider.dart` | Presentation |
| 9 | `lib/features/progress/presentation/widgets/metric_card.dart` | Presentation |
| 10 | `lib/features/progress/presentation/widgets/metric_cards_row.dart` | Presentation |
| 11 | `lib/features/progress/presentation/widgets/score_trend_chart.dart` | Presentation |
| 12 | `lib/features/progress/presentation/widgets/most_improved_badge.dart` | Presentation |
| 13 | `lib/features/progress/presentation/widgets/photo_comparison_slider.dart` | Presentation |
| 14 | `lib/features/progress/presentation/widgets/zone_progress_item.dart` | Presentation |
| 15 | `lib/features/progress/presentation/widgets/zone_progress_list.dart` | Presentation |
| 16 | `lib/features/progress/presentation/widgets/progress_empty_state.dart` | Presentation |

### Modified Files (2)
| # | File | Change |
|---|------|--------|
| 1 | `lib/features/progress/presentation/screens/progress_screen.dart` | Full rewrite |
| 2 | `lib/core/services/notification_service.dart` | Add weekly reminder |

---

## 8. Test Cases

### Unit Tests
- `test/features/progress/data/repositories/progress_repository_impl_test.dart`
  - Calculates streak correctly (consecutive weeks)
  - Calculates zone progress correctly
  - Handles empty analysis list
  - Returns correct most improved zone
  - Score trend ordered by date

### Widget Tests
- `test/features/progress/presentation/screens/progress_screen_test.dart`
  - Renders 3 metric cards
  - Shows empty state when no data
  - Shows chart when data available
  - Shows zone progress items

---

## 9. Security Concerns

- Photo signed URLs: use Supabase `createSignedUrl` with short expiry (1 hour)
- No API keys in client code
- RLS ensures user sees only own analyses (already enforced)
- No PII exposed in notifications

---

## 10. Implementation Order

1. Domain entities (Freezed) → build_runner
2. Repository interface
3. Data layer (datasource + repo impl)
4. Providers (Riverpod) → build_runner
5. Widgets (smallest first)
6. ProgressScreen (full rewrite)
7. NotificationService update
8. Tests
9. flutter analyze + fix
