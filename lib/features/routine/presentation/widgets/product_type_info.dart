import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';

/// Educational content shown while adding a routine step.
class ProductTypeInfo {
  const ProductTypeInfo({
    required this.key,
    required this.label,
    required this.tagline,
    required this.description,
    required this.howToSteps,
    required this.benefits,
    required this.bestTime,
    required this.duration,
    required this.icon,
    required this.accent,
  });

  final String key;
  final String label;
  final String tagline;
  final String description;
  final List<String> howToSteps;
  final List<String> benefits;
  final String bestTime;
  final String duration;
  final IconData icon;
  final Color accent;

  /// Icon identifier persisted on the routine step.
  String get iconName {
    const map = {
      'cleanser': 'droplets',
      'toner': 'spray-can',
      'serum': 'flask-round',
      'moisturizer': 'cloud',
      'sunscreen': 'sun',
      'eye_cream': 'eye',
      'mask': 'smile',
      'exfoliant': 'sparkles',
      'oil': 'droplet',
      'retinol': 'moon',
    };
    return map[key] ?? 'pill';
  }
}

/// Catalog with localized educational content per product type.
class ProductTypeCatalog {
  const ProductTypeCatalog._();

  /// Returns the ordered list of product types for the current locale.
  static List<ProductTypeInfo> all(BuildContext context) {
    final code = Localizations.localeOf(context).languageCode;
    return _keys.map((k) => _build(k, code)).toList(growable: false);
  }

  /// Returns a single [ProductTypeInfo] for the given key.
  static ProductTypeInfo byKey(BuildContext context, String key) {
    final code = Localizations.localeOf(context).languageCode;
    return _build(_keys.contains(key) ? key : _keys.first, code);
  }

  static const _keys = [
    'cleanser',
    'toner',
    'serum',
    'moisturizer',
    'sunscreen',
    'eye_cream',
    'mask',
    'exfoliant',
    'oil',
    'retinol',
  ];

  static ProductTypeInfo _build(String key, String locale) {
    final tr = locale == 'tr';
    return ProductTypeInfo(
      key: key,
      label: _label(key, tr),
      tagline: _tagline(key, tr),
      description: _description(key, tr),
      howToSteps: _howTo(key, tr),
      benefits: _benefits(key, tr),
      bestTime: _bestTime(key, tr),
      duration: _duration(key, tr),
      icon: _icon(key),
      accent: _accent(key),
    );
  }

  static String _label(String k, bool tr) => switch (k) {
        'cleanser' => tr ? 'Temizleyici' : 'Cleanser',
        'toner' => tr ? 'Tonik' : 'Toner',
        'serum' => 'Serum',
        'moisturizer' => tr ? 'Nemlendirici' : 'Moisturizer',
        'sunscreen' => tr ? 'Güneş Kremi' : 'Sunscreen',
        'eye_cream' => tr ? 'Göz Kremi' : 'Eye Cream',
        'mask' => tr ? 'Maske' : 'Mask',
        'exfoliant' => tr ? 'Peeling' : 'Exfoliant',
        'oil' => tr ? 'Yüz Yağı' : 'Face Oil',
        'retinol' => 'Retinol',
        _ => k,
      };

  static String _tagline(String k, bool tr) => switch (k) {
        'cleanser' => tr ? 'Günün kirini temizler' : 'Washes the day away',
        'toner' => tr ? 'pH dengesini kurar' : 'Balances your skin pH',
        'serum' => tr ? 'Hedefli aktif bakım' : 'Targeted active care',
        'moisturizer' => tr ? 'Nemi kilitler' : 'Locks in hydration',
        'sunscreen' => tr ? 'UV kalkanı' : 'Your UV shield',
        'eye_cream' => tr ? 'Narin göz çevresi' : 'For delicate eyes',
        'mask' => tr ? 'Yoğun haftalık bakım' : 'Weekly deep treatment',
        'exfoliant' => tr ? 'Ölü hücre arınması' : 'Cell turnover boost',
        'oil' => tr ? 'Besleyici kilit' : 'Nourishing final seal',
        'retinol' => tr ? 'Gece yenileyici' : 'Nighttime renewal',
        _ => '',
      };

