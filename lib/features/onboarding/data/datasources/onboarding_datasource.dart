import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/logger.dart';
import '../../domain/entities/skin_concern.dart';
import '../../domain/entities/skin_type.dart';

/// Supabase data source for onboarding operations.
class OnboardingDataSource {
  OnboardingDataSource(this._client);

  final SupabaseClient _client;

  /// Saves skin type and concerns without completing onboarding.
  Future<void> saveProfile({
    required String userId,
    required SkinType skinType,
    required List<SkinConcern> concerns,
  }) async {
    log.d('Saving profile data for user: $userId');
    await _client.from('users').update({
      'skin_type': skinType.value,
      'skin_concerns': concerns.map((c) => c.value).toList(),
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', userId);
  }

  /// Marks onboarding as completed.
  Future<void> markComplete({required String userId}) async {
    log.d('Marking onboarding complete for user: $userId');
    await _client.from('users').update({
      'onboarding_completed': true,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', userId);
  }

  /// Saves onboarding data and marks as completed.
  Future<void> completeOnboarding({
    required String userId,
    required SkinType skinType,
    required List<SkinConcern> concerns,
  }) async {
    log.d('Saving onboarding data for user: $userId');
    await _client.from('users').update({
      'skin_type': skinType.value,
      'skin_concerns': concerns.map((c) => c.value).toList(),
      'onboarding_completed': true,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', userId);
  }
}
