import 'package:freezed_annotation/freezed_annotation.dart';

part 'concern_timeline_entity.freezed.dart';
part 'concern_timeline_entity.g.dart';

/// A single data point for a concern's severity over time.
@freezed
class ConcernTimelineEntity with _$ConcernTimelineEntity {
  const factory ConcernTimelineEntity({
    required DateTime date,
    required String concern,
    required int severity,
    required String zone,
  }) = _ConcernTimelineEntity;

  factory ConcernTimelineEntity.fromJson(Map<String, dynamic> json) =>
      _$ConcernTimelineEntityFromJson(json);
}
