import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../analysis/domain/entities/zone_score_entity.dart';

part 'share_card_data.freezed.dart';
part 'share_card_data.g.dart';

/// Data model for the shareable result card.
@freezed
class ShareCardData with _$ShareCardData {
  const factory ShareCardData({
    required double overallScore,
    required int skinAge,
    @Default([]) List<ZoneScoreEntity> zones,
    @Default('Analiz Sonucu') String label,
  }) = _ShareCardData;

  factory ShareCardData.fromJson(Map<String, dynamic> json) =>
      _$ShareCardDataFromJson(json);
}
