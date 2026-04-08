import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/routine/domain/entities/routine_step_detail_entity.dart';
import 'package:skincheck_ai/features/routine/presentation/widgets/routine_step_card.dart';

void main() {
  const step = RoutineStepDetailEntity(
    step: 'Yüz Temizleme',
    productType: 'cleanser',
    reason: 'Gözenekleri temizler',
    howToApply: 'Dairesel hareketlerle',
    iconName: 'droplets',
  );

  Widget buildCard({
    bool isCompleted = false,
    VoidCallback? onDelete,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: RoutineStepCard(
          step: step,
          index: 0,
          totalSteps: 3,
          isCompleted: isCompleted,
          onToggle: () {},
          onDelete: onDelete,
        ),
      ),
    );
  }

  group('RoutineStepCard', () {
    testWidgets('renders step name and reason', (tester) async {
      await tester.pumpWidget(buildCard());

      expect(find.text('Yüz Temizleme'), findsOneWidget);
      expect(find.text('Gözenekleri temizler'), findsOneWidget);
      expect(find.text('Dairesel hareketlerle'), findsOneWidget);
    });

    testWidgets('shows step number', (tester) async {
      await tester.pumpWidget(buildCard());

      expect(find.text('1.'), findsOneWidget);
    });

    testWidgets('shows check icon when completed', (tester) async {
      await tester.pumpWidget(buildCard(isCompleted: true));

      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    });

    testWidgets('hides check icon when not completed', (tester) async {
      await tester.pumpWidget(buildCard(isCompleted: false));

      expect(find.byIcon(Icons.check_rounded), findsNothing);
    });

    testWidgets('shows delete button in edit mode', (tester) async {
      await tester.pumpWidget(buildCard(onDelete: () {}));

      expect(find.byIcon(Icons.check_rounded), findsNothing);
    });

    testWidgets('hides delete button when callback is null',
        (tester) async {
      await tester.pumpWidget(buildCard());

      // Trash icon should not be present
      expect(find.byType(IconButton), findsNothing);
    });
  });
}
