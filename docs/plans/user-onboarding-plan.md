# Feature Plan: User Onboarding Flow

**Feature ID:** `user-onboarding`
**Branch:** `feature/user-onboarding`
**Date:** 2026-04-07

---

## Overview

4 ekranlı yeni kullanıcı onboarding akışı: Hoşgeldin → Cilt Tipi → Hedefler → Kamera İzni.
PageView ile swipe geçiş, dot indicator, seçimleri Supabase'e kaydetme, tamamlandığında bir daha göstermeme.

---

## Database Changes

### Users tablosu güncellemesi
- `skin_concerns` (text[] / jsonb) — seçilen hedefler (akne, kırışıklık vb.)
- `onboarding_completed` (boolean, default false) — onboarding durumu

> Not: `skin_type` zaten UserEntity'de mevcut. Supabase `users` tablosuna `skin_concerns` ve `onboarding_completed` sütunları eklenecek.

### Supabase Migration
```sql
ALTER TABLE public.users
  ADD COLUMN IF NOT EXISTS skin_concerns text[] DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS onboarding_completed boolean DEFAULT false;
```

---

## Files to Create / Modify

### Domain Layer

| File | Action | Description |
|------|--------|-------------|
| `lib/features/onboarding/domain/entities/skin_type.dart` | CREATE | SkinType enum (normal, oily, dry, combination) |
| `lib/features/onboarding/domain/entities/skin_concern.dart` | CREATE | SkinConcern enum (acne, wrinkles, spots, pores, dryness, oiliness, darkCircles, redness) |
| `lib/features/onboarding/domain/repositories/onboarding_repository.dart` | CREATE | Abstract repo: saveOnboardingData(), markOnboardingCompleted() |

### Data Layer

| File | Action | Description |
|------|--------|-------------|
| `lib/features/onboarding/data/datasources/onboarding_datasource.dart` | CREATE | Supabase datasource — users tablosunu güncelle |
| `lib/features/onboarding/data/repositories/onboarding_repository_impl.dart` | CREATE | Repository implementasyonu |

### Presentation Layer — Providers

| File | Action | Description |
|------|--------|-------------|
| `lib/features/onboarding/presentation/providers/onboarding_provider.dart` | CREATE | OnboardingNotifier: page index, skinType, concerns, saveToSupabase |

### Presentation Layer — Screens

| File | Action | Description |
|------|--------|-------------|
| `lib/features/onboarding/presentation/screens/onboarding_screen.dart` | MODIFY | Ana ekran: PageView + dot indicator + state yönetimi |

### Presentation Layer — Widgets (her biri <250 satır)

| File | Action | Description |
|------|--------|-------------|
| `lib/features/onboarding/presentation/widgets/welcome_page.dart` | CREATE | Ekran 1: Animasyonlu logo, tagline, illüstrasyon, 'Başla' butonu |
| `lib/features/onboarding/presentation/widgets/skin_type_page.dart` | CREATE | Ekran 2: 2x2 grid kartlar, seçim animasyonu |
| `lib/features/onboarding/presentation/widgets/skin_concerns_page.dart` | CREATE | Ekran 3: Wrap layout chip'ler, multi-select |
| `lib/features/onboarding/presentation/widgets/camera_permission_page.dart` | CREATE | Ekran 4: Kamera ikonu, izin butonu |
| `lib/features/onboarding/presentation/widgets/onboarding_dot_indicator.dart` | CREATE | Sayfa göstergesi (animated dots) |
| `lib/features/onboarding/presentation/widgets/skin_type_card.dart` | CREATE | Tek bir cilt tipi kartı (ikon + isim + açıklama + scale animasyonu) |
| `lib/features/onboarding/presentation/widgets/concern_chip.dart` | CREATE | Tek bir concern chip'i (selected/unselected state) |

### Router & Auth Modifications

| File | Action | Description |
|------|--------|-------------|
| `lib/core/router/app_router.dart` | MODIFY | Redirect logic: isAuth && !onboardingCompleted → /onboarding |
| `lib/features/auth/domain/entities/user_entity.dart` | MODIFY | `onboardingCompleted` ve `skinConcerns` field'ları ekle |
| `lib/features/auth/data/datasources/supabase_auth_datasource.dart` | MODIFY | _mapUser'da yeni field'ları map et |

---

## Architecture Flow

