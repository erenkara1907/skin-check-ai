# Feature Plan: Gamification (badges + weekly summary)

**Date:** 2026-04-25 (retroactive — feature already implemented on `develop`)
**Status:** Implemented; this document captures intent for future maintenance.

---

## Overview

Lightweight motivation layer on top of analyses + routines:

- **Badges** — 8 unlockable achievements stored client-side (no backend table). Triggers fire whenever the app reads streak / analysis count / score / routine state and detects a newly satisfied condition.
- **Weekly summary** — derived widget on the home/profile area showing this week's morning/evening routine check-ins, sourced entirely from `routine_completions`.

Why client-side: the current badge set has no anti-cheat or social requirements, so persisting via `shared_preferences` (`_kUnlockedBadgesKey`) is enough. If badges later need to be cross-device or socially shared, migrate to a `user_badges` table — the entity (`BadgeEntity`) already has a JSON-serializable shape.

---

## Files (already on develop)

### Domain

| File | Purpose |
|------|---------|
| `lib/features/gamification/domain/entities/badge_entity.dart` | Freezed entity (id, titleKey, descriptionKey, iconName, unlockedAt). `titleKey`/`descriptionKey` are L10n keys (`badgeFirstAnalysis`, `badgeStreak7`, …). |
| `lib/features/gamification/domain/entities/weekly_summary_entity.dart` | Freezed: `morningCompleted`, `eveningCompleted` (each clamped 0-7). |
| `lib/features/gamification/domain/badge_catalog.dart` | Static list of 8 `BadgeEntity` records. Adding a new badge = append here + matching L10n keys + a `tryUnlock` rule in `BadgeNotifier`. |

### Presentation

| File | Purpose |
|------|---------|
| `lib/features/gamification/presentation/providers/badge_provider.dart` | `@Riverpod(keepAlive: true)` `BadgeNotifier`. Loads from prefs, exposes `checkAndUnlock(currentStreak, totalAnalyses, hasRoutine, currentScore, scoreImprovement)`. |
| `lib/features/gamification/presentation/providers/weekly_summary_provider.dart` | `WeeklySummaryNotifier(userId)` — derives morning/evening counts from `routineRepository.getCompletions`. |
| `lib/features/gamification/presentation/screens/badges_screen.dart` | All 8 badges in a grid, locked/unlocked variants. |
| `lib/features/gamification/presentation/widgets/badge_grid.dart` | Reusable grid for the screen + profile teaser. |
| `lib/features/gamification/presentation/widgets/weekly_summary_card.dart` | Bar/dot visual for the week's completions; consumed by home screen. |

### Integration points

- **Home screen** (`lib/features/home/presentation/screens/home_screen.dart`) reads `weeklySummaryProvider`.
- **Profile screen** shows the badge grid teaser via `lib/features/profile/presentation/screens/profile_screen.dart` (`badgesTitle` / `viewAllBadges` L10n keys).
- **Streak / analysis hooks** call `BadgeNotifier.checkAndUnlock` after completing a routine or persisting an analysis. Newly unlocked badges are returned for any "celebration" UI.

---

## Database

**No new tables.** Implementation is fully client-side:

- Source-of-truth for streak / completions: existing `routine_completions` (see `20260425000003_create_routine_completions.sql`).
- Source-of-truth for analysis count / scores: existing `analyses` + `zone_scores`.
- Unlocked-badge map persisted in `SharedPreferences` under `unlocked_badges` (JSON `{badgeId: ISO8601-timestamp}`).

If gamification later needs server-side persistence, add:

```sql
CREATE TABLE user_badges (
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  badge_id TEXT NOT NULL,
  unlocked_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, badge_id)
);
```

…and switch `BadgeNotifier` to read/write that instead of `SharedPreferences`. The entity contract stays the same.

---

## Badge unlock rules (current)

| Badge ID | Condition | Source |
|----------|-----------|--------|
| `first_analysis` | `totalAnalyses >= 1` | `analyses` rowcount |
| `first_routine` | `hasRoutine == true` | any active row in `routines` |
| `streak_7` | `currentStreak >= 7` | client streak calc over `routine_completions` |
| `streak_14` | `currentStreak >= 14` | same |
| `streak_30` | `currentStreak >= 30` | same |
| `streak_60` | `currentStreak >= 60` | same |
| `score_80` | `currentScore >= 80` | latest `analyses.overall_score` |
| `score_improved_10` | `scoreImprovement >= 10` | delta between two latest analyses |

Each rule is one `tryUnlock(id, condition)` call in `BadgeNotifier.checkAndUnlock`.

---

## Security

- All badge state is per-device; no PII written.
- Weekly summary respects existing `routine_completions` RLS — user only ever sees own data.
- No external API calls.

---

## Open follow-ups

- Weekly summary currently approximates morning/evening split (`evening = morning / 2`) because per-completion routine type isn't recorded today. If this becomes important, add a `type` column to `routine_completions` or join through `routines`.
- Once `user_badges` exists, GDPR delete (`profile_datasource.dart`) needs to clear that table too.
