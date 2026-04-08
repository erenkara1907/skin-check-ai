import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/routine/domain/entities/streak_entity.dart';
import 'package:skincheck_ai/features/routine/presentation/widgets/streak_banner.dart';

void main() {
  Widget buildBanner(StreakEntity streak) {
    return MaterialApp(
      home: Scaffold(
        body: StreakBanner(streak: streak),
      ),
    );
  }

  group('StreakBanner', () {
    testWidgets('hides when streak is zero', (tester) async {
      await tester.pumpWidget(buildBanner(const StreakEntity()));

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('shows streak count', (tester) async {
      await tester.pumpWidget(buildBanner(
        const StreakEntity(currentStreak: 7, longestStreak: 14),
      ));

      expect(find.text('7 Gün Seri!'), findsOneWidget);
      expect(find.text('En uzun seri: 14 gün'), findsOneWidget);
    });
  });
}
