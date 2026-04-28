import 'package:flutter_test/flutter_test.dart';

import 'package:skincheck_ai/features/home/presentation/screens/home_screen.dart';
import 'package:skincheck_ai/features/onboarding/presentation/screens/onboarding_screen.dart';

import '../common/test_app.dart';

void main() {
  ensureBinding();

  testWidgets('Onboarding — completes full 4-page flow', (tester) async {
    // Reset onboarding BEFORE pumpApp — needs auth for RLS
    await resetNewUserOnboarding();

    await pumpApp(tester);

    // Login with fresh user (onboarding not completed)
    await loginAsNewUser(tester);

    // Should be on onboarding screen
    await waitFor(tester, find.byType(OnboardingScreen));

    // ── Page 1: Welcome ──
    await waitFor(tester, find.text('Başla'));
    await tester.tap(find.text('Başla'));
    await settle(tester);

    // ── Page 2: Skin Type ──
    await waitFor(tester, find.text('Cilt tipin hangisi?'));

    await tester.tap(find.text('Normal'));
    await settle(tester);

    await tester.tap(find.text('Devam'));
    await settle(tester);

    // ── Page 3: Skin Concerns ──
    await waitFor(tester, find.text('En çok neyi\niyileştirmek istiyorsun?'));

    await tester.tap(find.text('Akne'));
    await settle(tester);

    await tester.tap(find.text('Devam'));
    await settle(tester);

    // ── Page 4: Camera Permission ──
    await waitFor(tester, find.text('Analizimi Başlat'));
    await tester.tap(find.text('Analizimi Başlat'));

    // Wait for API call + profile invalidation + router redirect
    await waitFor(
      tester,
      find.byType(HomeScreen),
      timeout: const Duration(seconds: 15),
    );
  });

  testWidgets('Onboarding — skin type page requires selection before proceeding',
      (tester) async {
    // Reset onboarding BEFORE pumpApp — needs auth for RLS
    await resetNewUserOnboarding();

    await pumpApp(tester);
    await loginAsNewUser(tester);
    await waitFor(tester, find.byType(OnboardingScreen));

    // Go to page 2
    await waitFor(tester, find.text('Başla'));
    await tester.tap(find.text('Başla'));
    await settle(tester);

    await waitFor(tester, find.text('Cilt tipin hangisi?'));

    await tester.tap(find.text('Kuru'));
    await settle(tester);

    await tester.tap(find.text('Devam'));
    await settle(tester);

    // Should be on concerns page now
    expect(
      find.text('En çok neyi\niyileştirmek istiyorsun?'),
      findsOneWidget,
    );
  });
}
