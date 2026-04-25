import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/onboarding/presentation/screens/onboarding_screen.dart';

import '../../../../helpers/test_app.dart';

void main() {
  setUp(() {
    Animate.restartOnHotReload = false;
  });

  Future<void> pumpOnboarding(WidgetTester tester) async {
    // FirstAnalysisPage is laid out for phone form factors; the default test
    // surface (800x600) overflows by ~15px. Bump the surface to phone height.
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(pumpableTestApp(const OnboardingScreen()));
    // Bounded pumps — flutter_animate effects don't fully settle.
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
  }

  group('OnboardingScreen', () {
    testWidgets('renders first-analysis intro page initially',
        (tester) async {
      await pumpOnboarding(tester);

      expect(find.text('Hadi İlk Analizini\nYapalım!'), findsOneWidget);
      expect(
        find.text('3 adımda cildin hakkında her şeyi öğren'),
        findsOneWidget,
      );
    });

    testWidgets('shows Open Camera and Skip buttons', (tester) async {
      await pumpOnboarding(tester);

      expect(find.text('Kamerayı Aç'), findsOneWidget);
      expect(find.text('Şimdilik Atla'), findsOneWidget);
    });
  });
}
