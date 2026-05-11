import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Quiet one-line guidance — a whisper, not a system readout.
///
/// Simple glass pill with a small icon and a sentence. Accent shifts to
/// brand teal when the face is detected; otherwise soft white.
class CameraGuidanceBar extends StatelessWidget {
  const CameraGuidanceBar({
    super.key,
    required this.faceDetected,
  });

  final bool faceDetected;

  @override
  Widget build(BuildContext context) {
    final accent = faceDetected ? AppColors.secondary : Colors.white;
    final message = faceDetected
        ? 'Harika. Sabit kalın.'
        : 'Yüzünüzü ovale hizalayın';
    final icon =
        faceDetected ? LucideIcons.check : LucideIcons.scanFace;

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: accent.withValues(alpha: faceDetected ? 0.4 : 0.14),
                width: 0.7,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: accent, size: 15),
                const SizedBox(width: 8),
                Text(
                  message,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.95),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
