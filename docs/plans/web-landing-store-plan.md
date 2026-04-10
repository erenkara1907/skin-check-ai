# Feature Plan: web-landing-store

**Tarih:** 2026-04-08
**Açıklama:** Web landing page, store listing hazırlığı (app icon, splash screen, store description), final kontroller

---

## BÖLÜM A — Landing Page (Flutter Web)

### Dosya Yapısı

```
lib/features/landing/
├── presentation/
│   ├── screens/
│   │   └── landing_screen.dart          # Ana landing sayfası (ScrollView)
│   └── widgets/
│       ├── landing_hero_section.dart     # Hero bölümü
│       ├── landing_how_it_works.dart     # 3 adım
│       ├── landing_features_section.dart # 4 özellik
│       ├── landing_pricing_section.dart  # Free vs Pro
│       ├── landing_faq_section.dart      # 5 soru accordion
│       └── landing_footer.dart          # Footer
```

### Değiştirilecek Dosyalar

| Dosya | Değişiklik |
|-------|-----------|
| `lib/core/router/app_router.dart` | `/landing` route ekle, web'de kIsWeb + unauthenticated → landing redirect |
| `lib/core/router/app_router.dart` | `AppRoutes.landing` sabiti ekle |
| `lib/main.dart` | Web'de portrait lock kaldır |
| `pubspec.yaml` | `url_launcher` zaten var — ek paket gerekmez |

### Tasarım Detayları

- **Hero Section:**
  - Başlık: "Cildini AI ile Analiz Et" (displayLarge, gradient text)
  - Alt başlık: Kısa açıklama
  - CTA butonu: "Hemen Başla" → /login'e yönlendir
  - App Store / Google Play badge'leri (placeholder SVG/image)
  - Sağ tarafta telefon mockup (Container ile simüle)
  - Glassmorphism arka plan efekti

- **Nasıl Çalışır (How It Works):**
  - 3 adım: Selfie Çek → AI Analiz → Rutin Al
  - Her adımda Lucide ikon + başlık + açıklama
  - Numaralı step indicator

- **Özellikler (Features):**
  - 4 özellik kartı: AI Analiz, Kişisel Rutin, İlerleme Takibi, Ürün Önerileri
  - Her kart: ikon + başlık + açıklama + mockup placeholder
  - Glassmorphism kart stili

- **Fiyatlandırma (Pricing):**
  - 2 kart: Free vs Pro
  - Free: Günlük 1 analiz, Temel rutin, Reklam var
  - Pro: Sınırsız analiz, Detaylı rutin, Ürün önerileri, Reklamsız
  - Pro kartı highlighted (primary border)

- **FAQ:**
  - ExpansionTile ile accordion
  - 5 soru: AI nasıl çalışır, Fotoğraflar güvende mi, Pro farkı, İptal, Desteklenen cihazlar

- **Footer:**
  - Logo + uygulama adı
  - Linkler: Gizlilik, Kullanım Koşulları, İletişim
  - Sosyal medya ikonları (placeholder)

### Responsive Strateji

- **Mobile (<768px):** Tek sütun, dikey layout
- **Tablet (768-1024px):** 2 sütun grid
- **Desktop (>1024px):** Max width 1200px, centered, hero yan yana

### Animasyonlar

- flutter_animate paketi (zaten var) ile:
  - FadeIn + SlideIn animasyonları her bölüm için
  - Staggered animasyonlar

---

## BÖLÜM B — Store Hazırlığı

### App Icon

| Dosya | Değişiklik |
|-------|-----------|
| `pubspec.yaml` | `flutter_launcher_icons` dev dependency ekle |
| `flutter_launcher_icons.yaml` | İkon konfigürasyonu |
| `assets/icon/app_icon.png` | 1024x1024 ikon (programmatic olarak oluşturulacak — basit gradient + sparkle) |

- **Tasarım:** Primary gradient (#6C63FF → #00D9A6) arka plan, beyaz yüz silueti + sparkle efekti
- Not: Gerçek PNG asset gerekli — flutter_launcher_icons ile generate

### Splash Screen

| Dosya | Değişiklik |
|-------|-----------|
| `pubspec.yaml` | `flutter_native_splash` dev dependency ekle |
| `flutter_native_splash.yaml` | Splash konfigürasyonu |

- **Tasarım:** Primary-to-secondary gradient arka plan, ortalanmış logo/uygulama adı

### Store Listing

| Dosya | Değişiklik |
|-------|-----------|
| `docs/store-listing.md` | App Store + Google Play açıklama metni (TR + EN) |

---

## BÖLÜM C — Final Kontroller

### Kontrol Listesi

1. `flutter analyze` → 0 issue
2. `flutter test` → tüm testler geçmeli
3. `flutter build web` → web build çalışmalı
4. `flutter build apk` → APK oluşmalı
5. `README.md` güncelle (proje açıklaması, kurulum, özellikler)

---

## Test Planı

### Unit Tests
- Yok (landing page pure UI, business logic yok)

### Widget Tests

| Test | Açıklama |
|------|----------|
| `test/features/landing/landing_screen_test.dart` | Tüm bölümlerin render edildiğini doğrula |
| | Hero başlık, CTA butonu görünürlüğü |
| | FAQ accordion açılıp kapanması |
| | Footer linkleri |

---

## Güvenlik

- Landing page public (auth gerektirmez)
- Harici link yok (store badge'leri placeholder)
- Kullanıcı verisi işlenmiyor
- XSS riski yok (statik içerik)

---

## Veritabanı Değişiklikleri

Yok — tamamen frontend feature.

---

## Bağımlılıklar

| Paket | Versiyon | Neden |
|-------|---------|-------|
| `flutter_launcher_icons` | ^0.14.3 | App icon generation |
| `flutter_native_splash` | ^2.4.5 | Splash screen |

---

## Dosya Özeti

### Yeni Dosyalar (8)
1. `lib/features/landing/presentation/screens/landing_screen.dart`
2. `lib/features/landing/presentation/widgets/landing_hero_section.dart`
3. `lib/features/landing/presentation/widgets/landing_how_it_works.dart`
4. `lib/features/landing/presentation/widgets/landing_features_section.dart`
5. `lib/features/landing/presentation/widgets/landing_pricing_section.dart`
6. `lib/features/landing/presentation/widgets/landing_faq_section.dart`
7. `lib/features/landing/presentation/widgets/landing_footer.dart`
8. `docs/store-listing.md`

### Değiştirilecek Dosyalar (4)
1. `lib/core/router/app_router.dart` — landing route + web redirect
2. `lib/main.dart` — web'de orientation lock kaldır
3. `pubspec.yaml` — yeni paketler
4. `README.md` — proje açıklaması güncelle

### Test Dosyaları (1)
1. `test/features/landing/landing_screen_test.dart`

### Config Dosyaları (2)
1. `flutter_launcher_icons.yaml`
2. `flutter_native_splash.yaml`