  static String _description(String k, bool tr) => switch (k) {
        'cleanser' => tr
            ? 'Ciltteki kir, fazla yağ ve makyajı nazikçe uzaklaştırır. Sonraki ürünlerin daha iyi emilmesini sağlar ve gözeneklerin tıkanmasını önler.'
            : 'Gently removes dirt, excess oil, and makeup. Prepares skin for better absorption of the next products and prevents clogged pores.',
        'toner' => tr
            ? 'Temizlik sonrası cildin pH dengesini geri kazandırır. Gözenekleri sıkılaştırır, kalan artıkları alır ve cildi serumlara hazırlar.'
            : 'Restores pH balance after cleansing. Tightens pores, removes residue, and primes skin for serums.',
        'serum' => tr
            ? 'Yüksek yoğunluklu aktif bileşenlerle belirli bir sorununu hedef alır: leke, kırışık, kuruluk ya da mat görünüm.'
            : 'Delivers concentrated active ingredients for targeted concerns like dark spots, wrinkles, dryness, or dullness.',
        'moisturizer' => tr
            ? 'Cildin nemini kilitleyip barriyeri güçlendirir. Kuruluğu önler, cildi dolgun ve yumuşak tutar.'
            : 'Locks moisture in and reinforces the skin barrier. Prevents dryness and keeps skin plump and soft.',
        'sunscreen' => tr
            ? 'UVA/UVB ışınlarına karşı korur. Erken yaşlanmayı, lekeleri ve DNA hasarını önler — bakım yapılan her gün gerekli.'
            : 'Protects against UVA/UVB rays. Prevents premature aging, dark spots, and DNA damage — non-negotiable daily.',
        'eye_cream' => tr
            ? 'Göz çevresinin ince ve hassas cildine özel formüle edilmiş, koyu halkaları ve ince çizgileri hedef alır.'
            : 'Formulated for the thin, delicate skin around the eyes. Targets dark circles and fine lines.',
        'mask' => tr
            ? 'Yoğun bakım için haftada 1–2 kez. Kil, hidrasyon veya aydınlatma gibi tek bir hedefe odaklanır.'
            : 'Intensive treatment used 1–2× a week. Focuses on a single goal: clay, hydration, or brightening.',
        'exfoliant' => tr
            ? 'Ölü deri hücrelerini AHA/BHA ile nazikçe uzaklaştırır. Cildi pürüzsüzleştirir, gözenekleri açar ve parlaklık verir.'
            : 'Gently removes dead cells using AHAs/BHAs. Smooths texture, unclogs pores, and boosts glow.',
        'oil' => tr
            ? 'Rutinin sonunda cildi besleyip nemini mühürler. Kuru ve olgun ciltler için ideal.'
            : 'Nourishes and seals in hydration at the very end of your routine. Ideal for dry or mature skin.',
        'retinol' => tr
            ? 'Hücre yenilenmesini hızlandırır: kırışıklıkları, lekeleri ve gözenek görünümünü azaltır. Hassas — yavaş başla.'
            : 'Accelerates cell turnover: reduces wrinkles, dark spots, and pore visibility. Potent — start slow.',
        _ => '',
      };

