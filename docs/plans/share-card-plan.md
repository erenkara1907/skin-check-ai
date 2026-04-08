# Feature Plan: share-card

**Tarih:** 2026-04-08
**Aciklama:** Instagram Story formatinda paylasılabilir sonuc karti

---

## Ozet

Analiz sonuclarini ve ilerleme verilerini Instagram Story (1080x1920) formatinda
paylasılabilir kart olarak olusturma. RepaintBoundary ile widget'i goruntüye cevirip
share_plus ile paylasma.

---

## Dosya Plani

### 1. Sharing Feature — Domain Layer

| Dosya | Islem | Aciklama |
|---|---|---|
| `lib/features/sharing/domain/entities/share_card_data.dart` | CREATE | Paylasim karti verisi (skor, skinAge, zones) |

### 2. Sharing Feature — Presentation Layer

| Dosya | Islem | Aciklama |
|---|---|---|
| `lib/features/sharing/presentation/widgets/share_card.dart` | CREATE | 1080x1920 Instagram Story kart widget'i |
| `lib/features/sharing/presentation/widgets/mini_face_map.dart` | CREATE | Basitlesmis mini yüz bölge haritasi |
| `lib/features/sharing/presentation/widgets/share_options_sheet.dart` | CREATE | Bottom sheet: Instagram, WhatsApp, Diger |
| `lib/features/sharing/presentation/providers/share_card_provider.dart` | CREATE | Kart → image dönüsümü ve paylasim logic |

### 3. Mevcut Dosya Degisiklikleri

| Dosya | Islem | Aciklama |
|---|---|---|
| `lib/features/analysis/presentation/screens/analysis_result_screen.dart` | MODIFY | Paylas butonunu share_options_sheet'e bagla |
| `lib/features/progress/presentation/screens/progress_screen.dart` | MODIFY | "Ilerleme Paylas" butonu ekle |
| `lib/features/sharing/presentation/screens/sharing_screen.dart` | DELETE | Placeholder kaldir (artik bottom sheet kullanilacak) |
| `lib/core/router/app_router.dart` | MODIFY | /sharing route'u kaldir (bottom sheet ile tetiklenecek) |

---

## Teknik Detaylar

### ShareCardData Entity
```dart
@freezed
class ShareCardData with _$ShareCardData {
  const factory ShareCardData({
    required double overallScore,
    required int skinAge,
    @Default([]) List<ZoneScoreEntity> zones,
    String? label, // "Analiz Sonucu" veya "Haftalik Ilerleme"
  }) = _ShareCardData;
}
```

### ShareCard Widget (1080x1920 oran)
- RepaintBoundary ile sarilmis
- Gradient arka plan: skor bazli renk gecisi
  - score < 40: kirmizi tonlari (#EF4444 → #FCA5A5)
  - score 40-70: sari-turuncu (#FBBF24 → #FDE68A)
  - score > 70: yesil tonlari (#22C55E → #86EFAC)
- Buyuk skor: beyaz, bold, Outfit font
- "Cilt Yasim: X": beyaz, light
- Mini face map: sadece zone skorlarini gösteren basit yüz outline
- CTA: "SkinCheck AI ile analiz et"
- Watermark: App logosu, sag alt, %30 opacity
- AspectRatio(9/16) ile ekranda önizleme

### Widget → Image Dönüsümü
```
RepaintBoundary → RenderRepaintBoundary.toImage() → ByteData → Uint8List
→ temp dosyaya yaz → Share.shareXFiles()
```

### Paylasim Akisi
1. Kullanici "Paylas" butonuna basar
2. ShareOptionsSheet acilir (Instagram, WhatsApp, Diger)
3. Secime göre share_plus ile paylasim yapilir

---

## Veritabani Degisiklikleri

Yok. Tamamen client-side özellik.

---

## Guvenlik

- Paylasilan kartta kisisel bilgi yok (sadece skor ve yas)
- Foto paylasılmiyor, sadece olusturulan kart
- Gecici dosyalar paylasimdan sonra temizlenir

---

## Test Plani

### Unit Tests
- `share_card_provider_test.dart`: Provider state testleri

### Widget Tests
- `share_card_test.dart`: Kart render ediliyor mu, skor doğru mu
- `share_options_sheet_test.dart`: Bottom sheet aciliyor mu, secenekler var mi
- `mini_face_map_test.dart`: Widget render testi

---

## Uygulama Sirasi

1. Domain: ShareCardData entity + code gen
2. Presentation: ShareCard widget + MiniF aceMap + ShareOptionsSheet
3. Provider: share_card_provider (image capture + share logic)
4. Integration: AnalysisResultScreen + ProgressScreen tetikleyicileri
5. Router cleanup: /sharing route'u kaldir
6. Test yaz
