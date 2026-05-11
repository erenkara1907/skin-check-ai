import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'ambient_orbs.dart';

/// Multi-stage loading animation with narrative progression.
class AnalysisLoading extends StatefulWidget {
  const AnalysisLoading({super.key});

  @override
  State<AnalysisLoading> createState() => _AnalysisLoadingState();
}

class _AnalysisLoadingState extends State<AnalysisLoading> {
  int _stage = 0;
  Timer? _timer;

  static const _stages = [
    _LoadingStage(LucideIcons.scanFace, 'Cildiniz analiz ediliyor...'),
    _LoadingStage(LucideIcons.layers, '7 bolge inceleniyor...'),
    _LoadingStage(LucideIcons.sparkles, 'Kisisel oneriler hazirlaniyor...'),
    _LoadingStage(LucideIcons.checkCircle2, 'Sonuclar neredeyse hazir!'),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_stage < _stages.length - 1 && mounted) {
        setState(() => _stage++);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final stage = _stages[_stage];

    return Stack(
      children: [
        const AmbientOrbs(),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated icon with outer pulse ring
              Stack(
                alignment: Alignment.center,
                children: [
                  // Outer pulse ring
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        width: 1.5,
                      ),
                    ),
                  )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scale(
                        begin: const Offset(1.0, 1.0),
                        end: const Offset(1.1, 1.1),
                        duration: 2000.ms,
                        curve: Curves.easeInOut,
                      ),
                  // Inner icon circle
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.2),
                          AppColors.secondary.withValues(alpha: 0.2),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: Icon(
                        stage.icon,
                        key: ValueKey(_stage),
                        size: 56,
                        color: isDark
                            ? AppColors.primaryLight
                            : AppColors.primary,
                      ),
                    ),
                  )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .rotate(
                        begin: -0.01,
                        end: 0.01,
                        duration: 3000.ms,
                        curve: Curves.easeInOut,
                      )
                      .shimmer(
                        duration: 1500.ms,
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                ],
              ),
              const SizedBox(height: 36),

              // Stage message with cross-fade
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Text(
                  stage.message,
                  key: ValueKey(_stage),
                  style: AppTextStyles.titleLarge.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),

              // Gradient progress bar
              _GradientProgressBar(progress: (_stage + 1) / _stages.length),
              const SizedBox(height: 16),

              Text(
                'AI modelimiz cildinizi 7 bolgede inceliyor',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.5),
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
            ],
          ),
        ),
      ],
    );
  }
}

class _LoadingStage {
  const _LoadingStage(this.icon, this.message);
  final IconData icon;
  final String message;
}

/// Animated gradient progress bar.
class _GradientProgressBar extends StatelessWidget {
  const _GradientProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 240,
      height: 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: isDark ? AppColors.surfaceDark : AppColors.borderLight,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedFractionallySizedBox(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
          widthFactor: progress.clamp(0.05, 0.9),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
