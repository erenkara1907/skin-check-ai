import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:skincheck_ai/features/analysis/domain/entities/zone_score_entity.dart';
import 'package:skincheck_ai/features/sharing/presentation/widgets/mini_face_map.dart';

void main() {
  group('MiniFaceMap', () {
    const zones = [
      ZoneScoreEntity(zone: 'forehead', score: 80),
      ZoneScoreEntity(zone: 'nose', score: 60),
      ZoneScoreEntity(zone: 'chin', score: 35),
    ];

    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MiniFaceMap(zones: zones),
          ),
        ),
      );

      expect(find.byType(MiniFaceMap), findsOneWidget);
    });

    testWidgets('renders zone score labels', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MiniFaceMap(zones: zones),
          ),
        ),
      );

      expect(find.text('80'), findsOneWidget);
      expect(find.text('60'), findsOneWidget);
      expect(find.text('35'), findsOneWidget);
    });

    testWidgets('renders with custom size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MiniFaceMap(zones: zones, size: 200),
          ),
        ),
      );

      expect(find.byType(MiniFaceMap), findsOneWidget);
    });

    testWidgets('renders empty zones without error', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MiniFaceMap(zones: []),
          ),
        ),
      );

      expect(find.byType(MiniFaceMap), findsOneWidget);
    });
  });
}
