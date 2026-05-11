import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_summary_entity.freezed.dart';
part 'weekly_summary_entity.g.dart';

/// Weekly routine completion summary.
@freezed
class WeeklySummaryEntity with _$WeeklySummaryEntity {
  const factory WeeklySummaryEntity({
    @Default(0) int morningCompleted,
    @Default(0) int eveningCompleted,
    @Default(7) int totalDays,
    @Default(0) int analysisCount,
  }) = _WeeklySummaryEntity;

  factory WeeklySummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$WeeklySummaryEntityFromJson(json);
}
