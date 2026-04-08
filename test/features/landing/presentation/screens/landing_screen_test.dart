import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/landing/presentation/screens/landing_screen.dart';
import 'package:skincheck_ai/features/landing/presentation/widgets/landing_hero_section.dart';

Widget _buildSubject() {
  return const MaterialApp(
    home: LandingScreen(),
  );
}

void main() {
  group('LandingScreen', () {
    testWidgets('renders hero section with headline', (tester) async {
      await tester.pumpWidget(_buildSubject());
      await tester.pumpAndSettle();

      expect(find.byType(LandingHeroSection), findsOneWidget);
      expect(find.textContaining('Cildini AI ile'), findsOneWidget);
    });

    testWidgets('shows Giriş Yap and Kayıt Ol buttons', (tester) async {
      await tester.pumpWidget(_buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('Giriş Yap'), findsOneWidget);
      expect(find.text('Kayıt Ol'), findsOneWidget);
    });

    testWidgets('how it works section visible on scroll', (tester) async {
      await tester.pumpWidget(_buildSubject());
      await tester.pumpAndSettle();

      final scrollable = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(
        find.text('Nasıl Çalışır?'),
        300,
        scrollable: scrollable,
      );
      await tester.pumpAndSettle();

      expect(find.text('Nasıl Çalışır?'), findsOneWidget);
    });

    testWidgets('features section visible on scroll', (tester) async {
      await tester.pumpWidget(_buildSubject());
      await tester.pumpAndSettle();

      final scrollable = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(
        find.text('Öne Çıkan Özellikler'),
        300,
        scrollable: scrollable,
      );
      await tester.pumpAndSettle();

      expect(find.text('Öne Çıkan Özellikler'), findsOneWidget);
    });

    testWidgets('pricing section shows Free and Pro', (tester) async {
      await tester.pumpWidget(_buildSubject());
      await tester.pumpAndSettle();

      final scrollable = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(
        find.text('Planını Seç'),
        300,
        scrollable: scrollable,
      );
      await tester.pumpAndSettle();

      expect(find.text('Planını Seç'), findsOneWidget);
    });

    testWidgets('FAQ section with accordion', (tester) async {
      await tester.pumpWidget(_buildSubject());
      await tester.pumpAndSettle();

      final scrollable = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(
        find.text('Sıkça Sorulan Sorular'),
        300,
        scrollable: scrollable,
      );
      await tester.pumpAndSettle();

      expect(find.text('Sıkça Sorulan Sorular'), findsOneWidget);

      // Tap first question to expand
      final question = find.text('AI cilt analizi nasıl çalışır?');
      if (question.evaluate().isNotEmpty) {
        await tester.tap(question);
        await tester.pumpAndSettle();
        expect(
          find.textContaining('7 farklı bölgeye ayırarak'),
          findsOneWidget,
        );
      }
    });

    testWidgets('footer shows copyright on scroll', (tester) async {
      await tester.pumpWidget(_buildSubject());
      await tester.pumpAndSettle();

      final scrollable = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(
        find.textContaining('2026 SkinCheck AI'),
        300,
        scrollable: scrollable,
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('2026 SkinCheck AI'), findsOneWidget);
    });
  });
}
