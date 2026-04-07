import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skincheck_ai/core/theme/app_theme.dart';
import 'package:skincheck_ai/shared/widgets/app_button.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('AppButton', () {
    testWidgets('primary variant renders', (tester) async {
      var tapped = false;
      await tester.pumpWidget(wrap(
        AppButton(
          label: 'Test',
          onPressed: () => tapped = true,
        ),
      ));
      expect(find.text('Test'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      expect(tapped, true);
    });

    testWidgets('outline variant renders OutlinedButton', (tester) async {
      await tester.pumpWidget(wrap(
        AppButton(
          label: 'Outline',
          variant: AppButtonVariant.outline,
          onPressed: () {},
        ),
      ));
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('text variant renders TextButton', (tester) async {
      await tester.pumpWidget(wrap(
        AppButton(
          label: 'Text',
          variant: AppButtonVariant.text,
          onPressed: () {},
        ),
      ));
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('loading state shows spinner', (tester) async {
      await tester.pumpWidget(wrap(
        AppButton(
          label: 'Loading',
          isLoading: true,
          onPressed: () {},
        ),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('loading state disables tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(wrap(
        AppButton(
          label: 'Loading',
          isLoading: true,
          onPressed: () => tapped = true,
        ),
      ));
      await tester.tap(find.byType(ElevatedButton));
      expect(tapped, false);
    });

    testWidgets('icon is displayed when provided', (tester) async {
      await tester.pumpWidget(wrap(
        AppButton(
          label: 'Icon',
          icon: Icons.check,
          onPressed: () {},
        ),
      ));
      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });
}
