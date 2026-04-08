import 'package:freezed_annotation/freezed_annotation.dart';

part 'zone_score_entity.freezed.dart';
part 'zone_score_entity.g.dart';

/// Score and details for a single facial zone.
@freezed
class ZoneScoreEntity with _$ZoneScoreEntity {
  const factory ZoneScoreEntity({
    required String zone,
    required double score,
    @Default([]) List<String> concerns,
    @Default(5) int severity,
    @Default([]) List<String> recommendations,
  }) = _ZoneScoreEntity;

  factory ZoneScoreEntity.fromJson(Map<String, dynamic> json) =>
      _$ZoneScoreEntityFromJson(json);
}
