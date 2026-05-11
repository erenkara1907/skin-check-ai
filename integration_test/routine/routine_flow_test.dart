import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:skincheck_ai/features/routine/presentation/screens/routine_screen.dart';

import '../common/test_app.dart';

void main() {
  ensureBinding();

  testWidgets('Routine — shows morning and evening tabs', (tester) async {
    await pumpApp(tester);
    await loginAsHomeUser(tester);

    // Navigate to routine tab
    await tester.tap(find.text('Rutin'));
    await settle(tester);
    await waitFor(tester, find.byType(RoutineScreen));

    // Verify both tabs exist
    expect(find.text('Sabah'), findsOneWidget);
    expect(find.text('Akşam'), findsOneWidget);
  });

  testWidgets('Routine — tab switching works', (tester) async {
    await pumpApp(tester);
    await loginAsHomeUser(tester);

    await tester.tap(find.text('Rutin'));
    await settle(tester);
    await waitFor(tester, find.byType(RoutineScreen));

    // Switch to evening tab
    await tester.tap(find.text('Akşam'));
    await settle(tester);

    // Switch back to morning tab
    await tester.tap(find.text('Sabah'));
    await settle(tester);

    expect(find.byType(RoutineScreen), findsOneWidget);
  });

  testWidgets('Routine — shows empty state or routine list', (tester) async {
    await pumpApp(tester);
    await loginAsHomeUser(tester);

    await tester.tap(find.text('Rutin'));
    await settle(tester);
    await waitFor(tester, find.byType(RoutineScreen));

    final hasEmptyView = find.text('Rutin Oluştur').evaluate().isNotEmpty;
    final hasRoutineContent = find.byType(ListView).evaluate().isNotEmpty;

    expect(hasEmptyView || hasRoutineContent, isTrue);
  });
}
