# Review: Freemium Paywall System

**Feature ID:** `freemium-paywall`
**Date:** 2026-04-08

---

## Checklist

| Check | Status |
|-------|--------|
| `flutter analyze` — 0 issues | PASS |
| No file > 250 lines | PASS (max: 247 — paywall_screen.dart) |
| No business logic in widgets | PASS — all logic in providers/repos |
| No hardcoded secrets | PASS — API keys from .env via EnvConfig |
| Dark mode support | PASS — all screens use isDark checks |
| Loading states | PASS — AsyncValue pattern in providers |
| Error states | PASS — AsyncValue.guard handles errors |
| Empty states | PASS — default free subscription entity |
| Tests passing | PASS — 180/180 (14 new) |

## Files Created (16)

### Domain (3)
- `lib/features/subscription/domain/entities/subscription_entity.dart`
- `lib/features/subscription/domain/entities/subscription_plan.dart`
- `lib/features/subscription/domain/repositories/subscription_repository.dart`

### Data (2)
- `lib/features/subscription/data/datasources/revenuecat_datasource.dart`
- `lib/features/subscription/data/repositories/subscription_repository_impl.dart`

### Presentation (5)
- `lib/features/subscription/presentation/providers/subscription_provider.dart`
- `lib/features/subscription/presentation/screens/paywall_screen.dart`
- `lib/features/subscription/presentation/widgets/feature_comparison_table.dart`
- `lib/features/subscription/presentation/widgets/plan_card.dart`
- `lib/features/subscription/presentation/widgets/paywall_cta_button.dart`

### Core/Shared (3)
- `lib/core/services/revenuecat_service.dart`
- `lib/shared/widgets/pro_badge.dart`
- `lib/shared/widgets/paywall_gate.dart`

### Tests (3)
- `test/features/subscription/domain/entities/subscription_entity_test.dart`
- `test/features/subscription/data/repositories/subscription_repository_impl_test.dart`
- `test/features/subscription/presentation/screens/paywall_screen_test.dart`

## Files Modified (6)
- `pubspec.yaml` — added `purchases_flutter`
- `lib/core/config/env_config.dart` — RevenueCat API key getters
- `lib/core/constants/app_constants.dart` — subscription constants
- `lib/core/router/app_router.dart` — `/paywall` route
- `lib/main.dart` — RevenueCat init
- `lib/features/analysis/presentation/screens/analysis_result_screen.dart` — PaywallGate on zones + skin age
- `lib/features/analysis/presentation/screens/analysis_screen.dart` — weekly limit check before camera
- `lib/features/settings/presentation/screens/settings_screen.dart` — Pro upgrade card

## Notes
- RevenueCat SDK initialized at app startup, before Riverpod
- Paywall triggers: zone map tap, skin age tap, weekly limit, settings upgrade button
- Free tier: 1 analysis/week, overall score, share card
- Pro tier: unlimited analyses, zone map, skin age, routines, progress, time-lapse
- Plan IDs configurable via AppConstants for easy RevenueCat dashboard mapping
