import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skincheck_ai/core/theme/app_theme.dart';
import 'package:skincheck_ai/shared/widgets/score_circle.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('ScoreCircle', () {
    testWidgets('displays score after animation', (tester) async {
      await tester.pumpWidget(wrap(
        const ScoreCircle(score: 85),
      ));
      await tester.pumpAndSettle();
      expect(find.text('85'), findsOneWidget);
    });

    testWidgets('displays label when provided', (tester) async {
      await tester.pumpWidget(wrap(
        const ScoreCircle(score: 50, label: 'Overall'),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Overall'), findsOneWidget);
    });

    testWidgets('shows 0 at start of animation', (tester) async {
      await tester.pumpWidget(wrap(
        const ScoreCircle(score: 75),
      ));
      // First frame
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('renders custom paint for arc', (tester) async {
      await tester.pumpWidget(wrap(
        const ScoreCircle(score: 60),
      ));
      expect(find.byType(CustomPaint), findsWidgets);
    });
  });
}