```
[OnboardingScreen] (PageView controller)
    ├── [WelcomePage] → "Başla" → sayfa 2
    ├── [SkinTypePage] → kart seç → sayfa 3
    ├── [SkinConcernsPage] → chip'ler seç (min 1) → sayfa 4
    └── [CameraPermissionPage] → izin iste → Supabase'e kaydet → home

[OnboardingNotifier] (Riverpod AsyncNotifier)
    ├── currentPage: int
    ├── selectedSkinType: SkinType?
    ├── selectedConcerns: Set<SkinConcern>
    ├── selectSkinType(SkinType)
    ├── toggleConcern(SkinConcern)
    └── completeOnboarding() → repo.save → router → home

[GoRouter redirect]
    isAuth && !onboardingCompleted → /onboarding
    isAuth && onboardingCompleted → /home (normal akış)
```

---

## Design Specifications

### Ekran 1 — Hoşgeldin
- Üstte: Animasyonlu app logosu (fadeIn + scale, flutter_animate)
- Ortada: Yüz + sparkle ikonu (LucideIcons.sparkles + LucideIcons.scan)
- Tagline: "Cildini tanı, güzelliğini keşfet" (AppTextStyles.displaySmall)
- Altta: "Başla" butonu (AppButton, primary, fullWidth)
- Arka plan: GradientBackground

### Ekran 2 — Cilt Tipi
- Başlık: "Cilt tipin hangisi?" (displaySmall)
- 2x2 Grid (GridView, crossAxisCount: 2)
- Her kart: AppCard + ikon + başlık + 1 satır açıklama
- Seçilince: primary border + scale(1.05) animasyonu (300ms)
- İkonlar: LucideIcons.droplet (Normal), LucideIcons.sun (Yağlı), LucideIcons.wind (Kuru), LucideIcons.contrast (Karma)

### Ekran 3 — Hedefler
- Başlık: "En çok neyi iyileştirmek istiyorsun?" (displaySmall)
- Wrap layout, spacing: 8
- Chip: seçili → primary bg + beyaz yazı, seçilmemiş → surface bg + border
- Minimum 1 seçim zorunlu (buton disabled olur)
- İleri butonu: "Devam" (primary, fullWidth)

### Ekran 4 — Kamera İzni
- Büyük kamera ikonu (LucideIcons.camera, 80px, primary renk)
- Açıklama: "Cilt analizin için kameraya ihtiyacımız var" (bodyLarge)
- Alt metin: "Fotoğrafların güvenle saklanır" (bodySmall, secondary text)
- Buton: "Analizimi Başlat" (primary, fullWidth)
- permission_handler ile kamera izni
- İzin sonrası → completeOnboarding → home'a yönlendir

### Genel
- Dot indicator: altta, sabit pozisyon (SafeArea içinde)
- PageView: physics → NeverScrollableScrollPhysics (butonlarla kontrol)
- Geçiş animasyonu: Custom PageRoute veya AnimatedSwitcher
- Dark mode: Tüm renkler tema üzerinden

---

## Security Concerns

- Kamera izni sadece kullanıcı onayıyla istenir
- Supabase RLS: Kullanıcı sadece kendi users satırını güncelleyebilir
- Hassas veri yok (cilt tipi/hedef = profil bilgisi, PII değil)
- API key'ler Edge Functions'da kalır (bu akışta API çağrısı yok)

---

## Test Cases

### Unit Tests
1. **OnboardingNotifier** — skin type seçimi state güncellemesi
2. **OnboardingNotifier** — concern toggle (add/remove)
3. **OnboardingNotifier** — completeOnboarding çağrısı repo'ya delege ediyor
4. **OnboardingNotifier** — minimum 1 concern validation
5. **OnboardingRepositoryImpl** — saveOnboardingData Supabase çağrısı
6. **OnboardingRepositoryImpl** — markOnboardingCompleted Supabase çağrısı

### Widget Tests
7. **OnboardingScreen** — 4 sayfa render edilir, dot indicator gösterilir
8. **SkinTypePage** — kart seçince vurgulanır
9. **SkinConcernsPage** — chip toggle çalışır, min 1 validation
10. **CameraPermissionPage** — buton render edilir

---

## Implementation Order

1. Database migration (Supabase)
2. Domain layer (enums, repo interface)
3. UserEntity güncelleme + build_runner
4. Data layer (datasource, repo impl)
5. Presentation providers + build_runner
6. Widgets (her ekran bağımsız)
7. OnboardingScreen (PageView entegrasyonu)
8. Router redirect güncellemesi
9. Tests
10. Review & ship
