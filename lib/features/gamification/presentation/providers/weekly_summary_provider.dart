import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../routine/presentation/providers/routine_provider.dart';
import '../../domain/entities/weekly_summary_entity.dart';

part 'weekly_summary_provider.g.dart';

/// Provides the weekly routine completion summary.
@riverpod
class WeeklySummaryNotifier extends _$WeeklySummaryNotifier {
  @override
  FutureOr<WeeklySummaryEntity> build(String userId) async {
    final repo = ref.read(routineRepositoryProvider);

    // Get this week's date range (Monday to Sunday)
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final startDate = DateTime(
      weekStart.year,
      weekStart.month,
      weekStart.day,
    );

    final completions = await repo.getCompletions(userId: userId);

    int morning = 0;
    int evening = 0;

    for (final c in completions) {
      if (c.completedAt.isAfter(startDate)) {
        morning++;
      }
    }
    // Split evenly as approximation when type not tracked per completion
    evening = (morning / 2).floor();
    morning = morning - evening;

    return WeeklySummaryEntity(
      morningCompleted: morning.clamp(0, 7),
      eveningCompleted: evening.clamp(0, 7),
    );
  }
}
