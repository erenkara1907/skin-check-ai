import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skincheck_ai/core/theme/app_colors.dart';
import 'package:skincheck_ai/core/theme/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  group('AppTheme', () {
    testWidgets('light theme has correct brightness', (tester) async {
      await tester.pumpWidget(MaterialApp(theme: AppTheme.light, home: const SizedBox()));
      final theme = Theme.of(tester.element(find.byType(SizedBox)));
      expect(theme.brightness, Brightness.light);
    });

    testWidgets('dark theme has correct brightness', (tester) async {
      await tester.pumpWidget(MaterialApp(theme: AppTheme.dark, home: const SizedBox()));
      final theme = Theme.of(tester.element(find.byType(SizedBox)));
      expect(theme.brightness, Brightness.dark);
    });

    testWidgets('light theme uses primary color', (tester) async {
      await tester.pumpWidget(MaterialApp(theme: AppTheme.light, home: const SizedBox()));
      final theme = Theme.of(tester.element(find.byType(SizedBox)));
      expect(theme.colorScheme.primary, AppColors.primary);
    });

    testWidgets('dark theme uses primary color', (tester) async {
      await tester.pumpWidget(MaterialApp(theme: AppTheme.dark, home: const SizedBox()));
      final theme = Theme.of(tester.element(find.byType(SizedBox)));
      expect(theme.colorScheme.primary, AppColors.primary);
    });

    testWidgets('light theme scaffold background', (tester) async {
      await tester.pumpWidget(MaterialApp(theme: AppTheme.light, home: const SizedBox()));
      final theme = Theme.of(tester.element(find.byType(SizedBox)));
      expect(theme.scaffoldBackgroundColor, AppColors.backgroundLight);
    });

    testWidgets('dark theme scaffold background', (tester) async {
      await tester.pumpWidget(MaterialApp(theme: AppTheme.dark, home: const SizedBox()));
      final theme = Theme.of(tester.element(find.byType(SizedBox)));
      expect(theme.scaffoldBackgroundColor, AppColors.backgroundDark);
    });

    testWidgets('card theme has 16px border radius', (tester) async {
      await tester.pumpWidget(MaterialApp(theme: AppTheme.light, home: const SizedBox()));
      final theme = Theme.of(tester.element(find.byType(SizedBox)));
      final shape = theme.cardTheme.shape as RoundedRectangleBorder;
      final radius = shape.borderRadius as BorderRadius;
      expect(radius.topLeft.x, 16.0);
    });

    testWidgets('elevated button has 0 elevation', (tester) async {
      await tester.pumpWidget(MaterialApp(theme: AppTheme.light, home: const SizedBox()));
      final theme = Theme.of(tester.element(find.byType(SizedBox)));
      final style = theme.elevatedButtonTheme.style!;
      final elevation = style.elevation!.resolve({});
      expect(elevation, 0.0);
    });

    testWidgets('uses Material 3', (tester) async {
      await tester.pumpWidget(MaterialApp(theme: AppTheme.light, home: const SizedBox()));
      final theme = Theme.of(tester.element(find.byType(SizedBox)));
      expect(theme.useMaterial3, true);
    });
  });
}
