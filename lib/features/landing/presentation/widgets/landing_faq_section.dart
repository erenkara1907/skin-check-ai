import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// FAQ accordion section with 5 questions.
class LandingFaqSection extends StatelessWidget {
  const LandingFaqSection({super.key});

  static const _faqs = [
    _Faq(
      question: 'AI cilt analizi nasıl çalışır?',
      answer:
          'Selfie çektikten sonra yapay zekâ modelimiz yüzünüzü 7 farklı '
          'bölgeye ayırarak her bölge için ayrı ayrı analiz yapar. Cilt '
          'tonu, gözenek yapısı, kırışıklıklar, lekeler ve nem dengesi '
          'gibi faktörleri değerlendirerek size 0-100 arası bir skor verir.',
    ),
    _Faq(
      question: 'Fotoğraflarım güvende mi?',
      answer:
          'Kesinlikle evet. Fotoğraflarınız şifrelenmiş özel sunucularda '
          'saklanır ve yalnızca imzalı URL\'ler ile erişilebilir. KVKK ve '
          'GDPR uyumlu altyapımız sayesinde verileriniz her zaman güvende. '
          'Dilediğiniz zaman tüm verilerinizi silebilirsiniz.',
    ),
    _Faq(
      question: 'Pro üyeliğin farkı nedir?',
      answer:
          'Pro üyelik ile sınırsız cilt analizi, detaylı kişisel bakım '
          'rutini, ürün önerileri, gelişmiş ilerleme takibi ve reklamsız '
          'deneyim elde edersiniz. Ücretsiz plan günde 1 analiz ile sınırlıdır.',
    ),
    _Faq(
      question: 'Pro üyeliğimi nasıl iptal ederim?',
      answer:
          'Pro üyeliğinizi istediğiniz zaman App Store veya Google Play '
          'üzerinden iptal edebilirsiniz. İptal ettiğinizde mevcut dönem '
          'sonuna kadar Pro özelliklerini kullanmaya devam edersiniz.',
    ),
    _Faq(
      question: 'Hangi cihazlarda kullanabilirim?',
      answer:
          'SkinCheck AI, iOS (iPhone ve iPad) ve Android cihazlarda '
          'kullanılabilir. Ön kamerası olan tüm modern akıllı telefonlarla '
          'uyumludur. Web versiyonumuzu da tarayıcınızdan kullanabilirsiniz.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDesktop = screenWidth > 1024;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 64,
      ),
      color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                'Sıkça Sorulan Sorular',
                style: AppTextStyles.displaySmall.copyWith(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 40),
              ...List.generate(
                _faqs.length,
                (i) => _FaqTile(faq: _faqs[i], index: i, isDark: isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Faq {
  const _Faq({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({
    required this.faq,
    required this.index,
    required this.isDark,
  });

  final _Faq faq;
  final int index;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 4,
          ),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          title: Text(
            faq.question,
            style: AppTextStyles.titleLarge.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          iconColor: AppColors.primary,
          collapsedIconColor: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
          children: [
            Text(
              faq.answer,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: (100 * index).ms, duration: 500.ms)
        .slideX(begin: -0.05, end: 0);
  }
}
