import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_trend_entity.freezed.dart';
part 'score_trend_entity.g.dart';

/// A single data point in the score trend chart.
@freezed
class ScoreTrendEntity with _$ScoreTrendEntity {
  const factory ScoreTrendEntity({
    required DateTime date,
    required double score,
  }) = _ScoreTrendEntity;

  factory ScoreTrendEntity.fromJson(Map<String, dynamic> json) =>
      _$ScoreTrendEntityFromJson(json);
}
