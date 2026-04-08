import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/logger.dart';
import '../../domain/entities/streak_entity.dart';
import 'routine_provider.dart';

part 'routine_completion_provider.g.dart';

/// Tracks step completion state for a routine today.
@riverpod
class RoutineCompletionNotifier extends _$RoutineCompletionNotifier {
  @override
  FutureOr<Map<int, bool>> build(String routineId) async {
    return {};
  }

  /// Toggles a step's completion state.
  void toggleStep(int index, {required int totalSteps}) {
    final current = Map<int, bool>.from(state.valueOrNull ?? {});
    current[index] = !(current[index] ?? false);
    state = AsyncData(current);

    final completedCount =
        current.values.where((v) => v).length;
    log.d('Step $index toggled. $completedCount/$totalSteps complete');
  }

  /// Returns true if all steps are completed.
  bool get allCompleted {
    final current = state.valueOrNull ?? {};
    if (current.isEmpty) return false;
    return current.values.every((v) => v);
  }

  /// Resets all steps to uncompleted.
  void reset() {
    state = const AsyncData({});
  }
}

/// Provides the user's current streak.
@riverpod
class StreakNotifier extends _$StreakNotifier {
  @override
  FutureOr<StreakEntity> build(String userId) async {
    final repo = ref.read(routineRepositoryProvider);
    return repo.getStreak(userId);
  }

  /// Records completion and refreshes streak.
  Future<void> recordCompletion({
    required String userId,
    required String routineId,
    required List<String> completedSteps,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(routineRepositoryProvider);

      await repo.completeRoutine(
        userId: userId,
        routineId: routineId,
        completedSteps: completedSteps,
      );

      return repo.getStreak(userId);
    });
  }

  /// Refreshes streak data.
  Future<void> refresh(String userId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(routineRepositoryProvider);
      return repo.getStreak(userId);
    });
  }
}
