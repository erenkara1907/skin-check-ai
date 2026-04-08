import '../entities/photo_comparison_entity.dart';
import '../entities/progress_summary_entity.dart';
import '../entities/score_trend_entity.dart';
import '../entities/zone_progress_entity.dart';

/// Interface for progress tracking operations.
abstract class ProgressRepository {
  /// Fetch aggregated progress summary for the dashboard.
  Future<ProgressSummaryEntity> getProgressSummary(String userId);

  /// Fetch score trend data points ordered by date.
  Future<List<ScoreTrendEntity>> getScoreTrend(String userId);

  /// Fetch zone-by-zone progress between first and latest analysis.
  Future<List<ZoneProgressEntity>> getZoneProgress(String userId);

  /// Fetch first and latest photos for comparison slider.
  Future<PhotoComparisonEntity> getPhotoComparison(String userId);
}
