import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/logger.dart';

/// Remote data source for skin analysis operations via Supabase.
class AnalysisDataSource {
  AnalysisDataSource(this._client);

  final SupabaseClient _client;

  /// Upload photo bytes to the private skin-photos bucket.
  /// Returns the storage path (not a URL).
  Future<String> uploadPhoto({
    required String userId,
    required Uint8List photoBytes,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = '$userId/$timestamp.jpg';

    await _client.storage
        .from(AppConstants.photoBucket)
        .uploadBinary(path, photoBytes, fileOptions: const FileOptions(
          contentType: 'image/jpeg',
        ));

    log.i('Photo uploaded: $path');
    return path;
  }

  /// Call the analyze-skin edge function.
  Future<Map<String, dynamic>> invokeSkinAnalysis({
    required String userId,
    required String photoPath,
  }) async {
    final response = await _client.functions.invoke(
      'analyze-skin',
      body: {
        'user_id': userId,
        'photo_path': photoPath,
      },
    );

    if (response.status != 200) {
      throw Exception(
        'Edge function error: ${response.status}',
      );
    }

    return response.data as Map<String, dynamic>;
  }

  /// Fetch a single analysis with its zone scores.
  Future<Map<String, dynamic>?> fetchAnalysis(String analysisId) async {
    final data = await _client
        .from('analyses')
        .select('*, zone_scores(*)')
        .eq('id', analysisId)
        .maybeSingle();

    return data;
  }

  /// Fetch analysis history for a user, newest first.
  Future<List<Map<String, dynamic>>> fetchHistory(String userId) async {
    final data = await _client
        .from('analyses')
        .select('*, zone_scores(*)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(data);
  }
}
