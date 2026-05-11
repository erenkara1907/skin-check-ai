import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/paywall_gate.dart';
import '../../../../shared/widgets/score_circle.dart';

/// Score circle with glow halo, skin age badge, and confetti for high scores.
class ResultScoreSection extends StatefulWidget {
  const ResultScoreSection({
    super.key,
    required this.overallScore,
    required this.skinAge,
  });

  final double overallScore;
  final int skinAge;

  @override
  State<ResultScoreSection> createState() => _ResultScoreSectionState();
}

class _ResultScoreSectionState extends State<ResultScoreSection> {
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(milliseconds: 800),
    );
    if (widget.overallScore > 80) {
      Future.delayed(1200.ms, () {
        if (mounted) _confettiController.play();
      });
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scoreColor = AppColors.scoreColor(widget.overallScore);

    return Column(
      children: [
        // Score circle with glow halo
        Stack(
          alignment: Alignment.center,
          children: [
            // Glow halo
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    scoreColor.withValues(alpha: 0.15),
                    scoreColor.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
            ScoreCircle(
              score: widget.overallScore,
              size: 180,
              strokeWidth: 16,
              label: context.l10n.overallScoreLabel,
            ),
            // Confetti
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 12,
              maxBlastForce: 8,
              minBlastForce: 3,
              emissionFrequency: 0.0,
              gravity: 0.2,
              colors: const [
                AppColors.primary,
                AppColors.secondary,
                AppColors.primaryLight,
                AppColors.secondaryLight,
              ],
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 500.ms)
            .scale(
              begin: const Offset(0.6, 0.6),
              end: const Offset(1.05, 1.05),
              duration: 600.ms,
              curve: Curves.easeOutBack,
            )
            .then()
            .scale(
              begin: const Offset(1.05, 1.05),
              end: const Offset(1.0, 1.0),
              duration: 200.ms,
              curve: Curves.easeInOut,
            ),
        const SizedBox(height: 20),

        // Skin age badge
        PaywallGate(
          label: context.l10n.skinAgeLabel,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isDark ? AppColors.glassDark : AppColors.glassLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? AppColors.glassBorderDark
                      : AppColors.glassBorderLight,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    LucideIcons.sparkles,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    context.l10n.skinAgeDisplay(widget.skinAge),
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 500.ms, duration: 400.ms)
            .slideX(begin: -0.05, end: 0),
      ],
    );
  }
}
