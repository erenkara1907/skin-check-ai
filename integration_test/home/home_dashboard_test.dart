import 'package:flutter_test/flutter_test.dart';

import 'package:skincheck_ai/features/analysis/presentation/screens/camera_screen.dart';
import 'package:skincheck_ai/features/home/presentation/screens/home_screen.dart';

import '../common/test_app.dart';

void main() {
  ensureBinding();

  testWidgets('Home — shows dashboard after login', (tester) async {
    await pumpApp(tester);
    await loginAsHomeUser(tester);

    await waitFor(tester, find.byType(HomeScreen));
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Home — start analysis navigates to camera', (tester) async {
    await pumpApp(tester);
    await loginAsHomeUser(tester);

    await waitFor(tester, find.byType(HomeScreen));

    // Tap the analysis start button (text varies by state)
    final cameraBtn = find.text('Kamerayi Ac');
    final startBtn = find.text('Başlat');
    final reanalyzeBtn = find.text('Yeniden Analiz');

    if (cameraBtn.evaluate().isNotEmpty) {
      await tester.tap(cameraBtn);
    } else if (startBtn.evaluate().isNotEmpty) {
      await tester.tap(startBtn);
    } else if (reanalyzeBtn.evaluate().isNotEmpty) {
      await tester.tap(reanalyzeBtn);
    }

    await waitFor(
      tester,
      find.byType(CameraScreen),
      timeout: const Duration(seconds: 10),
    );
  });

  testWidgets('Home — pull to refresh works without crash', (tester) async {
    await pumpApp(tester);
    await loginAsHomeUser(tester);

    await waitFor(tester, find.byType(HomeScreen));

    // Pull to refresh
    await tester.drag(find.byType(HomeScreen), const Offset(0, 300));
    await settle(tester);

    // Should still be on home screen (no crash)
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
