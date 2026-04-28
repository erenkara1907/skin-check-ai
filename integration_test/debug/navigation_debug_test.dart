import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:skincheck_ai/core/router/app_router.dart';
import 'package:skincheck_ai/features/auth/presentation/providers/auth_provider.dart';
import 'package:skincheck_ai/features/auth/presentation/screens/login_screen.dart';
import 'package:skincheck_ai/features/home/presentation/screens/home_screen.dart';
import 'package:skincheck_ai/features/onboarding/presentation/screens/onboarding_screen.dart';

import '../common/test_app.dart';

void main() {
  ensureBinding();

  testWidgets('DEBUG — dump state after login', (tester) async {
    await pumpApp(tester);
    await loginAsNewUser(tester);

    // Pump extra frames
    for (int i = 0; i < 50; i++) {
      await tester.pump(const Duration(milliseconds: 200));
    }

    // ── Dump all widget types ──
    debugPrint('=== DEBUG: Widget tree types ===');
    final allWidgets = find.byWidgetPredicate((_) => true);
    final types = <String>{};
    for (final element in allWidgets.evaluate()) {
      types.add(element.widget.runtimeType.toString());
    }
    for (final t in types.toList()..sort()) {
      debugPrint('  $t');
    }

    // ── Check specific screens ──
    debugPrint('=== DEBUG: Screen checks ===');
    debugPrint('  LoginScreen found: ${find.byType(LoginScreen).evaluate().length}');
    debugPrint('  HomeScreen found: ${find.byType(HomeScreen).evaluate().length}');
    debugPrint('  OnboardingScreen found: ${find.byType(OnboardingScreen).evaluate().length}');

    // ── Check provider states via ProviderScope ──
    final element = tester.element(find.byType(MaterialApp).first);
    final container = ProviderScope.containerOf(element);

    final authState = container.read(authNotifierProvider);
    debugPrint('=== DEBUG: Provider states ===');
    debugPrint('  authNotifier: $authState');
    debugPrint('  isAuthenticated: ${container.read(isAuthenticatedProvider)}');

    final profileState = container.read(userProfileProvider);
    debugPrint('  userProfile: $profileState');
    debugPrint('  isOnboardingCompleted: ${container.read(isOnboardingCompletedProvider)}');

    // ── Check GoRouter state ──
    final router = container.read(appRouterProvider);
    debugPrint('=== DEBUG: Router state ===');
    debugPrint('  current location: ${router.routeInformationProvider.value.uri}');

    // ── Check for any visible text ──
    debugPrint('=== DEBUG: Visible text (first 20) ===');
    final textWidgets = find.byType(Text).evaluate().take(20);
    for (final e in textWidgets) {
      final text = e.widget as Text;
      debugPrint('  "${text.data ?? text.textSpan?.toPlainText() ?? '?'}"');
    }

    // This test always "passes" — the value is in the debug output
    debugPrint('=== DEBUG COMPLETE ===');
  });
}
