# Feature Plan: profile-settings

**Tarih:** 2026-04-08
**Aciklama:** Profil ekrani ve uygulama ayarlari (GDPR uyumlu)

---

## 1. Dosya Listesi

### Domain Layer

| Dosya | Islem | Aciklama |
|-------|-------|----------|
| `lib/features/profile/domain/repositories/profile_repository.dart` | CREATE | Profil guncelleme, hesap silme, veri export interface |

### Data Layer

| Dosya | Islem | Aciklama |
|-------|-------|----------|
| `lib/features/profile/data/datasources/profile_datasource.dart` | CREATE | Supabase profil islemleri (update, delete, export) |
| `lib/features/profile/data/repositories/profile_repository_impl.dart` | CREATE | Repository implementasyonu |

### Presentation Layer — Profile

| Dosya | Islem | Aciklama |
|-------|-------|----------|
| `lib/features/profile/presentation/providers/profile_provider.dart` | CREATE | Profil guncelleme, istatistikler provider |
| `lib/features/profile/presentation/screens/profile_screen.dart` | MODIFY | Tam profil ekrani (avatar, bilgiler, istatistikler) |
| `lib/features/profile/presentation/screens/edit_profile_screen.dart` | CREATE | Isim/email duzenleme ekrani |
| `lib/features/profile/presentation/widgets/profile_header_card.dart` | CREATE | Avatar + isim + plan badge karti |
| `lib/features/profile/presentation/widgets/profile_stats_row.dart` | CREATE | Analiz sayisi, uyelik tarihi |
| `lib/features/profile/presentation/widgets/profile_menu_item.dart` | CREATE | Profil menu itemi (reusable) |

### Presentation Layer — Settings

| Dosya | Islem | Aciklama |
|-------|-------|----------|
| `lib/features/settings/presentation/providers/settings_provider.dart` | CREATE | Tema, bildirim ayarlari provider |
| `lib/features/settings/presentation/screens/settings_screen.dart` | MODIFY | Tam ayarlar ekrani |
| `lib/features/settings/presentation/widgets/settings_section.dart` | CREATE | Gruplu ayar section widget |
| `lib/features/settings/presentation/widgets/settings_tile.dart` | CREATE | Tekil ayar satiri widget |
| `lib/features/settings/presentation/widgets/theme_selector.dart` | CREATE | Tema secimi (Sistem/Acik/Koyu) |
| `lib/features/settings/presentation/widgets/delete_account_dialog.dart` | CREATE | Kirmizi onay dialogu |

### Core / Shared

| Dosya | Islem | Aciklama |
|-------|-------|----------|
| `lib/core/services/notification_service.dart` | CREATE | Bildirim zamanlama servisi |
| `lib/core/providers/theme_provider.dart` | CREATE | ThemeMode provider (shared_preferences) |
| `lib/core/router/app_router.dart` | MODIFY | edit-profile route ekle |
| `lib/features/auth/domain/repositories/auth_repository.dart` | MODIFY | updateProfile, deleteAccount, exportData metotlari ekle |
| `lib/features/auth/data/datasources/supabase_auth_datasource.dart` | MODIFY | updateProfile, deleteAccount, exportData implementasyonu |
| `lib/features/auth/data/repositories/auth_repository_impl.dart` | MODIFY | Yeni metotlarin impl |

### Dependencies (pubspec.yaml)

| Paket | Aciklama |
|-------|----------|
| `shared_preferences` | Tema ve bildirim ayarlari icin local storage |
| `package_info_plus` | Uygulama versiyonu |

---

## 2. Mimari Akis

```
Profile Screen
  ├── ProfileHeaderCard (avatar, isim, plan badge)
  ├── ProfileStatsRow (analiz sayisi, uyelik tarihi)
  └── Menu Items
       ├── Profili Duzenle → EditProfileScreen
       ├── Ayarlar → SettingsScreen (mevcut, genisletilecek)
       └── Cikis Yap

Settings Screen
  ├── Tema Section (Sistem/Acik/Koyu radio)
  ├── Bildirimler Section (toggle + saat)
  ├── Abonelik Section (plan + yonet)
  ├── Hesap Section
  │    ├── Verilerimi Disari Aktar (JSON)
  │    └── Hesabimi Sil (onay dialog)
  └── Hakkinda Section
       ├── Versiyon
       ├── Gizlilik Politikasi (url_launcher)
       └── Kullanim Kosullari (url_launcher)
```

---

## 3. Veritabani Degisiklikleri

Mevcut `users` tablosu `created_at` alani zaten var (Supabase otomatik). Ek degisiklik gerekmez.

**GDPR Hesap Silme Akisi:**
1. `analyses` tablosundaki kullanici kayitlarini sil
2. `zone_scores` → cascade ile silinir
3. `routines` tablosundaki kullanici kayitlarini sil
4. `progress_logs` tablosundaki kullanici kayitlarini sil
5. `skin-photos` bucket'indan kullanici fotolarini sil
6. `users` tablosundan kullanici kaydini sil
7. Supabase Auth'dan kullaniciyi sil (admin API veya Edge Function)

**GDPR Veri Export:**
- `users`, `analyses`, `zone_scores`, `routines`, `progress_logs` → JSON
- `share_plus` ile dosya paylasimi

---

## 4. Tema Yonetimi

- `ThemeMode` (system/light/dark) → `shared_preferences` ile persist
- `themeProvider` → `StateNotifier<ThemeMode>` keepAlive
- `MaterialApp` `themeMode` parametresi bu provider'i dinleyecek
- Mevcut `app_theme.dart` zaten light/dark destekliyor

---

## 5. Bildirim Yonetimi

- `flutter_local_notifications` zaten dependency'de
- Rutin hatirlatma: sabah/aksam saati secimi
- `shared_preferences` ile saat + acik/kapali persist
- `NotificationService`: schedule/cancel daily notification

---

## 6. Guvenlik

- [x] RLS: Supabase'de zaten aktif, kullanici sadece kendi verisini gorebilir
- [x] Hesap silme: Tum tablolardaki veri + Storage fotograflar silinecek
- [x] API key'ler: Sadece Edge Function'larda (admin delete icin gerekirse)
- [x] Signed URL: Fotolar icin signed URL kullanilmaya devam
- [x] Export: Sadece kullanicinin kendi verisi

---

## 7. Test Plani

### Unit Tests
- `profile_repository_impl_test.dart` — updateProfile, deleteAccount, exportData
- `profile_provider_test.dart` — state degisiklikleri
- `settings_provider_test.dart` — tema, bildirim ayarlari
- `theme_provider_test.dart` — ThemeMode persist/load

### Widget Tests
- `profile_screen_test.dart` — header, stats, menu render
- `settings_screen_test.dart` — tum section'lar render, tema secimi
- `delete_account_dialog_test.dart` — onay akisi

---

## 8. Dark Mode

- Tum widget'lar `Theme.of(context).brightness` kontrol edecek
- `AppColors` light/dark varyantlari kullanilacak
- Avatar fallback rengi tema'ya uyumlu

---

## 9. States

- **Loading:** `AppLoading` widget (mevcut)
- **Error:** Snackbar ile hata mesaji
- **Empty:** Analiz sayisi 0 ise "Henuz analiz yapmadiniz" mesaji
