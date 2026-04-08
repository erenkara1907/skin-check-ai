# Feature Plan: home-dashboard

**Date:** 2026-04-08
**Description:** Ana sayfa dashboard ve custom bottom navigation bar

---

## Summary

Replace the current placeholder AnalysisScreen at index 0 with a full Home Dashboard, and redesign the bottom navigation bar with a floating FAB-style center "Analiz" button.

---

## Files to Create

### Home Feature (new)
1. `lib/features/home/presentation/screens/home_screen.dart` — Main dashboard screen with greeting, cards
2. `lib/features/home/presentation/widgets/greeting_header.dart` — "Merhaba, [isim]!" + date
3. `lib/features/home/presentation/widgets/last_analysis_card.dart` — Score circle + "X gun once" + CTA
4. `lib/features/home/presentation/widgets/daily_routine_card.dart` — Today's routine checklist + progress bar
5. `lib/features/home/presentation/widgets/weekly_tip_card.dart` — Hardcoded skin care tip of the week
6. `lib/features/home/presentation/widgets/mini_progress_chart.dart` — Last 4 weeks score trend (fl_chart)
7. `lib/features/home/presentation/widgets/first_analysis_card.dart` — Empty state CTA for new users
8. `lib/features/home/presentation/providers/home_provider.dart` — Home dashboard data aggregation

### Tests
9. `test/features/home/presentation/screens/home_screen_test.dart` — Widget tests for HomeScreen

## Files to Modify

1. `lib/shared/widgets/main_shell.dart` — Redesign bottom nav: floating effect, rounded top corners, prominent center FAB button
2. `lib/core/router/app_router.dart` — Replace AnalysisScreen with HomeScreen at index 0

---

## Architecture

### Domain Layer
- No new entities needed. Reuses: `UserEntity`, `AnalysisEntity`, `RoutineEntity`, `ScoreTrendEntity`

### Data Layer
- No new data sources. Home providers compose existing providers (auth, analysis, routine, progress)

### Presentation Layer

**HomeProvider** — Aggregates data from existing providers:
- `userProfile` → greeting name
- `analysisHistory` → latest analysis (score, date, zones)
- `routineNotifier` → today's routine steps + completion %
- `scoreTrendNotifier` → last 4 weeks for mini chart

**HomeScreen** — ScrollView with card-based layout:
- If no analyses: show `FirstAnalysisCard` (empty state)
- If analyses exist: show `LastAnalysisCard`, `DailyRoutineCard`, `WeeklyTipCard`, `MiniProgressChart`

**Bottom Navigation Redesign:**
- Container with rounded top corners (`borderRadius: BorderRadius.vertical(top: Radius.circular(20))`)
- Subtle shadow upward
- Center (index 1 = Analyze) button: elevated circular FAB with gradient, larger icon, pops above bar
- Other 4 items: standard icon + label below
- Floating effect: slight margin from edges, elevated container

---

## Database Changes
None.

---

## Test Cases

### Widget Tests
1. HomeScreen shows greeting with user name
2. HomeScreen shows FirstAnalysisCard when no analyses
3. HomeScreen shows LastAnalysisCard when analysis exists
4. HomeScreen shows DailyRoutineCard with routine data
5. HomeScreen shows MiniProgressChart with trend data
6. Tapping "Tekrar analiz et" navigates to camera
7. Tapping "Ilk analizini yap" navigates to camera

---

## Security Concerns
- No new API calls or data exposure
- User data already protected by existing RLS and auth
- No secrets or keys involved

---

## Design Tokens
- Cards: AppCard (glassmorphism), 16px radius
- Colors: Primary #6C63FF, Secondary #00D9A6
- Fonts: Outfit (display), Plus Jakarta Sans (body)
- Dark mode: all widgets use Theme.of(context)
- Animations: flutter_animate for entrance animations
- Touch targets: min 48x48
- FAB center button: 56x56 with gradient background
