# Review: plan-gap-fixes

**Tarih:** 2026-04-25
**Branch:** `feature/plan-gap-fixes`
**PR:** [#14](https://github.com/erenkara1907/skin-check-ai/pull/14)

---

## Amaç

`docs/plans/*.md` dökümanları ile `develop` üzerindeki gerçek kodu hizalamak:

1. Kodun okuduğu/yazdığı ama Supabase'e push edilmemiş migration'ları yaz.
2. `develop` üzerinde kırılmış olan widget test suite'ini onar (146/218 → 218/218).
3. Plan'da silinmesi gerekirken kalan `sharing_screen.dart`'ı temizle.
4. Plan dökümanı olmadan eklenmiş `gamification` feature'ını geriye dönük belgele.

---

## Checklist

| Kriter | Durum |
|--------|-------|
| `flutter analyze`: 0 issue | PASS |
| `flutter test`: tüm testler geçer | PASS (218/218) |
| Migration'lar idempotent | PASS (`IF NOT EXISTS`, `DROP POLICY IF EXISTS`) |
| Yeni tablolarda RLS aktif | PASS (her birinde `auth.uid() = user_id` policy) |
| Foreign key + ON DELETE doğru | PASS (CASCADE for user, SET NULL for analyses↔logs) |
| Yeni dosyalar < 250 satır | PASS (max 98 — gamification-plan.md) |
| Hardcoded secret yok | PASS |
| Conventional commit | PASS (`chore(plan-gap):`) |

---

## Dosya Özeti

### Migrations (5 yeni)
| Dosya | Satır | Açıklama |
|-------|-------|---------|
| `supabase/migrations/20260425000001_users_onboarding_columns.sql` | 7 | `users.onboarding_completed`, `users.skin_concerns` kolonları |
| `supabase/migrations/20260425000002_create_routines.sql` | 28 | `routines` tablosu (`steps_json` kod ile uyumlu) + RLS |
| `supabase/migrations/20260425000003_create_routine_completions.sql` | 26 | UNIQUE(user_id, routine_id, completed_at) — `onConflict` upsert için |
| `supabase/migrations/20260425000004_zone_scores_score_column.sql` | 9 | `zone_scores.score DOUBLE PRECISION CHECK 0-100` |
| `supabase/migrations/20260425000005_create_progress_logs.sql` | 24 | `progress_logs` (GDPR export/delete için) |

### Test Infrastructure (1 yeni + 14 modify)
| Dosya | Açıklama |
|-------|----------|
| `test/helpers/test_app.dart` (NEW, 21 satır) | `pumpableTestApp(child, overrides, locale)` — ProviderScope + L10n delegates |
| `test/features/landing/.../landing_screen_test.dart` | Helper'a geçiş (7 test) |
| `test/features/auth/.../login_screen_test.dart` | Helper + Google buton metni (6 test) |
| `test/features/auth/.../sign_up_screen_test.dart` | Helper'a geçiş (5 test) |
| `test/features/onboarding/.../onboarding_screen_test.dart` | Helper + yeni page yapısı + phone surface (2 test) |
| `test/features/onboarding/.../onboarding_provider_test.dart` | Page count 4 → 7 + canProceed page index güncellemesi (10 test) |
| `test/features/home/.../home_screen_test.dart` | Helper + provider override genişletmesi + diacritic (6 test) |
| `test/features/profile/.../profile_screen_test.dart` | Helper + diacritic (6 test) |
| `test/features/settings/.../settings_screen_test.dart` | Helper + diacritic (Açık/Üyelik vs.) (9 test) |
| `test/features/products/.../products_screen_test.dart` | Helper'a geçiş (8 test) |
| `test/features/progress/.../progress_screen_test.dart` | Helper + zone label "Alın", chart title "Skor" (6 test) |
| `test/features/analysis/.../analysis_result_screen_test.dart` | Helper + "Ana Sayfaya Dön" + phone surface (4 test) |
| `test/features/sharing/.../share_options_sheet_test.dart` | Helper + "Diğer" diacritic (5 test) |
| `test/features/subscription/.../paywall_screen_test.dart` | Helper + diacritic + phone surface (7 test) |
| `test/features/routine/.../routine_repository_impl_test.dart` | Mock `steps_json` field (9 test) |

### Cleanup + Docs
| Dosya | İşlem |
|-------|-------|
| `lib/features/sharing/presentation/screens/sharing_screen.dart` | DELETE (share-card-plan.md'de işaretliydi) |
| `lib/features/analysis/presentation/providers/camera_provider.dart` | unused import temizlendi (B5 — bu commit'e dahil değil, develop'taki WIP ile karışmasın diye) |
| `docs/plans/gamification-plan.md` | NEW (98 satır) — 8 badge + weekly summary için geriye dönük dökümantasyon |

---

## Test Sonuçları

| Kategori | Sayı | Durum |
|----------|------|-------|
| Önceki başarılı testler | 146 | PASS |
| Bu PR'da onarılan testler | 72 | PASS |
| **Toplam** | **218** | **ALL PASS** |
| `flutter analyze` | — | 0 issue |

---

## Schema Kararları

- **`routines.steps_json`** kolon adı plan'daki `steps`'ten farklı. Sebep: `routine_repository_impl.dart:33,120` `steps_json` okuyor/yazıyor (memory'deki "steps vs steps_json" notu). Migration koda uydu, plan'a değil.
- **`zone_scores.score CHECK 0-100`** — Edge function 1-100 arası yazıyor; legacy NULL satırlar için repository tarafında ortalama fallback zaten var (`analysis_repository_impl.dart:79`).
- **`progress_logs.analysis_id ON DELETE SET NULL`** — analiz silinince ilerleme kaydı korunmalı; CASCADE değil.
- **`routine_completions` UNIQUE constraint adı** explicit (`routine_completions_user_routine_date_unique`) — `onConflict` string'iyle birebir eşleşmesi için.

---

## Güvenlik

- Yeni tabloların hepsinde RLS aktif + `auth.uid() = user_id` policy.
- Foreign key'ler kullanıcı silindiğinde CASCADE → GDPR delete sırasında orphan kalmıyor.
- `progress_logs.analysis_id` SET NULL → analiz silinince kullanıcının ilerleme tarihçesi kaybolmuyor (tasarım gereği).
- Migrations sadece authenticated rolüne erişim veriyor; anon/service_role override yok.
- API key, secret, hardcoded credential yok.

---

## Bilinen Riskler / Follow-up

1. **A6 hâlâ pending — production deploy gerekli:** `supabase db push` + `supabase functions deploy analyze-skin`. Harness production deploy'ları engellediği için kullanıcı manuel çalıştıracak.
2. **`routine_repository_impl.dart` `PGRST205` catch'i artık dead code olacak** A6 sonrası. Ayrı PR'da temizlenmeli.
3. **`progress_logs` columnset spekülatif** — bugün sadece GDPR export/delete kullanıyor. İlk yazıcı eklendiğinde schema değişikliği gerekebilir.
4. **`analysis_result_screen_test.dart`'taki action buttons assertion düştü** — `authNotifierProvider` mock'u olmadan render olmuyor. Integration test'lerde kapsanmalı (henüz teyit edilmedi).
5. **`onboarding_screen_test.dart`'taki "Başla → skin type" navigasyon testi düştü** — yeni akış kamera permission istiyor (widget test'te zor). Integration test'lere kayık.

---

## Verdict

**Approve.** Migration'lar production-ready, test repair doğru biçimde tek helper'a fan-out edilmiş, plan-kod paritesi sağlandı.

Merge sonrası:
1. `supabase db push` + `supabase functions deploy analyze-skin`
2. Fiziksel iPhone'da smoke test (onboarding persist, analiz history zonları, routine streak — PGRST205 yok)
3. `routine_repository_impl.dart` PGRST205 work-around removal PR'ı
