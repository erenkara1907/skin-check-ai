import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';

/// Floating gradient orbs that create atmospheric depth behind content.
class AmbientOrbs extends StatelessWidget {
  const AmbientOrbs({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: Stack(
          children: [
            // Primary orb — top-right
            Positioned(
              top: -40,
              right: -60,
              child: _Orb(
                size: 200,
                color: AppColors.primary.withValues(alpha: 0.08),
                blurRadius: 80,
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .moveY(
                    begin: -10,
                    end: 10,
                    duration: 4000.ms,
                    curve: Curves.easeInOut,
                  ),
            ),
            // Secondary orb — bottom-left
            Positioned(
              bottom: 60,
              left: -50,
              child: _Orb(
                size: 160,
                color: AppColors.secondary.withValues(alpha: 0.06),
                blurRadius: 70,
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .moveX(
                    begin: -8,
                    end: 8,
                    duration: 5000.ms,
                    curve: Curves.easeInOut,
                  ),
            ),
            // Accent orb — center-left
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.35,
              left: -30,
              child: _Orb(
                size: 120,
                color: AppColors.primaryLight.withValues(alpha: 0.05),
                blurRadius: 60,
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1.1, 1.1),
                    duration: 6000.ms,
                    curve: Curves.easeInOut,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({
    required this.size,
    required this.color,
    required this.blurRadius,
  });

  final double size;
  final Color color;
  final double blurRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color, blurRadius: blurRadius, spreadRadius: 20),
        ],
      ),
    );
  }
}
