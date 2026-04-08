import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_text_styles.dart';

/// Displays face detection and lighting guidance messages.
class CameraGuidanceBar extends StatelessWidget {
  const CameraGuidanceBar({
    super.key,
    required this.faceDetected,
  });

  final bool faceDetected;

  @override
  Widget build(BuildContext context) {
    final message = faceDetected
        ? 'Harika! Çekim için hazırsınız'
        : 'Yüzünüzü çerçeveye hizalayın';

    final icon = faceDetected ? Icons.check_circle : Icons.face;
    final color = faceDetected
        ? const Color(0xFF00D9A6)
        : Colors.white.withValues(alpha: 0.8);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              style: AppTextStyles.bodySmall.copyWith(color: color),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    )
        .animate(target: faceDetected ? 1 : 0)
        .shimmer(
          duration: 600.ms,
          color: const Color(0xFF00D9A6).withValues(alpha: 0.3),
        );
  }
}
