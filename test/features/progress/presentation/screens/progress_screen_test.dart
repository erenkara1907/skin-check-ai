import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/progress/domain/entities/progress_summary_entity.dart';
import 'package:skincheck_ai/features/progress/domain/entities/score_trend_entity.dart';
import 'package:skincheck_ai/features/progress/domain/entities/zone_progress_entity.dart';
import 'package:skincheck_ai/features/progress/presentation/widgets/metric_cards_row.dart';
import 'package:skincheck_ai/features/progress/presentation/widgets/progress_empty_state.dart';
import 'package:skincheck_ai/features/progress/presentation/widgets/score_trend_chart.dart';
import 'package:skincheck_ai/features/progress/presentation/widgets/zone_progress_item.dart';
import 'package:skincheck_ai/features/progress/presentation/widgets/zone_progress_list.dart';

void main() {
  group('MetricCardsRow', () {
    testWidgets('renders 3 metric values', (tester) async {
      const summary = ProgressSummaryEntity(
        currentScore: 75,
        skinAge: 25,
        totalAnalyses: 10,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MetricCardsRow(summary: summary),
          ),
        ),
      );

      expect(find.text('75'), findsOneWidget);
      expect(find.text('25'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
    });
  });

  group('ProgressEmptyState', () {
    testWidgets('renders CTA button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProviderScope(
            child: const Scaffold(
              body: ProgressEmptyState(),
            ),
          ),
        ),
      );

      expect(find.text('Analiz Yap'), findsOneWidget);
      expect(
        find.text('Henuz ilerleme verisi yok'),
        findsOneWidget,
      );
    });
  });

  group('ScoreTrendChart', () {
    testWidgets('renders chart when data provided', (tester) async {
      final data = [
        ScoreTrendEntity(
          date: DateTime(2026, 3, 1),
          score: 60,
        ),
        ScoreTrendEntity(
          date: DateTime(2026, 4, 1),
          score: 75,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ScoreTrendChart(data: data),
            ),
          ),
        ),
      );

      expect(find.text('Skor Trendi'), findsOneWidget);
    });

    testWidgets('renders nothing with empty data', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ScoreTrendChart(data: []),
          ),
        ),
      );

      expect(find.text('Skor Trendi'), findsNothing);
    });
  });

  group('ZoneProgressList', () {
    testWidgets('renders zone items', (tester) async {
      final zones = [
        const ZoneProgressEntity(
          zone: 'forehead',
          zoneName: 'Alin',
          currentScore: 70,
          previousScore: 50,
          changePercent: 40,
        ),
        const ZoneProgressEntity(
          zone: 'nose',
          zoneName: 'Burun',
          currentScore: 60,
          previousScore: 65,
          changePercent: -7.7,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ZoneProgressList(zones: zones),
            ),
          ),
        ),
      );

      expect(find.text('Alin'), findsOneWidget);
      expect(find.text('Burun'), findsOneWidget);
      expect(find.byType(ZoneProgressItem), findsNWidgets(2));
    });

    testWidgets('renders nothing with empty zones', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ZoneProgressList(zones: []),
          ),
        ),
      );

      expect(find.byType(ZoneProgressItem), findsNothing);
    });
  });
}
