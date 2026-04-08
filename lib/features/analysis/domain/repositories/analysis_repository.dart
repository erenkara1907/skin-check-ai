import 'dart:typed_data';

import '../entities/analysis_entity.dart';

/// Interface for skin analysis operations.
abstract class AnalysisRepository {
  /// Upload a photo to Supabase Storage and return the storage path.
  Future<String> uploadPhoto({
    required String userId,
    required Uint8List photoBytes,
  });

  /// Invoke the analyze-skin edge function and return the result.
  Future<AnalysisEntity> analyzeSkin({
    required String userId,
    required String photoPath,
  });

  /// Fetch a single analysis by ID.
  Future<AnalysisEntity?> getAnalysis(String analysisId);

  /// Fetch analysis history for a user, newest first.
  Future<List<AnalysisEntity>> getHistory(String userId);
}
