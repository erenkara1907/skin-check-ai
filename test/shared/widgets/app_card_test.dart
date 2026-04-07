import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skincheck_ai/core/theme/app_theme.dart';
import 'package:skincheck_ai/shared/widgets/app_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  Widget wrap(Widget child, {bool dark = false}) {
    return MaterialApp(
      theme: dark ? AppTheme.dark : AppTheme.light,
      home: Scaffold(body: child),
    );
  }

  group('AppCard', () {
    testWidgets('renders child content', (tester) async {
      await tester.pumpWidget(wrap(
        const AppCard(child: Text('Hello')),
      ));
      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('applies backdrop filter', (tester) async {
      await tester.pumpWidget(wrap(
        const AppCard(child: Text('Blur')),
      ));
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('renders in dark mode', (tester) async {
      await tester.pumpWidget(wrap(
        const AppCard(child: Text('Dark')),
        dark: true,
      ));
      expect(find.text('Dark'), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('onTap fires callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(wrap(
        AppCard(
          onTap: () => tapped = true,
          child: const Text('Tap'),
        ),
      ));
      await tester.tap(find.text('Tap'));
      expect(tapped, true);
    });
  });
}
