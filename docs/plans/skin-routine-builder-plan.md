# Feature Plan: skin-routine-builder

**Tarih:** 2026-04-08
**Açıklama:** Kişisel cilt bakım rutini oluşturucu — AI önerili sabah/akşam rutini, düzenleme, günlük hatırlatma, streak takibi

---

## 1. Kapsam

### 1.1 AI Önerili Rutin
- Son analiz sonucundaki `morningRoutine` / `eveningRoutine` verilerini göster
- Sabah / Akşam tab geçişi (güneş/ay ikonları)
- Her adım: sıra no, ürün tipi ikonu, adım adı, neden gerekli, nasıl uygulanır

### 1.2 Kullanıcı Düzenlemesi
- Adım ekle/çıkar
- Sürükle-bırak sıralama (ReorderableListView)
- Aktif rutin olarak Supabase'e kaydet

### 1.3 Günlük Hatırlatma
- flutter_local_notifications + timezone paketi
- Sabah 07:00, akşam 21:00 push notification
- Bildirime tıklayınca rutin ekranına yönlendirme

### 1.4 Rutin Tamamlama
- Her adımın yanında checkbox
- Tüm adımlar tamamlanınca confetti animasyonu
- Streak sayacı (ardışık gün takibi)

### 1.5 Tasarım
- Sol kenar renkli çizgi (gradient)
- Custom checkbox animasyonu
- Smooth tab geçişi
- Streak: alev ikonu + altın/turuncu renk

---

## 2. Veritabanı Değişiklikleri

### Supabase Tabloları

**routines** (yeni tablo):
```sql
CREATE TABLE routines (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('morning', 'evening')),
  steps JSONB NOT NULL DEFAULT '[]',
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE routines ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can CRUD own routines" ON routines
  FOR ALL USING (auth.uid() = user_id);
```

**routine_completions** (yeni tablo):
```sql
CREATE TABLE routine_completions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  routine_id UUID REFERENCES routines(id) ON DELETE CASCADE NOT NULL,
  completed_at DATE NOT NULL DEFAULT CURRENT_DATE,
  completed_steps JSONB NOT NULL DEFAULT '[]',
  UNIQUE(user_id, routine_id, completed_at)
);

ALTER TABLE routine_completions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can CRUD own completions" ON routine_completions
  FOR ALL USING (auth.uid() = user_id);
```

---

## 3. Dosya Planı

### 3.1 Domain Layer
| Dosya | Açıklama |
|-------|----------|
| `lib/features/routine/domain/entities/routine_entity.dart` | Freezed: id, userId, type, steps, isActive, createdAt, updatedAt |
| `lib/features/routine/domain/entities/routine_step_detail_entity.dart` | Freezed: step, productType, reason, howToApply, iconName, isCompleted |
| `lib/features/routine/domain/entities/routine_completion_entity.dart` | Freezed: id, userId, routineId, completedAt, completedSteps |
| `lib/features/routine/domain/entities/streak_entity.dart` | Freezed: currentStreak, longestStreak, lastCompletedDate |
| `lib/features/routine/domain/repositories/routine_repository.dart` | Abstract interface |

### 3.2 Data Layer
| Dosya | Açıklama |
|-------|----------|
| `lib/features/routine/data/datasources/routine_data_source.dart` | Supabase CRUD operasyonları |
| `lib/features/routine/data/repositories/routine_repository_impl.dart` | Repository implementasyonu |

### 3.3 Presentation Layer
| Dosya | Açıklama |
|-------|----------|
| `lib/features/routine/presentation/providers/routine_provider.dart` | Riverpod: rutin CRUD, tab state |
| `lib/features/routine/presentation/providers/routine_completion_provider.dart` | Riverpod: checkbox, streak, tamamlama |
| `lib/features/routine/presentation/screens/routine_screen.dart` | Ana ekran (mevcut dosya güncellenir) |
| `lib/features/routine/presentation/widgets/routine_tab_bar.dart` | Sabah/Akşam tab bar (güneş/ay ikonları) |
| `lib/features/routine/presentation/widgets/routine_step_card.dart` | Adım kartı (renkli kenar, checkbox, detay) |
| `lib/features/routine/presentation/widgets/streak_banner.dart` | Streak göstergesi (alev ikonu) |
| `lib/features/routine/presentation/widgets/add_step_dialog.dart` | Adım ekleme dialog |
| `lib/features/routine/presentation/widgets/empty_routine_view.dart` | Henüz rutin yoksa CTA |

### 3.4 Core / Shared
| Dosya | Açıklama |
|-------|----------|
| `lib/core/services/notification_service.dart` | flutter_local_notifications wrapper |

### 3.5 Paketler (pubspec.yaml)
- `flutter_local_notifications: ^19.0.0`
- `timezone: ^0.10.0`
- `confetti_widget: ^0.4.0`

---

## 4. Uygulama Sırası

1. **Paketler** — pubspec.yaml güncelle, pub get
2. **Domain** — Entity'ler + repository interface (Freezed build)
3. **Data** — DataSource + RepositoryImpl
4. **Notification** — NotificationService
5. **Providers** — Riverpod notifier'lar
6. **Widgets** — Tab bar, step card, streak banner, dialog, empty view
7. **Screen** — RoutineScreen güncelle (tab, list, reorder, confetti)
8. **Router** — Gerekirse güncelle (notification deep link)
9. **Test** — Unit + widget testleri

---

## 5. Test Planı

### Unit Tests
- `routine_repository_impl_test.dart` — CRUD operasyonları mock
- `routine_provider_test.dart` — State yönetimi
- `routine_completion_provider_test.dart` — Streak hesaplama, tamamlama
- `notification_service_test.dart` — Zamanlama doğrulama

### Widget Tests
- `routine_screen_test.dart` — Tab geçişi, adım gösterimi, checkbox
- `routine_step_card_test.dart` — Kart render, checkbox tap
- `streak_banner_test.dart` — Streak gösterimi

---

## 6. Güvenlik

- RLS: Her tablo user_id bazlı erişim
- Steps JSONB validation (malformed data koruması)
- Notification izinleri: permission_handler ile runtime check
- Analiz ID referansları güvenli (user's own data)

---

## 7. Edge Cases

- Analiz yoksa → empty state + "Analiz Yap" CTA
- Notification izni reddedildi → graceful fallback, ayarlardan açma yönlendirmesi
- Offline → cached rutin göster, sync sonra
- Streak hesaplama: timezone-aware (kullanıcının yerel saati)
