import 'package:freezed_annotation/freezed_annotation.dart';

part 'zone_progress_entity.freezed.dart';
part 'zone_progress_entity.g.dart';

/// Progress delta for a single facial zone.
@freezed
class ZoneProgressEntity with _$ZoneProgressEntity {
  const factory ZoneProgressEntity({
    required String zone,
    required String zoneName,
    required double currentScore,
    required double previousScore,
    required double changePercent,
  }) = _ZoneProgressEntity;

  factory ZoneProgressEntity.fromJson(Map<String, dynamic> json) =>
      _$ZoneProgressEntityFromJson(json);
}
