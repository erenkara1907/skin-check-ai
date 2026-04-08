import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_comparison_entity.freezed.dart';
part 'photo_comparison_entity.g.dart';

/// Before/after photo pair for visual comparison.
@freezed
class PhotoComparisonEntity with _$PhotoComparisonEntity {
  const factory PhotoComparisonEntity({
    String? firstPhotoUrl,
    DateTime? firstDate,
    @Default(0) double firstScore,
    String? latestPhotoUrl,
    DateTime? latestDate,
    @Default(0) double latestScore,
  }) = _PhotoComparisonEntity;

  factory PhotoComparisonEntity.fromJson(Map<String, dynamic> json) =>
      _$PhotoComparisonEntityFromJson(json);
}
