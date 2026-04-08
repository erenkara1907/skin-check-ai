import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';

/// Hardcoded weekly skincare tip card.
class WeeklyTipCard extends StatelessWidget {
  const WeeklyTipCard({super.key});

  static const _tips = [
    'Gunes kremi sadece yaz icin degil! Kis aylarinda da SPF 30+ kullanmayi ihmal etmeyin.',
    'Cildinizi temizledikten sonra 60 saniye icinde nemlendirici surmeye ozen gosterin.',
    'Haftada 2-3 kez hafif bir peeling cildinizin yenilenmesine yardimci olur.',
    'Gunde en az 2 litre su icmek cildinizin nemli ve parlak kalmasini saglar.',
    'Yastik kilifi haftada bir degistirmek cilt sagliginizi olumlu etkiler.',
    'Retinol iceren urunleri sadece aksam rutininizde kullanin.',
    'C vitamini serumu sabah rutininize ekleyerek cildinizi parlaklik kazandirin.',
  ];

  String _currentTip() {
    final weekOfYear = DateTime.now().difference(
      DateTime(DateTime.now().year),
    ).inDays ~/ 7;
    return _tips[weekOfYear % _tips.length];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              LucideIcons.lightbulb,
              size: 20,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Haftanin Ipucu',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: theme.colorScheme.onSurface
                        .withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _currentTip(),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: theme.colorScheme.onSurface,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(
          begin: 0.05,
          end: 0,
        );
  }
}
