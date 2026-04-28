import '../../../../core/utils/logger.dart';
import '../../domain/entities/routine_completion_entity.dart';
import '../../domain/entities/routine_entity.dart';
import '../../domain/entities/routine_step_detail_entity.dart';
import '../../domain/entities/streak_entity.dart';
import '../../domain/repositories/routine_repository.dart';
import '../datasources/routine_datasource.dart';

/// Supabase-backed implementation of [RoutineRepository].
class RoutineRepositoryImpl implements RoutineRepository {
  RoutineRepositoryImpl(this._dataSource);

  final RoutineDataSource _dataSource;

  @override
  Future<List<RoutineEntity>> getActiveRoutines(String userId) async {
    try {
      final rows = await _dataSource.fetchActiveRoutines(userId);
      return rows.map(_mapToEntity).toList();
    } catch (e, st) {
      log.e('Failed to fetch routines', e, st);
      rethrow;
    }
  }

  @override
  Future<RoutineEntity> saveRoutine(RoutineEntity routine) async {
    try {
      final row = <String, dynamic>{
        if (routine.id.isNotEmpty) 'id': routine.id,
        'user_id': routine.userId,
        'type': routine.type,
        'steps_json': routine.steps
            .map((s) => s.toJson())
            .toList(),
        'is_active': routine.isActive,
        'updated_at': DateTime.now().toIso8601String(),
      };

      final data = await _dataSource.upsertRoutine(row);
      return _mapToEntity(data);
    } catch (e, st) {
      log.e('Failed to save routine', e, st);
      rethrow;
    }
  }

  @override
  Future<void> deleteRoutine(String routineId) async {
    try {
      await _dataSource.deleteRoutine(routineId);
    } catch (e, st) {
      log.e('Failed to delete routine', e, st);
      rethrow;
    }
  }

  @override
  Future<RoutineCompletionEntity> completeRoutine({
    required String userId,
    required String routineId,
    required List<String> completedSteps,
  }) async {
    try {
      final today = DateTime.now().toIso8601String().substring(0, 10);

      final data = await _dataSource.insertCompletion({
        'user_id': userId,
        'routine_id': routineId,
        'completed_at': today,
        'completed_steps': completedSteps,
      });

      return RoutineCompletionEntity.fromJson(data);
    } catch (e, st) {
      log.e('Failed to complete routine', e, st);
      rethrow;
    }
  }

  @override
  Future<List<RoutineCompletionEntity>> getCompletions({
    required String userId,
    int limit = 60,
  }) async {
    try {
      final rows = await _dataSource.fetchCompletions(
        userId: userId,
        limit: limit,
      );
      return rows
          .map((r) => RoutineCompletionEntity.fromJson(r))
          .toList();
    } catch (e, st) {
      log.e('Failed to fetch completions', e, st);
      // Return empty list if table doesn't exist yet
      if (e.toString().contains('PGRST205')) {
        return [];
      }
      rethrow;
    }
  }

  @override
  Future<StreakEntity> getStreak(String userId) async {
    try {
      final completions = await getCompletions(userId: userId);
      return _calculateStreak(completions);
    } catch (e, st) {
      log.e('Failed to calculate streak', e, st);
      // Return empty streak if table doesn't exist yet
      if (e.toString().contains('PGRST205')) {
        return const StreakEntity();
      }
      rethrow;
    }
  }

  RoutineEntity _mapToEntity(Map<String, dynamic> data) {
    final stepsJson = data['steps_json'] as List<dynamic>? ?? [];
    final steps = stepsJson
        .map((s) => RoutineStepDetailEntity.fromJson(
              Map<String, dynamic>.from(s as Map),
            ))
        .toList();

    return RoutineEntity(
      id: data['id'] as String,
      userId: data['user_id'] as String,
      type: data['type'] as String,
      steps: steps,
      isActive: data['is_active'] as bool? ?? true,
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'] as String)
          : null,
      updatedAt: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'] as String)
          : null,
    );
  }

  /// Calculates streak from a list of completions sorted desc.
  StreakEntity _calculateStreak(
    List<RoutineCompletionEntity> completions,
  ) {
    if (completions.isEmpty) {
      return const StreakEntity();
    }

    final uniqueDays = completions
        .map((c) => _dateOnly(c.completedAt))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    final today = _dateOnly(DateTime.now());
    final yesterday = today.subtract(const Duration(days: 1));

    int currentStreak = 0;
    int longestStreak = 0;
    int tempStreak = 0;

    for (int i = 0; i < uniqueDays.length; i++) {
      if (i == 0) {
        final first = uniqueDays[0];
        if (first == today || first == yesterday) {
          tempStreak = 1;
          currentStreak = 1;
        } else {
          tempStreak = 1;
        }
      } else {
        final diff = uniqueDays[i - 1].difference(uniqueDays[i]).inDays;
        if (diff == 1) {
          tempStreak++;
          if (i < uniqueDays.length &&
              (uniqueDays[0] == today || uniqueDays[0] == yesterday)) {
            currentStreak = tempStreak;
          }
        } else {
          longestStreak =
              tempStreak > longestStreak ? tempStreak : longestStreak;
          tempStreak = 1;
        }
      }
    }
    longestStreak = tempStreak > longestStreak ? tempStreak : longestStreak;

    return StreakEntity(
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      lastCompletedDate: uniqueDays.first,
    );
  }

  DateTime _dateOnly(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day);
}