  static List<String> _howTo(String k, bool tr) {
    if (tr) {
      return switch (k) {
        'cleanser' => const [
            'Yüzünü ılık suyla ıslat',
            'Ceviz büyüklüğünde ürünü avuç içinde köpürt',
            '30 saniye dairesel hareketlerle masaj yap',
            'Bolca suyla durula, havluyla nazikçe kurula',
          ],
        'toner' => const [
            'Küçük bir pamuğa 3–4 damla al',
            'Yüzüne merkez-dış yönde uygula',
            'Kendi kendine emilmesini bekle (30 sn)',
          ],
        'serum' => const [
            '2–3 damlayı avuç içine damlat',
            'Nazikçe yüz ve boyna dağıt',
            'Bastırarak emilmesini sağla — ovma',
            '1–2 dakika bekle, ardından nemlendirici',
          ],
        'moisturizer' => const [
            'Bezelye büyüklüğünde ürün al',
            'Alın, yanaklar, burun, çeneden başla',
            'Dışa doğru nazik vuruşlarla yedir',
          ],
        'sunscreen' => const [
            'Yüz için 2 parmak uzunluğunda ürün (~1 tatlı kaşığı)',
            'Rutinin son adımı olarak uygula',
            '2 saatte bir yenile — özellikle dışarıdaysan',
          ],
        'eye_cream' => const [
            'Yüzük parmağının ucuna küçük bir miktar',
            'Göz altına nokta nokta yerleştir',
            'Hafif tapping hareketiyle yedir — ovma',
          ],
        'mask' => const [
            'Temiz cilde uygula',
            '10–15 dakika üzerinde bırak',
            'Ilık suyla durula',
            'Normal rutinine devam et',
          ],
        'exfoliant' => const [
            'Haftada 2–3 akşam, temizlik sonrası',
            'Pamukla ince bir tabaka uygula',
            'Göz ve dudak çevresinden kaçın',
            'Ertesi gün mutlaka güneş kremi kullan',
          ],
        'oil' => const [
            '2–3 damla avucuna sık',
            'Avuçlarını sürterek ısıt',
            'Yüzüne hafifçe bastırarak kapat',
          ],
        'retinol' => const [
            'Haftada 2 akşam başla, yavaş yavaş artır',
            'Bezelye büyüklüğünde, kuru cilde uygula',
            'Üstüne nemlendirici ile barriyeri destekle',
            'Ertesi gün yüksek faktör güneş kremi şart',
          ],
        _ => const [],
      };
    }
    return switch (k) {
      'cleanser' => const [
          'Wet your face with lukewarm water',
          'Lather a nickel-sized amount in your palms',
          'Massage in circles for 30 seconds',
          'Rinse thoroughly and pat dry',
        ],
      'toner' => const [
          'Apply 3–4 drops to a cotton pad',
          'Sweep from center outward',
          'Let it absorb for ~30 seconds',
        ],
      'serum' => const [
          'Dispense 2–3 drops into your palm',
          'Spread evenly across face and neck',
          'Press in — don\'t rub',
          'Wait 1–2 minutes, then moisturize',
        ],
      'moisturizer' => const [
          'Take a pea-sized amount',
          'Dot on forehead, cheeks, nose, chin',
          'Smooth outward with gentle strokes',
        ],
      'sunscreen' => const [
          '2 finger-lengths for face (~½ tsp)',
          'Apply as the last step of your routine',
          'Reapply every 2 hours outdoors',
        ],
      'eye_cream' => const [
          'Take a rice-grain amount on your ring finger',
          'Dot gently under the eye',
          'Tap lightly to absorb — never rub',
        ],
      'mask' => const [
          'Apply to clean skin',
          'Leave on for 10–15 minutes',
          'Rinse with lukewarm water',
          'Continue with normal routine',
        ],
      'exfoliant' => const [
          '2–3 evenings a week, after cleansing',
          'Apply a thin layer with a cotton pad',
          'Avoid eye and lip area',
          'Always follow with SPF the next day',
        ],
      'oil' => const [
          'Dispense 2–3 drops into your palm',
          'Warm between your hands',
          'Press gently into skin to seal',
        ],
      'retinol' => const [
          'Start 2 nights a week, build up slowly',
          'Pea-sized amount on dry skin',
          'Buffer with moisturizer on top',
          'High SPF next morning is essential',
        ],
      _ => const [],
    };
  }

  static List<String> _benefits(String k, bool tr) {
    if (tr) {
      return switch (k) {
        'cleanser' => const [
            'Tıkanmış gözeneklerde azalma',
            'Rutinin daha etkili emilmesi',
            'Dengeli, rahat cilt hissi',
          ],
        'toner' => const [
            'Gözenek görünümünde daralma',
            'Daha pürüzsüz cilt dokusu',
            'Serumdan maksimum verim',
          ],
        'serum' => const [
            'Hedeflenen sorunda hızlı iyileşme',
            'Daha aydınlık ve eşit ton',
            'Güçlenen cilt görünümü',
          ],
        'moisturizer' => const [
            'Uzun süreli nem kilidi',
            'Güçlü cilt barriyeri',
            'Dolgun, yumuşak his',
          ],
        'sunscreen' => const [
            'Erken yaşlanma korumasi',
            'Leke oluşumunu engelleme',
            'Cilt kanseri riskini düşürme',
          ],
        'eye_cream' => const [
            'Koyu halkalarda azalma',
            'İnce çizgilerde yumuşama',
            'Daha dinç bir bakış',
          ],
        'mask' => const [
            'Anında aydınlık',
            'Derin hidrasyon',
            'Detoks hissi',
          ],
        'exfoliant' => const [
            'Pürüzsüz cilt dokusu',
            'Gözeneklerde belirgin azalma',
            'Daha parlak cilt tonu',
          ],
        'oil' => const [
            'Derin besleme',
            'Sağlıklı parlaklık',
            'Korunan nem',
          ],
        'retinol' => const [
            'İnce çizgilerde gözle görülür azalma',
            'Eşit cilt tonu',
            'Sıkı ve genç cilt dokusu',
          ],
        _ => const [],
      };
    }
    return switch (k) {
      'cleanser' => const [
          'Fewer clogged pores',
          'Better absorption of your routine',
          'Balanced, comfortable skin feel',
        ],
      'toner' => const [
          'Tighter-looking pores',
          'Smoother texture',
          'Maximized serum results',
        ],
      'serum' => const [
          'Faster progress on target concerns',
          'Brighter, more even tone',
          'Stronger, healthier-looking skin',
        ],
      'moisturizer' => const [
          'Long-lasting hydration',
          'Stronger skin barrier',
          'Plump, supple feel',
        ],
      'sunscreen' => const [
          'Protection from early aging',
          'Prevents new dark spots',
          'Reduces skin cancer risk',
        ],
      'eye_cream' => const [
          'Reduced dark circles',
          'Softer fine lines',
          'A more refreshed look',
        ],
      'mask' => const [
          'Instant glow',
          'Deep hydration',
          'A clean, detoxed feel',
        ],
      'exfoliant' => const [
          'Smoother skin texture',
          'Visibly refined pores',
          'Brighter overall tone',
        ],
      'oil' => const [
          'Deep nourishment',
          'Healthy, natural glow',
          'Protected moisture levels',
        ],
      'retinol' => const [
          'Visible reduction in fine lines',
          'Evened-out skin tone',
          'Firmer, younger texture',
        ],
      _ => const [],
    };
  }

