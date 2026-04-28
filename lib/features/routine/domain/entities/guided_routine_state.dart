import 'package:freezed_annotation/freezed_annotation.dart';

import 'routine_step_detail_entity.dart';

part 'guided_routine_state.freezed.dart';

/// State for the guided routine walkthrough mode.
@freezed
class GuidedRoutineState with _$GuidedRoutineState {
  const factory GuidedRoutineState({
    required List<RoutineStepDetailEntity> steps,
    @Default(0) int currentStepIndex,
    @Default(false) bool isTimerRunning,
    @Default(0) int elapsedSeconds,
    @Default(false) bool isCompleted,
  }) = _GuidedRoutineState;

  const GuidedRoutineState._();

  /// The current step being displayed.
  RoutineStepDetailEntity get currentStep => steps[currentStepIndex];

  /// Whether there is a next step.
  bool get hasNext => currentStepIndex < steps.length - 1;

  /// Whether there is a previous step.
  bool get hasPrevious => currentStepIndex > 0;

  /// Progress as a fraction (0.0 to 1.0).
  double get progress =>
      steps.isEmpty ? 0 : (currentStepIndex + 1) / steps.length;

  /// Default duration in seconds for the current step's product type.
  int get defaultDuration => _durationForType(currentStep.productType);

  static int _durationForType(String type) {
    const durations = {
      'cleanser': 60,
      'toner': 30,
      'serum': 45,
      'moisturizer': 30,
      'sunscreen': 30,
      'eye_cream': 30,
      'mask': 600,
      'exfoliant': 60,
      'oil': 30,
      'retinol': 30,
    };
    return durations[type.toLowerCase()] ?? 45;
  }
}
