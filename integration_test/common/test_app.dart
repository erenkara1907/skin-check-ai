import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:skincheck_ai/core/config/env_config.dart';
import 'package:skincheck_ai/core/services/supabase_service.dart';
import 'package:skincheck_ai/features/subscription/presentation/providers/subscription_provider.dart';
import 'package:skincheck_ai/main.dart';

import 'test_constants.dart';

/// Whether the backend has already been initialized this test run.
bool _backendReady = false;

/// Ensures the integration test binding is initialized once.
void ensureBinding() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
}

/// Initializes the backend (Supabase) once per test run.
Future<void> _initBackend() async {
  if (_backendReady) return;

  await EnvConfig.load();
  await SupabaseService.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
  );

  _backendReady = true;
}

/// Pumps the full [SkinCheckApp] with the real Supabase backend.
Future<void> pumpApp(
  WidgetTester tester, {
  List<Override> overrides = const [],
}) async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await _initBackend();

  // Clear any previous session for test isolation.
  await SupabaseService.client.auth.signOut();

  // Disable flutter_animate so pumpAndSettle completes.
  Animate.restartOnHotReload = false;
  Animate.defaultDuration = Duration.zero;
  Animate.defaultCurve = Curves.linear;

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        canAnalyzeProvider.overrideWith((_) => Future.value(true)),
        isProProvider.overrideWithValue(false),
        ...overrides,
      ],
      child: const SkinCheckApp(),
    ),
  );

  // Drive animations frame-by-frame so flutter_animate effects (which use
  // explicit durations that ignore defaultDuration) actually complete.
  // A single pump(5s) advances the clock but only renders one frame.
  for (int i = 0; i < 15; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
  await settle(tester);
}

/// Pumps frames until settled, with a generous timeout.
Future<void> settle(WidgetTester tester) async {
  try {
    await tester.pumpAndSettle(
      const Duration(milliseconds: 100),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 10),
    );
  } on FlutterError {
    // pumpAndSettle may timeout if there are ongoing animations
    // (e.g. CircularProgressIndicator). Pump a few more frames.
    await tester.pump(const Duration(seconds: 1));
  }
}

/// Waits for a finder to find at least one widget, with timeout.
Future<void> waitFor(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 15),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 200));
    if (finder.evaluate().isNotEmpty) return;
  }
  // One final pump and check
  await tester.pump(const Duration(milliseconds: 200));
  expect(finder, findsWidgets);
}

/// Logs in with the given credentials and waits for navigation.
Future<void> loginAs(
  WidgetTester tester, {
  required String email,
  required String password,
}) async {
  // Wait for login screen
  await waitFor(tester, find.byKey(const Key('loginEmailField')));

  // Enter credentials
  await tester.enterText(
    find.byKey(const Key('loginEmailField')),
    email,
  );
  await tester.pump();

  await tester.enterText(
    find.byKey(const Key('loginPasswordField')),
    password,
  );
  await tester.pump();

  // Tap login button
  await tester.tap(find.byKey(const Key('loginSubmitButton')));
  await tester.pump();

  // Pump frames while waiting for auth + profile fetch + router redirect.
  // Future.delayed doesn't pump frames, so Riverpod state changes wouldn't
  // propagate. Instead, pump every 200ms to process the full provider chain.
  final end = DateTime.now().add(TestTimeouts.network);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 200));
  }
  await settle(tester);
}

/// Logs in with the already-onboarded test user.
Future<void> loginAsHomeUser(WidgetTester tester) async {
  await loginAs(
    tester,
    email: TestUsers.homeUserEmail,
    password: TestUsers.homeUserPassword,
  );
}

/// Logs in with the fresh (non-onboarded) test user.
Future<void> loginAsNewUser(WidgetTester tester) async {
  await loginAs(
    tester,
    email: TestUsers.newUserEmail,
    password: TestUsers.newUserPassword,
  );
}

/// Resets the new test user's onboarding state in the database.
/// Must authenticate first because RLS requires an active session.
/// Call this before [pumpApp] in onboarding tests.
Future<void> resetNewUserOnboarding() async {
  await _initBackend();
  // Sign in so RLS allows the update
  await SupabaseService.client.auth.signInWithPassword(
    email: TestUsers.newUserEmail,
    password: TestUsers.newUserPassword,
  );
  await SupabaseService.client.from('users').update({
    'onboarding_completed': false,
    'skin_type': null,
    'skin_concerns': <String>[],
  }).eq('email', TestUsers.newUserEmail);
  await SupabaseService.client.auth.signOut();
}
