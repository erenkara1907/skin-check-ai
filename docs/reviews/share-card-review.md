# Review: share-card

**Tarih:** 2026-04-08

## Checklist

| Kriter | Durum |
|---|---|
| `flutter analyze`: 0 issue | PASS |
| Max 250 satir/dosya | PASS (max 247) |
| Widget'larda business logic yok | PASS |
| Hardcoded secret yok | PASS |
| Dark mode destegi | PASS |
| Loading/error/empty state | PASS (provider bool state) |

## Dosya Ozeti

| Dosya | Satir | Islem |
|---|---|---|
| `lib/features/sharing/domain/entities/share_card_data.dart` | 20 | CREATE |
| `lib/features/sharing/presentation/widgets/share_card.dart` | 164 | CREATE |
| `lib/features/sharing/presentation/widgets/mini_face_map.dart` | 104 | CREATE |
| `lib/features/sharing/presentation/widgets/share_options_sheet.dart` | 139 | CREATE |
| `lib/features/sharing/presentation/providers/share_card_provider.dart` | 77 | CREATE |
| `lib/features/analysis/presentation/widgets/result_zone_section.dart` | 53 | CREATE |
| `lib/features/analysis/presentation/screens/analysis_result_screen.dart` | 247 | MODIFY |
| `lib/features/progress/presentation/screens/progress_screen.dart` | 198 | MODIFY |
| `lib/core/router/app_router.dart` | 170 | MODIFY |

## Test Sonuclari

- 18/18 test gecti
- share_card_test.dart: 9 test (skor, yas, CTA, watermark, label, RepaintBoundary, gradient varyantlari)
- share_options_sheet_test.dart: 5 test (render, tap callbacks)
- mini_face_map_test.dart: 4 test (render, skorlar, custom size, empty)

## Guvenlik

- Kisisel bilgi paylasılmiyor (sadece skor + yas)
- Foto paylasılmiyor
- Gecici dosyalar paylasim sonrasi siliniyor
- API key yok, client-side ozellik

## Notlar

- Placeholder `SharingScreen` hala mevcut ama artik route'dan kaldirildi
- Share islemi bottom sheet uzerinden tetikleniyor (navigation yerine)
- 9:16 aspect ratio Instagram Story uyumlu
