# Feature Plan: Freemium Paywall System

**Feature ID:** `freemium-paywall`
**Branch:** `feature/freemium-paywall`
**Date:** 2026-04-08

---

## 1. Overview

RevenueCat-powered freemium paywall system. Free users get 1 analysis/week with basic scores. Pro users ($5.99/mo or $49.99/yr) unlock unlimited analyses, zone maps, skin age, routines, progress tracking, and ad-free experience.

---

## 2. Files to Create

### Domain Layer
| File | Purpose |
|------|---------|
| `lib/features/subscription/domain/entities/subscription_entity.dart` | Freezed entity: tier, isActive, expiresAt, entitlement |
| `lib/features/subscription/domain/entities/subscription_plan.dart` | Freezed entity: planId, price, period, label |
| `lib/features/subscription/domain/repositories/subscription_repository.dart` | Abstract repo interface |

### Data Layer
| File | Purpose |
|------|---------|
| `lib/features/subscription/data/datasources/revenuecat_datasource.dart` | RevenueCat SDK wrapper: init, purchase, restore, check entitlements |
| `lib/features/subscription/data/repositories/subscription_repository_impl.dart` | Repo implementation |

### Presentation Layer
| File | Purpose |
|------|---------|
| `lib/features/subscription/presentation/providers/subscription_provider.dart` | Riverpod providers: current subscription state, purchase actions, weekly limit check |
| `lib/features/subscription/presentation/screens/paywall_screen.dart` | Full-screen paywall UI |
| `lib/features/subscription/presentation/widgets/plan_card.dart` | Monthly/Yearly plan selector card |
| `lib/features/subscription/presentation/widgets/feature_comparison_table.dart` | Free vs Pro comparison table |
| `lib/features/subscription/presentation/widgets/paywall_cta_button.dart` | Animated CTA button |

### Core/Shared
| File | Purpose |
|------|---------|
| `lib/core/services/revenuecat_service.dart` | RevenueCat singleton init + API key from env |
| `lib/shared/widgets/pro_badge.dart` | Small "PRO" badge widget |
| `lib/shared/widgets/paywall_gate.dart` | Wrapper widget that shows paywall for non-pro features |

### Tests
| File | Purpose |
|------|---------|
| `test/features/subscription/domain/entities/subscription_entity_test.dart` | Entity serialization tests |
| `test/features/subscription/data/repositories/subscription_repository_impl_test.dart` | Repo tests with mocked datasource |
| `test/features/subscription/presentation/providers/subscription_provider_test.dart` | Provider logic tests |
| `test/features/subscription/presentation/screens/paywall_screen_test.dart` | Widget test for paywall UI |

---

## 3. Files to Modify

| File | Change |
|------|--------|
| `pubspec.yaml` | Add `purchases_flutter: ^8.x` |
| `.env` | Add `REVENUECAT_API_KEY_IOS`, `REVENUECAT_API_KEY_ANDROID` |
| `lib/core/config/env_config.dart` | Add RevenueCat API key getters |
| `lib/core/constants/app_constants.dart` | Add free tier limits (1 analysis/week), entitlement ID, plan IDs |
| `lib/core/router/app_router.dart` | Add `/paywall` route |
| `lib/main.dart` | Init RevenueCat service after Supabase |
| `lib/features/settings/presentation/screens/settings_screen.dart` | Add "Pro'ya Gec" button + subscription info |
| `lib/features/analysis/presentation/screens/analysis_result_screen.dart` | Gate zone map behind pro check |
| `lib/features/analysis/presentation/providers/analysis_provider.dart` | Add weekly analysis count check |

---

## 4. Architecture

```
RevenueCat SDK (purchases_flutter)
       |
RevenueCatDatasource (init, purchase, restore, listener)
       |
SubscriptionRepositoryImpl
       |
SubscriptionProvider (AsyncNotifier)
  ├── subscriptionStateProvider   → current SubscriptionEntity
  ├── isProProvider               → bool derived
  ├── weeklyAnalysisCountProvider → int (from Supabase)
  ├── canAnalyzeProvider          → bool (pro OR count < limit)
  └── purchaseProvider            → purchase/restore actions

PaywallGate widget → wraps pro-only UI, shows lock icon + navigates to paywall
```

