import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  setUp(() {
    // Disable animations in tests for deterministic behavior.
    Animate.restartOnHotReload = false;
  });

  group('OnboardingScreen', () {
    testWidgets('renders welcome page initially', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: OnboardingScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Cildini tanı,\ngüzelliğini keşfet'), findsOneWidget);
      expect(find.text('Başla'), findsOneWidget);
      expect(
        find.text('Yapay zeka destekli cilt analizi'),
        findsOneWidget,
      );
    });

    testWidgets('tapping Başla navigates to skin type page', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: OnboardingScreen()),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Başla'));
      await tester.pumpAndSettle();

      expect(find.text('Cilt tipin hangisi?'), findsOneWidget);
    });
  });
}
