# ============================================================
# SkinCheck AI — PLUGIN KURULUMU + FEATURE PROMPT'LARI
# ============================================================


# ████████████████████████████████████████████████████████████
# BÖLÜM A: EKSİK PLUGİN/SKİLL KURULUMLARI
# ████████████████████████████████████████████████████████████
#
# Claude Code içinde (skincheck_ai projesindeyken) bunları çalıştır:
#
# ─── Tasarım zekası (renk, font, stil, UX kuralları — Flutter destekli) ───
# /plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill
# /plugin install ui-ux-pro-max@ui-ux-pro-max-skill
#
# ─── Flutter SDLC (19 agent: UI, test, deploy, vs.) ───
# /plugin marketplace add cleydson/flutter-claude-code
# /plugin install flutter-all@flutter-claude-code
#
# ─── Anthropic resmi frontend design ───
# /plugin install frontend-design@claude-plugins-official
#
# ─── Anthropic resmi security guidance ───
# /plugin install security-guidance@claude-plugins-official
#
# ─── Flutter-Craft (brainstorm/plan/execute döngüsü) ───
# /plugin marketplace add vp-k/flutter-craft
# /plugin install flutter-craft@vp-k/flutter-craft
#
# Kurulumu doğrula:
# /plugins
#
# Şunları görmen lazım:
# - ui-ux-pro-max ✔ enabled
# - flutter-all ✔ enabled
# - frontend-design ✔ enabled
# - security-guidance ✔ enabled
# - flutter-craft ✔ enabled
#
# Bu plugin'ler ne yapıyor:
# - ui-ux-pro-max: Claude'a "health/skincare SaaS uygulaması yap"
#   dediğinde otomatik aktive olur, uygun renk paleti, font,
#   glassmorphism stili, UX kuralları önerir
# - flutter-all: Flutter'a özel 19 agent — UI geliştirme, state
#   management, test yazma, performance optimizasyon
# - frontend-design: Generic AI estetiğini engeller, bold/premium
#   tasarım kararları almasını sağlar
# - security-guidance: Güvenlik kontrollerini otomatik yapar
# - flutter-craft: Clean Architecture pattern'lerini enforce eder


# ████████████████████████████████████████████████████████████
# BÖLÜM B: FEATURE PROMPT'LARI (Sırasıyla)
# ████████████████████████████████████████████████████████████
#
# Her prompt'u Claude Code'da /feature ile çalıştır.
# Claude planlar → sen onaylar → geri kalan otomatik.
# Her feature bitince yeni session aç (claude --continue veya yeni claude).
#
# ÖNEMLİ: Prompt'ları aynen kopyala-yapıştır yap.
# ████████████████████████████████████████████████████████████


# ──────────────────────────────────────────────────────────
# FEATURE 1: Proje Scaffold + Design System + Core
# Tahmini süre: 1-2 saat
# ──────────────────────────────────────────────────────────

/feature Proje scaffold ve core katmanı oluştur.

1. pubspec.yaml'a şu paketleri ekle:
   flutter_riverpod, riverpod_annotation, riverpod_generator
   go_router, supabase_flutter
   camera, image_picker, google_mlkit_face_detection
   dio, freezed_annotation, freezed, json_serializable, build_runner
   flutter_secure_storage, share_plus, fl_chart
   cached_network_image, flutter_animate, logger, lucide_icons
   permission_handler, url_launcher, path_provider

2. CLAUDE.md'deki Feature-First klasör yapısını oluştur.
   Her feature için domain/, data/, presentation/ alt klasörlerini oluştur.

3. Core katmanı kodla:
   - core/theme/app_theme.dart: Light + Dark tema.
     Primary #6C63FF, Secondary #00D9A6.
     Google Fonts: Outfit (headlines), Plus Jakarta Sans (body).
     Card tema: 16px radius, glassmorphism efekt (blur + transparency).
     Buton tema: rounded, elevation 0, bold text.
   - core/theme/app_colors.dart: Tüm renk sabitleri.
   - core/theme/app_text_styles.dart: Typography scale.
   - core/router/app_router.dart: GoRouter tüm route tanımları
     (şimdilik placeholder sayfalarla).
   - core/services/supabase_service.dart: Supabase client init.
   - core/constants/app_constants.dart: API URL, storage bucket adı vs.
   - core/utils/logger.dart: Logger wrapper.

