import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/analysis_failure.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/retry.dart';

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
  ///
  /// Retries transient failures (503/504/408/429, socket/timeout,
  /// SUPABASE_EDGE_RUNTIME_ERROR) up to 3 times with exponential backoff.
  /// Any final error is wrapped in a typed [AnalysisFailure] so the UI
  /// can show a localized message.
  Future<Map<String, dynamic>> invokeSkinAnalysis({
    required String userId,
    required String photoPath,
    String locale = 'tr',
  }) async {
    try {
      return await retryWithBackoff<Map<String, dynamic>>(
        () async {
          final response = await _client.functions.invoke(
            'analyze-skin',
            body: {
              'user_id': userId,
              'photo_path': photoPath,
              'locale': locale,
            },
          );

          // Non-2xx responses don't always throw in supabase_flutter —
          // normalize to a FunctionException so the classifier can see
          // the status and decide whether to retry.
          if (response.status < 200 || response.status >= 300) {
            throw FunctionException(
              status: response.status,
              details: response.data,
              reasonPhrase: 'Non-2xx response',
            );
          }

          return response.data as Map<String, dynamic>;
        },
        retryIf: isTransientEdgeError,
        opName: 'analyze-skin',
      );
    } catch (e) {
      throw AnalysisFailure.fromException(e);
    }
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
