import 'package:flutter_test/flutter_test.dart';

import 'package:skincheck_ai/features/profile/presentation/screens/profile_screen.dart';
import 'package:skincheck_ai/features/settings/presentation/screens/settings_screen.dart';

import '../common/test_app.dart';

void main() {
  ensureBinding();

  testWidgets('Profile — shows profile screen with user info', (tester) async {
    await pumpApp(tester);
    await loginAsHomeUser(tester);

    // Navigate to profile tab
    await tester.tap(find.text('Profil'));
    await settle(tester);
    await waitFor(tester, find.byType(ProfileScreen));

    expect(find.byType(ProfileScreen), findsOneWidget);
  });

  testWidgets('Profile — navigates to settings', (tester) async {
    await pumpApp(tester);
    await loginAsHomeUser(tester);

    await tester.tap(find.text('Profil'));
    await settle(tester);
    await waitFor(tester, find.byType(ProfileScreen));

    // Tap settings — use waitFor to find the button first
    await waitFor(tester, find.text('Ayarlar'));
    await tester.tap(find.text('Ayarlar'));

    // Use waitFor instead of settle to avoid pumpAndSettle timeout
    await waitFor(tester, find.byType(SettingsScreen));
    expect(find.byType(SettingsScreen), findsOneWidget);
  });
}