  static String _bestTime(String k, bool tr) => switch (k) {
        'cleanser' => tr ? 'Sabah & Akşam' : 'Morning & Evening',
        'toner' => tr ? 'Sabah & Akşam' : 'Morning & Evening',
        'serum' => tr ? 'Sabah veya Akşam' : 'Morning or Evening',
        'moisturizer' => tr ? 'Sabah & Akşam' : 'Morning & Evening',
        'sunscreen' => tr ? 'Her sabah' : 'Every morning',
        'eye_cream' => tr ? 'Sabah & Akşam' : 'Morning & Evening',
        'mask' => tr ? 'Haftada 1–2' : '1–2× per week',
        'exfoliant' => tr ? 'Haftada 2–3 akşam' : '2–3 evenings a week',
        'oil' => tr ? 'Akşam' : 'Evening',
        'retinol' => tr ? 'Akşam' : 'Evening only',
        _ => '',
      };

  static String _duration(String k, bool tr) => switch (k) {
        'cleanser' => tr ? '~1 dk' : '~1 min',
        'toner' => tr ? '~30 sn' : '~30 sec',
        'serum' => tr ? '~1 dk' : '~1 min',
        'moisturizer' => tr ? '~30 sn' : '~30 sec',
        'sunscreen' => tr ? '~30 sn' : '~30 sec',
        'eye_cream' => tr ? '~30 sn' : '~30 sec',
        'mask' => tr ? '10–15 dk' : '10–15 min',
        'exfoliant' => tr ? '~30 sn' : '~30 sec',
        'oil' => tr ? '~30 sn' : '~30 sec',
        'retinol' => tr ? '~1 dk' : '~1 min',
        _ => '',
      };

  static IconData _icon(String k) => switch (k) {
        'cleanser' => LucideIcons.droplets,
        'toner' => LucideIcons.sprayCan,
        'serum' => LucideIcons.flaskRound,
        'moisturizer' => LucideIcons.cloud,
        'sunscreen' => LucideIcons.sun,
        'eye_cream' => LucideIcons.eye,
        'mask' => LucideIcons.smile,
        'exfoliant' => LucideIcons.sparkles,
        'oil' => LucideIcons.droplet,
        'retinol' => LucideIcons.moon,
        _ => LucideIcons.pill,
      };

  static Color _accent(String k) => switch (k) {
        'cleanser' => const Color(0xFF4DB5FF),
        'toner' => const Color(0xFF8B7CF6),
        'serum' => const Color(0xFFFF7A9C),
        'moisturizer' => AppColors.secondary,
        'sunscreen' => const Color(0xFFFFB627),
        'eye_cream' => const Color(0xFF4AA8A8),
        'mask' => const Color(0xFFE06BAF),
        'exfoliant' => AppColors.primary,
        'oil' => const Color(0xFFD79C4C),
        'retinol' => const Color(0xFF6D5DF6),
        _ => AppColors.primary,
      };
}
