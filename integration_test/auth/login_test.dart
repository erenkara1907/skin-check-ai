import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:skincheck_ai/features/auth/presentation/screens/login_screen.dart';
import 'package:skincheck_ai/features/auth/presentation/screens/sign_up_screen.dart';

import '../common/test_app.dart';
import '../common/test_constants.dart';

void main() {
  ensureBinding();

  testWidgets('Login — shows validation errors on empty submit',
      (tester) async {
    await pumpApp(tester);

    // Wait for login screen to fully load (first test needs extra warm-up)
    await waitFor(tester, find.byKey(const Key('loginEmailField')));

    // Tap login button without entering anything
    await tester.tap(find.byKey(const Key('loginSubmitButton')));
    await tester.pumpAndSettle();

    // Verify validation errors
    expect(find.text('E-posta gerekli'), findsOneWidget);
    expect(find.text('Şifre gerekli'), findsOneWidget);
  });

  testWidgets('Login — shows error on invalid credentials', (tester) async {
    await pumpApp(tester);

    await waitFor(tester, find.byKey(const Key('loginEmailField')));

    await tester.enterText(
      find.byKey(const Key('loginEmailField')),
      'wrong@email.com',
    );
    await tester.enterText(
      find.byKey(const Key('loginPasswordField')),
      'wrongpassword',
    );

    await tester.tap(find.byKey(const Key('loginSubmitButton')));
    await tester.pump();

    // Wait for network response
    await Future<void>.delayed(TestTimeouts.network);
    await tester.pump();

    // Verify error snackbar
    expect(
      find.text('Giriş başarısız. Lütfen tekrar deneyin.'),
      findsOneWidget,
    );
  });

  testWidgets('Login — successfully logs in with email', (tester) async {
    await pumpApp(tester);
    await loginAsHomeUser(tester);

    // Should navigate away from login screen
    expect(find.byType(LoginScreen), findsNothing);
  });

  testWidgets('Login — navigates to sign up screen', (tester) async {
    await pumpApp(tester);

    await waitFor(tester, find.text('Kayıt Ol'));

    await tester.tap(find.text('Kayıt Ol'));
    await settle(tester);

    expect(find.byType(SignUpScreen), findsOneWidget);
  });
}
