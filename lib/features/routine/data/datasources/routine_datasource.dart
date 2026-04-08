import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/logger.dart';

/// Remote data source for routine operations via Supabase.
class RoutineDataSource {
  RoutineDataSource(this._client);

  final SupabaseClient _client;

  /// Fetches active routines for a user.
  Future<List<Map<String, dynamic>>> fetchActiveRoutines(
    String userId,
  ) async {
    final data = await _client
        .from('routines')
        .select()
        .eq('user_id', userId)
        .eq('is_active', true)
        .order('type');

    log.d('Fetched ${data.length} active routines');
    return List<Map<String, dynamic>>.from(data);
  }

  /// Upserts a routine (insert or update).
  Future<Map<String, dynamic>> upsertRoutine(
    Map<String, dynamic> routine,
  ) async {
    final data = await _client
        .from('routines')
        .upsert(routine)
        .select()
        .single();

    log.i('Routine upserted: ${data['id']}');
    return data;
  }

  /// Deletes a routine by ID.
  Future<void> deleteRoutine(String routineId) async {
    await _client.from('routines').delete().eq('id', routineId);
    log.i('Routine deleted: $routineId');
  }

  /// Records a routine completion for today.
  Future<Map<String, dynamic>> insertCompletion(
    Map<String, dynamic> completion,
  ) async {
    final data = await _client
        .from('routine_completions')
        .upsert(
          completion,
          onConflict: 'user_id,routine_id,completed_at',
        )
        .select()
        .single();

    log.i('Completion recorded: ${data['id']}');
    return data;
  }

  /// Fetches recent completions for streak calculation.
  Future<List<Map<String, dynamic>>> fetchCompletions({
    required String userId,
    int limit = 60,
  }) async {
    final data = await _client
        .from('routine_completions')
        .select()
        .eq('user_id', userId)
        .order('completed_at', ascending: false)
        .limit(limit);

    return List<Map<String, dynamic>>.from(data);
  }

  /// Fetches today's completion for a routine.
  Future<Map<String, dynamic>?> fetchTodayCompletion({
    required String userId,
    required String routineId,
  }) async {
    final today = DateTime.now().toIso8601String().substring(0, 10);

    final data = await _client
        .from('routine_completions')
        .select()
        .eq('user_id', userId)
        .eq('routine_id', routineId)
        .eq('completed_at', today)
        .maybeSingle();

    return data;
  }
}
