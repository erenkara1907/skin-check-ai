import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:skincheck_ai/features/sharing/domain/entities/share_card_data.dart';
import 'package:skincheck_ai/features/sharing/presentation/widgets/share_card.dart';
import 'package:skincheck_ai/features/analysis/domain/entities/zone_score_entity.dart';

void main() {
  group('ShareCard', () {
    late ShareCardData highScoreData;
    late ShareCardData lowScoreData;
    late ShareCardData midScoreData;

    setUp(() {
      highScoreData = const ShareCardData(
        overallScore: 85,
        skinAge: 25,
        zones: [
          ZoneScoreEntity(zone: 'forehead', score: 80),
          ZoneScoreEntity(zone: 'nose', score: 90),
        ],
      );
      lowScoreData = const ShareCardData(
        overallScore: 30,
        skinAge: 40,
      );
      midScoreData = const ShareCardData(
        overallScore: 55,
        skinAge: 32,
      );
    });

    Widget buildCard(ShareCardData data, {GlobalKey? repaintKey}) {
      return MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 360,
            height: 640,
            child: ShareCard(data: data, repaintKey: repaintKey),
          ),
        ),
      );
    }

    testWidgets('renders score text', (tester) async {
      await tester.pumpWidget(buildCard(highScoreData));

      expect(find.text('85'), findsOneWidget);
      expect(find.text('puan'), findsOneWidget);
    });

    testWidgets('renders skin age', (tester) async {
      await tester.pumpWidget(buildCard(highScoreData));

      expect(find.text('Cilt Yaşım: 25'), findsOneWidget);
    });

    testWidgets('renders CTA text', (tester) async {
      await tester.pumpWidget(buildCard(highScoreData));

      expect(
        find.text('SkinCheck AI ile analiz et'),
        findsOneWidget,
      );
    });

    testWidgets('renders watermark', (tester) async {
      await tester.pumpWidget(buildCard(highScoreData));

      expect(find.text('SkinCheck AI'), findsOneWidget);
    });

    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(buildCard(highScoreData));

      expect(find.text('Analiz Sonucu'), findsOneWidget);
    });

    testWidgets('renders custom label', (tester) async {
      final data = highScoreData.copyWith(
        label: 'Haftalık İlerleme',
      );
      await tester.pumpWidget(buildCard(data));

      expect(find.text('Haftalık İlerleme'), findsOneWidget);
    });

    testWidgets('wraps with RepaintBoundary when key provided',
        (tester) async {
      final key = GlobalKey();
      await tester.pumpWidget(
        buildCard(highScoreData, repaintKey: key),
      );

      expect(find.byType(RepaintBoundary), findsWidgets);
    });

    testWidgets('renders low score card', (tester) async {
      await tester.pumpWidget(buildCard(lowScoreData));

      expect(find.text('30'), findsOneWidget);
      expect(find.text('Cilt Yaşım: 40'), findsOneWidget);
    });

    testWidgets('renders mid score card', (tester) async {
      await tester.pumpWidget(buildCard(midScoreData));

      expect(find.text('55'), findsOneWidget);
    });
  });
}
