import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/guided_routine_state.dart';
import '../../domain/entities/routine_step_detail_entity.dart';

part 'guided_routine_provider.g.dart';

/// Manages the guided routine walkthrough state.
@riverpod
class GuidedRoutineNotifier extends _$GuidedRoutineNotifier {
  @override
  GuidedRoutineState? build() => null;

  /// Starts the guided routine with the given steps.
  void start(List<RoutineStepDetailEntity> steps) {
    if (steps.isEmpty) return;
    state = GuidedRoutineState(steps: steps);
  }

  /// Advances to the next step, resets timer.
  void nextStep() {
    final s = state;
    if (s == null || !s.hasNext) return;
    state = s.copyWith(
      currentStepIndex: s.currentStepIndex + 1,
      elapsedSeconds: 0,
      isTimerRunning: false,
    );
  }

  /// Goes back to the previous step, resets timer.
  void previousStep() {
    final s = state;
    if (s == null || !s.hasPrevious) return;
    state = s.copyWith(
      currentStepIndex: s.currentStepIndex - 1,
      elapsedSeconds: 0,
      isTimerRunning: false,
    );
  }

  /// Marks the routine as completed.
  void complete() {
    final s = state;
    if (s == null) return;
    state = s.copyWith(isCompleted: true, isTimerRunning: false);
  }

  /// Toggles the timer between running and paused.
  void toggleTimer() {
    final s = state;
    if (s == null) return;
    state = s.copyWith(isTimerRunning: !s.isTimerRunning);
  }

  /// Increments the elapsed time by one second.
  void tick() {
    final s = state;
    if (s == null || !s.isTimerRunning) return;
    state = s.copyWith(elapsedSeconds: s.elapsedSeconds + 1);
  }

  /// Resets the guided routine state.
  void reset() => state = null;
}
