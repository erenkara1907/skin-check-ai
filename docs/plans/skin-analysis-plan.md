# Feature Plan: skin-analysis

**Tarih:** 2026-04-08
**Açıklama:** Kamera modülü, AI cilt analiz pipeline'ı (Supabase Edge Function + GPT-4o Vision), ve analiz sonuç ekranı.

---

## Genel Bakış

3 ana bölüm:
- **A) Kamera Ekranı** — Ön kamera, yüz tespiti, ışık kontrolü, çekim, upload
- **B) Supabase Edge Function** — GPT-4o Vision ile cilt analizi, DB kayıt
- **C) Analiz Sonuç Ekranı** — Skor animasyonu, interaktif yüz haritası, bölge detayları

---

## Dosya Planı

### Domain Layer

| Dosya | Açıklama |
|-------|----------|
| `lib/features/analysis/domain/entities/analysis_entity.dart` | Freezed: AnalysisEntity (id, userId, photoUrl, overallScore, skinAge, summary, zones, suggestedRoutine) |
| `lib/features/analysis/domain/entities/zone_score_entity.dart` | Freezed: ZoneScoreEntity (zone, score, concerns, severity, recommendations) |
| `lib/features/analysis/domain/entities/routine_step_entity.dart` | Freezed: RoutineStepEntity (step, productType, reason) |
| `lib/features/analysis/domain/entities/skin_zone.dart` | Enum: 7 yüz bölgesi (forehead, leftCheek, rightCheek, nose, chin, underEyes, jawline) — Türkçe label'lar |
| `lib/features/analysis/domain/repositories/analysis_repository.dart` | Interface: captureAndUpload, analyzePhoto, getAnalysis, getHistory |

### Data Layer

| Dosya | Açıklama |
|-------|----------|
| `lib/features/analysis/data/datasources/analysis_datasource.dart` | Supabase calls: upload photo, invoke edge function, fetch results |
| `lib/features/analysis/data/datasources/camera_datasource.dart` | Camera controller, ML Kit face detection, light sensor |
| `lib/features/analysis/data/repositories/analysis_repository_impl.dart` | Repository implementation |

### Presentation Layer — Providers

| Dosya | Açıklama |
|-------|----------|
| `lib/features/analysis/presentation/providers/camera_provider.dart` | CameraNotifier: camera init, face detection state, light level, capture, countdown |
| `lib/features/analysis/presentation/providers/analysis_provider.dart` | AnalysisNotifier: upload → analyze → result state management |

### Presentation Layer — Screens

| Dosya | Açıklama |
|-------|----------|
| `lib/features/analysis/presentation/screens/camera_screen.dart` | Kamera ekranı: preview + overlay + capture button |
| `lib/features/analysis/presentation/screens/analysis_screen.dart` | Güncelle: placeholder → home hub (geçmiş analizler veya "ilk analiz" CTA) |
| `lib/features/analysis/presentation/screens/analysis_result_screen.dart` | Sonuç ekranı: skor, yüz haritası, bölge detayları |

### Presentation Layer — Widgets

| Dosya | Açıklama |
|-------|----------|
| `lib/features/analysis/presentation/widgets/face_oval_overlay.dart` | CustomPainter: oval yüz çerçevesi (cutout) |
| `lib/features/analysis/presentation/widgets/capture_button.dart` | Büyük yuvarlak çekim butonu + geri sayım |
| `lib/features/analysis/presentation/widgets/camera_guidance_bar.dart` | Yüz tespiti & ışık uyarı mesajları |
| `lib/features/analysis/presentation/widgets/face_zone_map.dart` | CustomPainter: interaktif 7-bölge yüz haritası |
| `lib/features/analysis/presentation/widgets/zone_detail_sheet.dart` | BottomSheet: bölge detay (skor, sorunlar, severity, öneriler) |
| `lib/features/analysis/presentation/widgets/analysis_loading.dart` | Shimmer analiz loading animasyonu |

### Edge Function

| Dosya | Açıklama |
|-------|----------|
| `supabase/functions/analyze-skin/index.ts` | Deno Edge Function: photo → GPT-4o Vision → parse → DB kayıt → response |

### Router Güncelleme

| Dosya | Değişiklik |
|-------|-----------|
| `lib/core/router/app_router.dart` | Yeni route'lar: `/analyze/camera`, `/analyze/result/:id` |

### Tests

| Dosya | Açıklama |
|-------|----------|
| `test/features/analysis/domain/entities/analysis_entity_test.dart` | Entity serialization tests |
| `test/features/analysis/data/repositories/analysis_repository_impl_test.dart` | Repository unit tests (mocktail) |
| `test/features/analysis/presentation/providers/analysis_provider_test.dart` | Provider state tests |
| `test/features/analysis/presentation/screens/analysis_result_screen_test.dart` | Widget test: sonuç ekranı |

---

## Database Değişiklikleri

Edge Function zaten var olan `analyses` ve `zone_scores` tablolarına yazacak (DB schema önceki sprint'te oluşturuldu). Edge function ayrıca signed URL oluşturacak.

---

## Akış

```
[Kamera Ekranı]
  ↓ Ön kamera açılır
  ↓ ML Kit yüz tespit eder
  ↓ Kullanıcı çekim butonuna basar
  ↓ 3-2-1 geri sayım
  ↓ Flash efekti + çekim
  ↓ Fotoğraf Supabase Storage'a upload

[Loading Ekranı]
  ↓ "Cildiniz analiz ediliyor..." shimmer
  ↓ Edge Function çağrılır

[Edge Function]
  ↓ Signed URL al
  ↓ GPT-4o Vision API'ye gönder
  ↓ JSON parse
  ↓ analyses + zone_scores tablolarına kaydet
  ↓ Response döndür

[Sonuç Ekranı]
  ↓ Genel skor (count-up animasyon)
  ↓ Cilt yaşı
  ↓ İnteraktif yüz haritası (7 bölge)
  ↓ Bölge tap → BottomSheet detay
  ↓ "Rutin Oluştur" + "Paylaş" butonları
```

---

## Güvenlik

- API key (OpenAI) SADECE Edge Function environment'ta — asla client'ta
- Fotoğraflar private bucket'ta, signed URL ile erişim
- RLS: user sadece kendi analizlerini görebilir
- Fotoğraf upload max 10MB sınırı
- Edge Function auth header kontrolü (JWT verify)

---

## Tasarım Detayları

- **Kamera:** Full screen, siyah arka plan, beyaz/transparan oval guide
- **Sonuç:** Beyaz arka plan, glassmorphism kartlar
- **Skor renkleri:** kırmızı <40, sarı 40-70, yeşil >70 (AppColors.scoreColor)
- **Animasyonlar:** flutter_animate staggered reveal, ScoreCircle count-up
- **Dark mode:** Tüm ekranlar dark mode destekli
- **Yüz haritası:** Her bölge kendi skor renginde, tap ile etkileşim