4. Shared widgets:
   - shared/widgets/app_button.dart: Primary, secondary, outline, text varyantları.
     Animasyonlu press efekti, loading state.
   - shared/widgets/app_card.dart: Glassmorphism card (BackdropFilter + blur).
     Shadow, border-radius 16, dark mode uyumlu.
   - shared/widgets/app_loading.dart: Branded loading indicator (animasyonlu logo).
   - shared/widgets/score_circle.dart: Animasyonlu circular score göstergesi
     (0'dan hedefe count-up). Renk: kırmızı <40, sarı 40-70, yeşil >70.
   - shared/widgets/gradient_background.dart: Sayfa arka plan gradienti.

5. main.dart: ProviderScope, MaterialApp.router, tema geçişi.

6. Tasarım premium ve modern olsun. Default Flutter look YASAK.


# ──────────────────────────────────────────────────────────
# FEATURE 2: Supabase Veritabanı + Auth Sistemi
# Tahmini süre: 2-3 saat
# ──────────────────────────────────────────────────────────

/feature Supabase veritabanı şeması ve auth sistemi.

BÖLÜM A — Veritabanı (Supabase MCP kullan):
1. Tablolar: users, analyses, zone_scores, routines, products,
   progress_logs, user_goals (CLAUDE.md'deki şemaya göre)
2. Enum types: skin_type_enum (normal, oily, dry, combination),
   zone_enum (forehead, nose, cheek_left, cheek_right, chin, eye_area, lip_area),
   routine_type_enum (morning, evening)
3. Foreign key ilişkileri ve index'ler
4. RLS policies: her kullanıcı sadece kendi datasını görsün.
   products tablosu tüm authenticated kullanıcılar okuyabilsin.
5. Storage: "skin-photos" private bucket, max 5MB, image/* only

BÖLÜM B — Auth Feature:
1. domain/: User entity (Freezed), AuthRepository interface
2. data/: SupabaseAuthDataSource, AuthRepositoryImpl
3. presentation/:
   - LoginScreen: Email/password alanları + "Google ile Giriş" butonu
     + "Apple ile Giriş" butonu (iOS only göster)
   - SignUpScreen: İsim, email, password alanları
   - AuthProvider: Riverpod AsyncNotifier, auth state management
   - GoRouter redirect: giriş yapmamışsa login'e yönlendir

TASARIM:
- Login kartı: Glassmorphism card, merkeze hizalı
- Arka plan: Gradient (#6C63FF → #00D9A6 diagonal)
- Logo/app adı üstte, animasyonlu
- Sosyal login butonları: Google (beyaz bg, Google logosu),
  Apple (siyah bg, Apple logosu) — altta yan yana
- Input alanları: Rounded, subtle border, focus animasyonu
- Dark mode'da gradient daha koyu tonlarda


# ──────────────────────────────────────────────────────────
# FEATURE 3: Onboarding Akışı
# Tahmini süre: 1-2 saat
# ──────────────────────────────────────────────────────────

/feature Yeni kullanıcı onboarding akışı (4 ekran).

Ekran 1 — Hoşgeldin:
- Büyük animasyonlu app logosu (üstte)
- "Cildini tanı, güzelliğini keşfet" tagline
- Basit illüstrasyon veya ikon (yüz + sparkle)
- "Başla" butonu (primary, full width)

Ekran 2 — Cilt Tipi Seçimi:
- "Cilt tipin hangisi?" başlık
- 4 seçenek kartı (2x2 grid):
  Normal (damla ikonu), Yağlı (parlama ikonu),
  Kuru (çatlak ikonu), Karma (yarım-yarım ikonu)
- Her kart: ikon + isim + 1 satır açıklama
- Seçilince kart vurgulanır (border rengi değişir + scale animasyonu)

Ekran 3 — Hedef Belirleme:
- "En çok neyi iyileştirmek istiyorsun?" başlık
- Chip'ler (wrap layout): Akne, Kırışıklık, Leke, Gözenekler,
  Kuruluk, Yağlanma, Koyu Halka, Kızarıklık
- Multi-select (minimum 1)
- Seçili chip: primary renk dolgulu, beyaz yazı

Ekran 4 — Kamera İzni:
- Kamera ikonu (büyük, merkez)
- "Cilt analizin için kameraya ihtiyacımız var" açıklama
- "Analizimi Başlat" butonu → kamera izni iste → ana sayfaya yönlendir

Genel:
- Sayfa göstergesi (dots indicator, altta)
- PageView ile swipe geçiş + custom animasyonlar
- Seçimleri Supabase'e kaydet (users tablosu güncelle)
- onboarding_completed = true bittiğinde
- GoRouter: onboarding tamamlanmışsa bir daha gösterme


# ──────────────────────────────────────────────────────────
# FEATURE 4: Kamera + AI Cilt Analizi (ANA FEATURE)
# Tahmini süre: 3-4 saat
# ──────────────────────────────────────────────────────────

/feature Kamera modülü ve AI cilt analiz pipeline'ı.

BÖLÜM A — Kamera Ekranı:
- Ön kamera (selfie modu) aç
- Oval yüz çerçevesi overlay (CustomPainter)
- Google ML Kit Face Detection ile yüz tespiti
- Yüz tespit edilmezse: "Yüzünüzü çerçeveye hizalayın" mesajı
- Işık seviyesi sensörü: çok karanlıksa "Daha aydınlık ortama geçin" uyarısı
- Çekim butonu (büyük, yuvarlak, altta ortada)
- 3-2-1 geri sayım animasyonu
- Çekim anında kısa flash efekti
- Fotoğrafı Supabase Storage private bucket'a yükle

BÖLÜM B — Supabase Edge Function:
- "analyze-skin" adında Deno Edge Function oluştur
- Input: photo_url, user_id
- Storage'dan signed URL al
- GPT-4o Vision API'ye gönder (API key Edge Function env'de)
- System prompt: "You are a skin health analyst."
- User prompt: "Analyze this selfie. Return ONLY valid JSON:
  {overall_score: 1-100, skin_age: number, summary: string,
   zones: [{zone: string, score: 1-100, concerns: [string],
   severity: 1-10, recommendations: [string]}],
   suggested_routine: {morning: [{step, product_type, reason}],
   evening: [{step, product_type, reason}]}}"
- Parse response, analyses tablosuna kaydet, zone_scores'a her bölgeyi kaydet
- Response'u client'a döndür

BÖLÜM C — Analiz Sonuç Ekranı:
- Loading state: "Cildiniz analiz ediliyor..." animasyonlu shimmer efekti
- Sonuç reveal: üstten alta sıralı animasyon (flutter_animate staggered)
- Genel skor: ScoreCircle widget (büyük, ortada, 0'dan X'e count-up)
- "Cilt Yaşın: X" altında (gerçek yaşla karşılaştırma metni)
- İnteraktif yüz haritası:
  - CustomPainter ile yüz silüeti, 7 bölge farklı renklerde
  - Her bölgeye tap → BottomSheet açılsın:
    Bölge adı, skor dairesi, sorunlar listesi, severity bar (gradient),
    öneriler listesi (her biri kart içinde)
- Alt kısımda 2 buton:
  "Rutin Oluştur" (primary) + "Paylaş" (outline, share ikonu)

TASARIM:
- Kamera: Full screen, siyah arka plan, oval guide beyaz/transparan
- Sonuç: Beyaz arka plan, glassmorphism kartlar
- Skor renkleri: kırmızı gradient <40, sarı 40-70, yeşil >70
- Bölge haritası: her bölge kendi skor renginde
- Animasyonlar akıcı ve professional


# ──────────────────────────────────────────────────────────
# FEATURE 5: Cilt Bakım Rutini
# Tahmini süre: 2 saat
# ──────────────────────────────────────────────────────────

/feature Kişisel cilt bakım rutini oluşturucu.

1. Son analiz sonucuna göre AI'ın önerdiği rutin:
   - Sabah rutini + Akşam rutini (tab geçişli)
   - Tab ikonları: güneş (sabah), ay (akşam)
   - Her adım: sıra numarası, ürün tipi ikonu, adım adı,
     neden gerekli (1 satır), nasıl uygulanır

2. Kullanıcı düzenlemesi:
   - Adım ekle/çıkar butonu
   - Sürükle-bırak sıralama (ReorderableListView)
   - Aktif rutin olarak kaydet

3. Günlük hatırlatma:
   - Push notification: sabah 07:00, akşam 21:00
   - Bildirime tıklayınca rutin ekranı açılsın

4. Rutin tamamlama:
   - Her adımın yanında checkbox
   - Tüm adımlar tamamlanınca confetti animasyonu
   - Streak sayacı (kaç gün üst üste tamamladın)

TASARIM:
- Adım kartları: Sol kenarında renkli çizgi (adım sırasına göre gradient)
- Checkbox: custom animasyonlu (tik efekti)
- Tab geçişi: smooth slide animasyonu
- Streak: alev ikonu + sayı, altın/turuncu renk


# ──────────────────────────────────────────────────────────
# FEATURE 6: Ürün Önerileri
# Tahmini süre: 1-2 saat
# ──────────────────────────────────────────────────────────

/feature Cilt bakım ürün önerileri sistemi.

1. Supabase products tablosuna örnek ürünler ekle (20-30 ürün):
   - Kategoriler: Temizleyici, Tonik, Serum, Nemlendirici, SPF, Göz Kremi
   - Her ürüne: isim, marka, fiyat aralığı, uygun sorunlar (concerns),
     placeholder image URL, affiliate URL

2. Ürün eşleştirme: kullanıcının zone_scores'undaki concerns ile
   products tablosundaki suitable_concerns eşleştir

3. Ürün listesi ekranı:
   - Kategoriye göre horizontal scroll bölümler
   - Her ürün kartı: ürün görseli, isim, marka, fiyat, rating yıldızları
   - "Satın Al" butonu → affiliate link aç (url_launcher)
   - "Neden bu ürün?" butonu → kısa AI açıklaması

4. Analiz sonuç ekranından erişim:
   - "Önerilen Ürünler" bölümü sonuç ekranının altında

TASARIM:
- Ürün kartları: Compact, yatay scroll, beyaz bg, subtle shadow
- Kategori başlıkları: Sol hizalı, bold
- "Satın Al" butonu: secondary renk, küçük


# ──────────────────────────────────────────────────────────
# FEATURE 7: İlerleme Takibi
# Tahmini süre: 2 saat
# ──────────────────────────────────────────────────────────

/feature Haftalık ilerleme takibi ve cilt değişim görselleştirme.

1. İlerleme Dashboard:
   - Üst kısım: 3 metrik kartı yan yana
     (Mevcut Skor, Cilt Yaşı, Toplam Analiz Sayısı)
   - Ortada: Skor trendi grafiği (fl_chart LineChart)
     X: tarih, Y: skor. Çizgi rengi: yeşil yukarı trend, kırmızı aşağı
   - "En çok gelişen bölge" badge (yıldız ikonu + bölge adı)

2. Fotoğraf karşılaştırma:
   - Slider: sol tarafta ilk analiz fotoğrafı, sağ tarafta son
   - Parmakla slider'ı kaydırınca before/after geçişi
   - Her fotoğrafın altında tarih + skor

3. Bölge bazlı ilerleme:
   - 7 bölgenin her biri için mini progress bar
   - Artış/azalış ok ikonu + yüzde değişim

4. Haftalık hatırlatma:
   - "Bu hafta analizini yaptın mı?" push notification
   - Streak sistemi: kaç hafta üst üste analiz

TASARIM:
- Dashboard: Clean, metric kartları üstte (glassmorphism)
- Grafik: Smooth curved line, gradient fill altında
- Photo compare: Full width, drag handle ortada
- Dark mode'da grafik renkleri parlak


# ──────────────────────────────────────────────────────────
# FEATURE 8: Paylaşım Kartı (Viral Motor)
# Tahmini süre: 1-2 saat
# ──────────────────────────────────────────────────────────

/feature Instagram Story formatında paylaşılabilir sonuç kartı.

1. Paylaşım kartı widget'ı (1080x1920 oran):
   - Gradient arka plan (skor bazlı: kırmızı→sarı→yeşil)
   - Ortada: büyük genel skor (beyaz, bold, 72px)
   - Altında: "Cilt Yaşım: X" (beyaz, 36px)
   - Mini yüz bölge haritası (simplified, küçük)
   - "SkinCheck AI ile analiz et" CTA text (altta)
   - App logosu watermark (sağ alt, %30 opacity)

2. Teknik:
   - RepaintBoundary ile widget → Image dönüşümü
   - share_plus ile paylaş (Instagram Story, WhatsApp, genel)
   - Paylaşım seçenekleri bottom sheet: Instagram, WhatsApp, Diğer

3. Tetikleyiciler:
   - Analiz sonuç ekranında "Paylaş" butonu
   - İlerleme ekranında "İlerleme paylaş" butonu

TASARIM:
- Kart: Premium, minimalist, Instagram'da dikkat çekici
- Tipografi: Bold skor, light detaylar
- Watermark subtle ama okunabilir


# ──────────────────────────────────────────────────────────
# FEATURE 9: Paywall + Abonelik
# Tahmini süre: 2 saat
# ──────────────────────────────────────────────────────────

/feature Freemium paywall sistemi.

1. RevenueCat entegrasyonu:
   - purchases_flutter paketi ekle
   - RevenueCat init (API key env'den)
   - Entitlement check: "pro" entitlement

2. Free vs Pro sınırları:
   Free: Haftada 1 analiz, genel skor, paylaşım kartı
   Pro ($5.99/ay veya $49.99/yıl):
   - Sınırsız analiz
   - Bölge bazlı detaylı harita
   - Cilt yaşı özelliği
   - Rutin oluşturucu
   - İlerleme takibi + grafik
   - Time-lapse
   - Reklamsız

3. Paywall ekranı:
   - "Pro'ya Geç" başlık
   - Free vs Pro karşılaştırma tablosu (check/cross ikonları)
   - Fiyat kartları: Aylık ($5.99) + Yıllık ($49.99, "%30 tasarruf" badge)
   - "7 Gün Ücretsiz Dene" CTA butonu (büyük, primary)
   - "Satın almayı geri yükle" text butonu (altta, küçük)
   - Yasal linkler: Gizlilik, Kullanım Koşulları

4. Paywall tetikleyicileri:
   - Free kullanıcı bölge haritasına tıklarsa → paywall
   - Free kullanıcı haftalık limitini doldurduysa → paywall
   - Settings'te "Pro'ya Geç" butonu

TASARIM:
- Paywall: Full screen, gradient arka plan
- Pro özellikleri: altın/premium ikonlarla
- CTA: Büyük, animasyonlu, dikkat çekici
- Fiyat kartı: seçili olan büyük + vurgulu border


# ──────────────────────────────────────────────────────────
# FEATURE 10: Profil + Settings + GDPR
# Tahmini süre: 1-2 saat
# ──────────────────────────────────────────────────────────

/feature Profil ekranı ve uygulama ayarları.

1. Profil ekranı:
   - Avatar (kullanıcı fotoğrafı veya initials)
   - İsim, email (düzenlenebilir)
   - Cilt tipi badge
   - Üyelik durumu (Free/Pro)
   - Toplam analiz sayısı, üyelik tarihi

2. Settings ekranı:
   - Tema: Sistem / Açık / Koyu (radio buttons)
   - Bildirimler: Rutin hatırlatma açık/kapalı + saat seçimi
   - Abonelik: mevcut plan + yönet butonu
   - Hesap:
     - Verilerimi dışa aktar (JSON export — GDPR)
     - Hesabımı sil (onay dialog → tüm data + fotoğraflar silinir)
   - Hakkında: Versiyon, lisanslar
   - Gizlilik Politikası (WebView veya URL)
   - Kullanım Koşulları (WebView veya URL)
   - Çıkış yap

3. GDPR compliance:
   - Hesap silme: Supabase'den tüm kullanıcı verisi + Storage fotoğrafları sil
   - Veri export: kullanıcının tüm verisini JSON olarak indir

TASARIM:
- Profil: Üstte kart (avatar, isim, plan badge), altta liste
- Settings: Grouped list (iOS Settings tarzı, ama custom)
- Hesap sil: Kırmızı, dikkat çekici onay dialogu


# ──────────────────────────────────────────────────────────
# FEATURE 11: Ana Sayfa (Home) + Bottom Navigation
# Tahmini süre: 1-2 saat
# ──────────────────────────────────────────────────────────

/feature Ana sayfa dashboard ve bottom navigation bar.

1. Bottom Navigation (5 tab):
   - Home (ev ikonu), Analiz (kamera ikonu), İlerleme (grafik ikonu),
     Rutin (takvim ikonu), Profil (kişi ikonu)
   - Ortadaki "Analiz" butonu büyük ve vurgulu (FAB tarzı)
   - Custom bottom bar: rounded üst köşeler, hafif shadow

2. Home ekranı:
   - Üstte selamlama: "Merhaba, [isim]!" + tarih
   - Son analiz özeti kartı: skor dairesi + "X gün önce"
     + "Tekrar analiz et" butonu
   - Günlük rutin kartı: bugünkü rutin adımları checklist,
     tamamlama yüzdesi bar
   - Haftanın ipucu: AI'dan kısa cilt bakım ipucu (hardcoded başlangıç)
   - İlerleme mini grafiği: son 4 haftanın skor trendi (mini line chart)

3. İlk kullanım (analiz yapılmamışsa):
   - "İlk analizini yap!" kartı, büyük kamera ikonu
   - CTA butonu doğrudan kamera ekranına

TASARIM:
- Home: Card-based layout, her kart glassmorphism
- Selamlama: Sol hizalı, emoji yok, clean
- Bottom bar: Floating efekt, ortadaki buton prominent
- Boş state: Friendly, motivasyonel


# ──────────────────────────────────────────────────────────
# FEATURE 12: Landing Page + Store Hazırlığı
# Tahmini süre: 1-2 saat
# ──────────────────────────────────────────────────────────

/feature Web landing page ve store listing hazırlığı.

BÖLÜM A — Landing Page (Flutter Web):
- Route: /landing (sadece web'de göster)
- Bölümler:
  1. Hero: "Cildini AI ile Analiz Et" + app mockup + CTA + store badge'leri
  2. Nasıl Çalışır: 3 adım ikonlu (Selfie Çek → AI Analiz → Rutin Al)
  3. Özellikler: Ekran görüntüleri ile öne çıkan 4 özellik
  4. Fiyatlandırma: Free vs Pro karşılaştırma
  5. FAQ: 5 soru (accordion)
  6. Footer: Logo, linkler, sosyal medya
- Responsive: Mobile-first
- Smooth scroll animasyonları

BÖLÜM B — Store Hazırlığı:
- App icon: Basit, modern, yüz silueti + sparkle efekti
  (Flutter launcher_icons paketi ile oluştur)
- Splash screen: Logo + gradient arka plan
  (flutter_native_splash paketi)
- App Store description metni (TR + EN) → docs/store-listing.md

BÖLÜM C — Final Kontroller:
- flutter analyze → 0 issue
- flutter test → tüm testler geçmeli
- flutter build web → web build çalışmalı
- flutter build apk → APK oluşmalı
- README.md güncelle
