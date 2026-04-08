import '../../../analysis/domain/entities/skin_zone.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/photo_comparison_entity.dart';
import '../../domain/entities/progress_summary_entity.dart';
import '../../domain/entities/score_trend_entity.dart';
import '../../domain/entities/zone_progress_entity.dart';
import '../../domain/repositories/progress_repository.dart';
import '../datasources/progress_datasource.dart';

/// Supabase-backed implementation of [ProgressRepository].
class ProgressRepositoryImpl implements ProgressRepository {
  ProgressRepositoryImpl(this._dataSource);

  final ProgressDataSource _dataSource;

  @override
  Future<ProgressSummaryEntity> getProgressSummary(String userId) async {
    try {
      final analyses = await _dataSource.fetchAllAnalyses(userId);
      if (analyses.isEmpty) {
        return const ProgressSummaryEntity();
      }

      final latest = analyses.last;
      final streak = _calculateStreak(analyses);
      final zoneProgress = _buildZoneProgress(analyses);

      String? mostImproved;
      double mostImprovedChange = 0;
      for (final zp in zoneProgress) {
        if (zp.changePercent > mostImprovedChange) {
          mostImprovedChange = zp.changePercent;
          mostImproved = zp.zoneName;
        }
      }

      return ProgressSummaryEntity(
        currentScore: (latest['overall_score'] as num).toDouble(),
        skinAge: (latest['skin_age'] as num).toInt(),
        totalAnalyses: analyses.length,
        mostImprovedZone: mostImproved,
        mostImprovedZoneChange: mostImprovedChange,
        streak: streak,
        lastAnalysisDate: DateTime.tryParse(
          latest['created_at'] as String? ?? '',
        ),
      );
    } catch (e, st) {
      log.e('Failed to get progress summary', e, st);
      rethrow;
    }
  }

  @override
  Future<List<ScoreTrendEntity>> getScoreTrend(String userId) async {
    try {
      final analyses = await _dataSource.fetchAllAnalyses(userId);
      return analyses.map((a) {
        return ScoreTrendEntity(
          date: DateTime.parse(a['created_at'] as String),
          score: (a['overall_score'] as num).toDouble(),
        );
      }).toList();
    } catch (e, st) {
      log.e('Failed to get score trend', e, st);
      rethrow;
    }
  }

  @override
  Future<List<ZoneProgressEntity>> getZoneProgress(String userId) async {
    try {
      final analyses = await _dataSource.fetchAllAnalyses(userId);
      return _buildZoneProgress(analyses);
    } catch (e, st) {
      log.e('Failed to get zone progress', e, st);
      rethrow;
    }
  }

  @override
  Future<PhotoComparisonEntity> getPhotoComparison(
    String userId,
  ) async {
    try {
      final analyses = await _dataSource.fetchAllAnalyses(userId);
      if (analyses.length < 2) {
        return const PhotoComparisonEntity();
      }

      final first = analyses.first;
      final latest = analyses.last;

      final firstPath = first['photo_url'] as String?;
      final latestPath = latest['photo_url'] as String?;

      String? firstUrl;
      String? latestUrl;

      if (firstPath != null && firstPath.isNotEmpty) {
        firstUrl = await _dataSource.getSignedPhotoUrl(firstPath);
      }
      if (latestPath != null && latestPath.isNotEmpty) {
        latestUrl = await _dataSource.getSignedPhotoUrl(latestPath);
      }

      return PhotoComparisonEntity(
        firstPhotoUrl: firstUrl,
        firstDate: DateTime.tryParse(
          first['created_at'] as String? ?? '',
        ),
        firstScore: (first['overall_score'] as num).toDouble(),
        latestPhotoUrl: latestUrl,
        latestDate: DateTime.tryParse(
          latest['created_at'] as String? ?? '',
        ),
        latestScore: (latest['overall_score'] as num).toDouble(),
      );
    } catch (e, st) {
      log.e('Failed to get photo comparison', e, st);
      rethrow;
    }
  }

  /// Calculate weekly streak from analysis dates.
  int _calculateStreak(List<Map<String, dynamic>> analyses) {
    if (analyses.isEmpty) return 0;

    final dates = analyses
        .map((a) => DateTime.parse(a['created_at'] as String))
        .toList()
      ..sort((a, b) => b.compareTo(a));

    final now = DateTime.now();
    final currentWeekStart = _weekStart(now);

    // Check if there's an analysis this week or last week
    final latestDate = dates.first;
    final latestWeekStart = _weekStart(latestDate);
    final weeksDiff =
        currentWeekStart.difference(latestWeekStart).inDays ~/ 7;

    if (weeksDiff > 1) return 0;

    int streak = 0;
    var checkWeek = latestWeekStart;

    for (final date in dates) {
      final dateWeek = _weekStart(date);
      if (dateWeek == checkWeek) {
        if (streak == 0) streak = 1;
        continue;
      }
      final diff = checkWeek.difference(dateWeek).inDays ~/ 7;
      if (diff == 1) {
        streak++;
        checkWeek = dateWeek;
      } else {
        break;
      }
    }

    return streak;
  }

  DateTime _weekStart(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    return d.subtract(Duration(days: d.weekday - 1));
  }

  List<ZoneProgressEntity> _buildZoneProgress(
    List<Map<String, dynamic>> analyses,
  ) {
    if (analyses.length < 2) return [];

    final firstZones = _extractZoneScores(analyses.first);
    final latestZones = _extractZoneScores(analyses.last);

    return SkinZone.values.map((zone) {
      final prev = firstZones[zone.value] ?? 0.0;
      final curr = latestZones[zone.value] ?? 0.0;
      final change = prev > 0 ? ((curr - prev) / prev) * 100 : 0.0;

      return ZoneProgressEntity(
        zone: zone.value,
        zoneName: zone.label,
        currentScore: curr,
        previousScore: prev,
        changePercent: change,
      );
    }).toList();
  }

  Map<String, double> _extractZoneScores(Map<String, dynamic> analysis) {
    final zones = analysis['zone_scores'] as List<dynamic>? ?? [];
    final map = <String, double>{};
    for (final z in zones) {
      final zoneMap = z as Map<String, dynamic>;
      map[zoneMap['zone'] as String] =
          (zoneMap['score'] as num).toDouble();
    }
    return map;
  }
}
