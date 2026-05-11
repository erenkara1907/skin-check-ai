import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../domain/entities/routine_step_detail_entity.dart';
import '../providers/guided_routine_provider.dart';
import '../widgets/guided_step_card.dart';
import '../widgets/guided_timer.dart';

/// Step-by-step guided routine walkthrough screen.
class GuidedRoutineScreen extends ConsumerStatefulWidget {
  const GuidedRoutineScreen({super.key, required this.steps});

  final List<RoutineStepDetailEntity> steps;

  @override
  ConsumerState<GuidedRoutineScreen> createState() =>
      _GuidedRoutineScreenState();
}

class _GuidedRoutineScreenState extends ConsumerState<GuidedRoutineScreen> {
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    // Initialize guided state after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(guidedRoutineNotifierProvider.notifier).start(widget.steps);
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    ref.read(guidedRoutineNotifierProvider.notifier).reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final guidedState = ref.watch(guidedRoutineNotifierProvider);
    if (guidedState == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (guidedState.isCompleted) {
      return _buildCompletedView(context);
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.guidedModeTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                '${guidedState.currentStepIndex + 1}/${guidedState.steps.length}',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 8),
                  // Progress bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: guidedState.progress,
                        backgroundColor: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Step card — fills remaining space, nav floats on top
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 120),
                      child: Column(
                        children: [
                          GuidedStepCard(
                            step: guidedState.currentStep,
                            index: guidedState.currentStepIndex,
                          ),
                          const SizedBox(height: 24),
                          // Timer
                          GuidedTimer(
                            durationSeconds: guidedState.defaultDuration,
                            elapsedSeconds: guidedState.elapsedSeconds,
                            isRunning: guidedState.isTimerRunning,
                            onTick: () => ref
                                .read(
                                  guidedRoutineNotifierProvider.notifier,
                                )
                                .tick(),
                            onToggle: () => ref
                                .read(
                                  guidedRoutineNotifierProvider.notifier,
                                )
                                .toggleTimer(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Floating bottom nav — no container background
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: IgnorePointer(
                  child: _GuidedNavScrim(isDark: isDark),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildBottomNav(context, guidedState),
              ),
              // Confetti
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [
                    AppColors.primary,
                    AppColors.secondary,
                    Color(0xFFFF8C00),
                    Color(0xFFFFD700),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, dynamic guidedState) {
    final notifier = ref.read(guidedRoutineNotifierProvider.notifier);
    final isLast = !guidedState.hasNext;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Row(
        children: [
          if (guidedState.hasPrevious)
            Expanded(
              child: AppButton(
                label: context.l10n.backButton,
                variant: AppButtonVariant.outline,
                onPressed: () => notifier.previousStep(),
              ),
            ),
          if (guidedState.hasPrevious) const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              label: isLast
                  ? context.l10n.completeRoutineButton
                  : context.l10n.nextStepButton,
              icon: isLast ? LucideIcons.check : LucideIcons.arrowRight,
              onPressed: () {
                if (isLast) {
                  _confettiController.play();
                  notifier.complete();
                } else {
                  notifier.nextStep();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedView(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    LucideIcons.sparkles,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  context.l10n.guidedModeComplete,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                AppButton(
                  label: context.l10n.backButton,
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Soft bottom fade so floating nav buttons read cleanly over scroll content.
class _GuidedNavScrim extends StatelessWidget {
  const _GuidedNavScrim({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    return SizedBox(
      height: 140,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              bg.withValues(alpha: 0),
              bg.withValues(alpha: 0.7),
              bg,
            ],
            stops: const [0, 0.55, 1],
          ),
        ),
      ),
    );
  }
}
