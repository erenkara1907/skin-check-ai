import 'package:flutter_test/flutter_test.dart';

import 'package:skincheck_ai/features/home/presentation/screens/home_screen.dart';
import 'package:skincheck_ai/features/profile/presentation/screens/profile_screen.dart';
import 'package:skincheck_ai/features/progress/presentation/screens/progress_screen.dart';
import 'package:skincheck_ai/features/routine/presentation/screens/routine_screen.dart';

import '../common/test_app.dart';

void main() {
  ensureBinding();

  testWidgets('Bottom nav — navigates through 4 tabs', (tester) async {
    await pumpApp(tester);
    await loginAsHomeUser(tester);

    // Should start on Home
    await waitFor(tester, find.byType(HomeScreen));
    expect(find.byType(HomeScreen), findsOneWidget);

    // Tap "Ilerleme" → ProgressScreen
    await tester.tap(find.text('Ilerleme'));
    await settle(tester);
    expect(find.byType(ProgressScreen), findsOneWidget);

    // Tap "Rutin" → RoutineScreen
    await tester.tap(find.text('Rutin'));
    await settle(tester);
    expect(find.byType(RoutineScreen), findsOneWidget);

    // Tap "Profil" → ProfileScreen
    await tester.tap(find.text('Profil'));
    await settle(tester);
    expect(find.byType(ProfileScreen), findsOneWidget);

    // Tap "Ana Sayfa" → back to HomeScreen
    await tester.tap(find.text('Ana Sayfa'));
    await settle(tester);
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
