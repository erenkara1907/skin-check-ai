import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_summary_entity.freezed.dart';
part 'progress_summary_entity.g.dart';

/// Aggregated progress overview for the dashboard.
@freezed
class ProgressSummaryEntity with _$ProgressSummaryEntity {
  const factory ProgressSummaryEntity({
    @Default(0) double currentScore,
    @Default(0) int skinAge,
    @Default(0) int totalAnalyses,
    String? mostImprovedZone,
    @Default(0) double mostImprovedZoneChange,
    @Default(0) int streak,
    DateTime? lastAnalysisDate,
  }) = _ProgressSummaryEntity;

  factory ProgressSummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$ProgressSummaryEntityFromJson(json);
}
