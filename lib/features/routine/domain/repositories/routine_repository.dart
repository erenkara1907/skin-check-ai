import '../entities/routine_completion_entity.dart';
import '../entities/routine_entity.dart';
import '../entities/streak_entity.dart';

/// Contract for routine data operations.
abstract class RoutineRepository {
  /// Fetches the user's active routines (morning + evening).
  Future<List<RoutineEntity>> getActiveRoutines(String userId);

  /// Saves or updates a routine.
  Future<RoutineEntity> saveRoutine(RoutineEntity routine);

  /// Deletes a routine by [routineId].
  Future<void> deleteRoutine(String routineId);

  /// Records a routine completion for today.
  Future<RoutineCompletionEntity> completeRoutine({
    required String userId,
    required String routineId,
    required List<String> completedSteps,
  });

  /// Fetches completion records for streak calculation.
  Future<List<RoutineCompletionEntity>> getCompletions({
    required String userId,
    int limit = 60,
  });

  /// Calculates the current streak from completion records.
  Future<StreakEntity> getStreak(String userId);
}