---

## 5. Paywall Design

- **Background:** Gradient from `primaryDark` to `backgroundDark`
- **Header:** "Pro'ya Gec" title with gold crown icon
- **Comparison Table:** Two columns (Free / Pro) with check/cross icons
  - Free: Haftada 1 analiz, Genel skor, Paylasim karti
  - Pro: Sinirsiz analiz, Bolge haritasi, Cilt yasi, Rutin olusturucu, Ilerleme takibi, Time-lapse, Reklamsiz
- **Plan Cards:** Two selectable cards
  - Monthly: $5.99/ay (default unselected)
  - Yearly: $49.99/yil with "%30 tasarruf" badge (default selected)
  - Selected card: larger scale, primary border, glow effect
- **CTA:** "7 Gun Ucretsiz Dene" large animated button (pulse animation)
- **Restore:** "Satin almayi geri yukle" text button below CTA
- **Legal:** Privacy + Terms links at bottom
- **Dark mode:** Fully supported

---

## 6. Paywall Triggers

1. **Zone map tap (free user):** Analysis result screen → zone detail → PaywallGate → paywall
2. **Weekly limit reached:** Before analysis → check `canAnalyzeProvider` → paywall if false
3. **Settings:** "Pro'ya Gec" button in settings screen → paywall
4. **Skin age tap:** Result screen → skin age detail → PaywallGate
5. **Routine builder:** Routine feature → PaywallGate
6. **Progress/charts:** Progress screen → PaywallGate

---

## 7. Free vs Pro Enforcement Logic

```dart
// Weekly limit check (Supabase query)
// Count analyses where user_id = current AND created_at >= start of current week
// Free limit: 1 per week

// Feature gating via isProProvider:
// - Zone map detail → pro only
// - Skin age → pro only  
// - Routine creation → pro only
// - Progress charts → pro only
```

---

## 8. Database Changes

No new tables needed. Weekly analysis count derived from existing `analyses` table:
```sql
SELECT COUNT(*) FROM analyses
WHERE user_id = $1
AND created_at >= date_trunc('week', now())
```

The `users.subscription_tier` column already exists and will be kept in sync via RevenueCat webhook → Supabase Edge Function (out of scope for client, but datasource updates local state from RevenueCat SDK).

---

## 9. Security Considerations

- RevenueCat API keys stored in `.env`, accessed via `EnvConfig` (not hardcoded)
- Entitlement validation happens server-side via RevenueCat (SDK handles receipt validation)
- Client-side gating is UX only; server should also enforce (existing RLS + edge function scope)
- No price manipulation possible (prices from RevenueCat/App Store)
- Restore purchases always available (App Store requirement)

---

## 10. Test Cases

### Unit Tests
- `SubscriptionEntity` creation and JSON roundtrip
- `SubscriptionRepositoryImpl` maps RevenueCat CustomerInfo to SubscriptionEntity
- `SubscriptionRepositoryImpl.getWeeklyAnalysisCount()` returns correct count
- `SubscriptionProvider` purchase flow: loading → success/error states
- `isProProvider` returns true when entitlement active
- `canAnalyzeProvider` returns false when free + limit reached

### Widget Tests
- Paywall screen renders comparison table, both plan cards, CTA
- Plan card selection toggles visual state
- CTA button triggers purchase flow
- Restore button triggers restore flow
- PaywallGate shows lock overlay for free users
- PaywallGate shows child content for pro users

---

## 11. Implementation Order

1. Add `purchases_flutter` dependency + env config
2. Domain entities (Freezed)
3. `RevenueCatService` (core init)
4. Data layer (datasource + repo)
5. Providers (subscription state)
6. Paywall screen + widgets
7. `PaywallGate` + `ProBadge` shared widgets
8. Integrate gates into existing screens (analysis result, settings)
9. Weekly limit check in analysis provider
10. Tests
11. Review + ship
