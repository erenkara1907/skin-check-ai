import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/core/providers/theme_provider.dart';
import 'package:skincheck_ai/features/settings/presentation/providers/settings_provider.dart';
import 'package:skincheck_ai/features/settings/presentation/screens/settings_screen.dart';
import 'package:skincheck_ai/features/subscription/presentation/providers/subscription_provider.dart';

import '../../../../helpers/test_app.dart';

void main() {
  Widget buildSubject({bool isPro = false}) {
    return pumpableTestApp(
      const SettingsScreen(),
      overrides: [
        isProProvider.overrideWith((_) => isPro),
        themeModeNotifierProvider.overrideWith(ThemeModeNotifier.new),
        notificationEnabledProvider
            .overrideWith(NotificationEnabled.new),
        reminderTimeProvider.overrideWith(ReminderTime.new),
      ],
    );
  }

  group('SettingsScreen', () {
    testWidgets('renders all sections', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('TEMA'), findsOneWidget);
      expect(find.text('BILDIRIMLER'), findsOneWidget);
      expect(find.text('ABONELIK'), findsOneWidget);

      // Scroll down to reveal lower sections
      await tester.scrollUntilVisible(
        find.text('HESAP'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('HESAP'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('HAKKINDA'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('HAKKINDA'), findsOneWidget);
    });

    testWidgets('renders theme options', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('Sistem'), findsOneWidget);
      expect(find.text('Açık'), findsOneWidget);
      expect(find.text('Koyu'), findsOneWidget);
    });

    testWidgets('renders notification toggle', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('Rutin Hatırlatma'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('renders account section tiles', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      final scrollable = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(
        find.text('Verilerimi Dışa Aktar'), 200,
        scrollable: scrollable,
      );
      expect(find.text('Verilerimi Dışa Aktar'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Hesabımı Sil'), 200,
        scrollable: scrollable,
      );
      expect(find.text('Hesabımı Sil'), findsOneWidget);
    });

    testWidgets('renders about section tiles', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      final scrollable = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(
        find.text('Versiyon'), 200,
        scrollable: scrollable,
      );
      expect(find.text('Versiyon'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Gizlilik Politikası'), 200,
        scrollable: scrollable,
      );
      expect(find.text('Gizlilik Politikası'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Kullanım Koşulları'), 200,
        scrollable: scrollable,
      );
      expect(find.text('Kullanım Koşulları'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Lisanslar'), 200,
        scrollable: scrollable,
      );
      expect(find.text('Lisanslar'), findsOneWidget);
    });

    testWidgets('shows upgrade card for free users', (tester) async {
      await tester.pumpWidget(buildSubject(isPro: false));
      await tester.pumpAndSettle();

      expect(find.text("Pro'ya Gec"), findsOneWidget);
    });

    testWidgets('shows pro status for pro users', (tester) async {
      await tester.pumpWidget(buildSubject(isPro: true));
      await tester.pumpAndSettle();

      expect(find.text('Pro uyelik aktif'), findsOneWidget);
      expect(find.text("Pro'ya Gec"), findsNothing);
    });

    testWidgets('shows current plan as free', (tester) async {
      await tester.pumpWidget(buildSubject(isPro: false));
      await tester.pumpAndSettle();

      expect(find.text('Ücretsiz'), findsOneWidget);
    });

    testWidgets('shows current plan as pro', (tester) async {
      await tester.pumpWidget(buildSubject(isPro: true));
      await tester.pumpAndSettle();

      expect(find.text('Pro'), findsWidgets);
    });
  });
}
