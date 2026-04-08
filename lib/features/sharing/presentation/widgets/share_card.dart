import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/share_card_data.dart';
import 'mini_face_map.dart';

/// Instagram Story format shareable result card (9:16 aspect ratio).
class ShareCard extends StatelessWidget {
  const ShareCard({
    super.key,
    required this.data,
    this.repaintKey,
  });

  /// Card data (score, skin age, zones).
  final ShareCardData data;

  /// GlobalKey for RepaintBoundary capture.
  final GlobalKey? repaintKey;

  @override
  Widget build(BuildContext context) {
    final card = AspectRatio(
      aspectRatio: 9 / 16,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: _buildGradient(data.overallScore),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 40,
          ),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Label
              Text(
                data.label,
                style: AppTextStyles.titleMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              // Big score
              Text(
                data.overallScore.round().toString(),
                style: AppTextStyles.displayLarge.copyWith(
                  color: Colors.white,
                  fontSize: 72,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'puan',
                style: AppTextStyles.titleSmall.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              // Skin age
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ),
                child: Text(
                  'Cilt Yaşım: ${data.skinAge}',
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Mini face map
              if (data.zones.isNotEmpty)
                MiniFaceMap(zones: data.zones, size: 120),
              const Spacer(flex: 3),
              // CTA
              Text(
                'SkinCheck AI ile analiz et',
                style: AppTextStyles.titleSmall.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              // Watermark
              Align(
                alignment: Alignment.centerRight,
                child: Opacity(
                  opacity: 0.3,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'SkinCheck AI',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (repaintKey != null) {
      return RepaintBoundary(key: repaintKey, child: card);
    }
    return card;
  }

  /// Score-based gradient: red < 40, yellow 40-70, green > 70.
  LinearGradient _buildGradient(double score) {
    if (score < 40) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFDC2626), Color(0xFFF87171)],
      );
    }
    if (score <= 70) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF59E0B), Color(0xFFFCD34D)],
      );
    }
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.secondary,
        const Color(0xFF86EFAC),
      ],
    );
  }
}
