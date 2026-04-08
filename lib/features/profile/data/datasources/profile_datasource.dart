import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/logger.dart';
import '../../../auth/domain/entities/user_entity.dart';

/// Supabase data source for profile operations.
class ProfileDatasource {
  ProfileDatasource(this._client);

  final SupabaseClient _client;

  /// Updates user profile fields in the users table.
  Future<UserEntity> updateProfile({
    required String userId,
    String? name,
    String? email,
  }) async {
    log.d('Updating profile for user: $userId');
    final updates = <String, dynamic>{};
    if (name != null) updates['name'] = name;
    if (email != null) updates['email'] = email;

    final data = await _client
        .from('users')
        .update(updates)
        .eq('id', userId)
        .select()
        .single();

    return UserEntity(
      id: data['id'] as String,
      email: data['email'] as String? ?? '',
      name: data['name'] as String?,
      skinType: data['skin_type'] as String?,
      avatarUrl: data['avatar_url'] as String?,
      subscriptionTier: data['subscription_tier'] as String? ?? 'free',
      onboardingCompleted:
          data['onboarding_completed'] as bool? ?? false,
      skinConcerns:
          (data['skin_concerns'] as List<dynamic>?)?.cast<String>() ??
              const [],
    );
  }

  /// Returns total analysis count for a user.
  Future<int> getAnalysisCount(String userId) async {
    final result = await _client
        .from('analyses')
        .select('id')
        .eq('user_id', userId);
    return (result as List).length;
  }

  /// Returns the user's account creation date.
  Future<DateTime?> getJoinDate(String userId) async {
    final data = await _client
        .from('users')
        .select('created_at')
        .eq('id', userId)
        .maybeSingle();
    if (data == null || data['created_at'] == null) return null;
    return DateTime.tryParse(data['created_at'] as String);
  }

  /// Exports all user data as a JSON map for GDPR compliance.
  Future<Map<String, dynamic>> exportUserData(String userId) async {
    log.i('Exporting user data for GDPR: $userId');

    final user = await _client
        .from('users')
        .select()
        .eq('id', userId)
        .maybeSingle();

    final analyses = await _client
        .from('analyses')
        .select('*, zone_scores(*)')
        .eq('user_id', userId);

    final routines = await _client
        .from('routines')
        .select()
        .eq('user_id', userId);

    final progressLogs = await _client
        .from('progress_logs')
        .select()
        .eq('user_id', userId);

    return {
      'exported_at': DateTime.now().toIso8601String(),
      'user': user,
      'analyses': analyses,
      'routines': routines,
      'progress_logs': progressLogs,
    };
  }

  /// Deletes all user data and the account (GDPR compliance).
  Future<void> deleteAccount(String userId) async {
    log.w('Deleting account for user: $userId');

    // 1. Delete progress logs
    await _client
        .from('progress_logs')
        .delete()
        .eq('user_id', userId);

    // 2. Delete zone scores (via analyses)
    final analyses = await _client
        .from('analyses')
        .select('id')
        .eq('user_id', userId);
    for (final a in analyses) {
      await _client
          .from('zone_scores')
          .delete()
          .eq('analysis_id', a['id'] as String);
    }

    // 3. Delete analyses
    await _client
        .from('analyses')
        .delete()
        .eq('user_id', userId);

    // 4. Delete routines
    await _client
        .from('routines')
        .delete()
        .eq('user_id', userId);

    // 5. Delete photos from storage
    try {
      final files = await _client.storage
          .from(AppConstants.photoBucket)
          .list(path: userId);
      if (files.isNotEmpty) {
        final paths = files.map((f) => '$userId/${f.name}').toList();
        await _client.storage
            .from(AppConstants.photoBucket)
            .remove(paths);
      }
    } catch (e) {
      log.w('Failed to delete storage files', e);
    }

    // 6. Delete user record
    await _client.from('users').delete().eq('id', userId);

    // 7. Sign out (auth user deletion needs admin/edge function)
    await _client.auth.signOut();

    log.i('Account deleted successfully: $userId');
  }
}
