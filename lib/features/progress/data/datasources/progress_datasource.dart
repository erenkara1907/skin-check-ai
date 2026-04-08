import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/logger.dart';

/// Remote data source for progress tracking via Supabase.
class ProgressDataSource {
  ProgressDataSource(this._client);

  final SupabaseClient _client;

  /// Fetch all analyses for a user, oldest first.
  Future<List<Map<String, dynamic>>> fetchAllAnalyses(String userId) async {
    final data = await _client
        .from('analyses')
        .select('*, zone_scores(*)')
        .eq('user_id', userId)
        .order('created_at', ascending: true);

    return List<Map<String, dynamic>>.from(data);
  }

  /// Create a signed URL for a photo in the private bucket.
  Future<String> getSignedPhotoUrl(String path) async {
    final url = await _client.storage
        .from(AppConstants.photoBucket)
        .createSignedUrl(path, 3600);

    log.d('Signed URL created for: $path');
    return url;
  }
}
