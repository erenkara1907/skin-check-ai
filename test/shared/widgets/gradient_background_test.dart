import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skincheck_ai/core/theme/app_theme.dart';
import 'package:skincheck_ai/shared/widgets/gradient_background.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  group('GradientBackground', () {
    testWidgets('renders child in light mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const GradientBackground(child: Text('Child')),
        ),
      );
      expect(find.text('Child'), findsOneWidget);
    });

    testWidgets('renders child in dark mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const GradientBackground(child: Text('Dark Child')),
        ),
      );
      expect(find.text('Dark Child'), findsOneWidget);
    });

    testWidgets('has a Container with BoxDecoration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const GradientBackground(child: SizedBox()),
        ),
      );
      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.decoration, isA<BoxDecoration>());
    });
  });
}
