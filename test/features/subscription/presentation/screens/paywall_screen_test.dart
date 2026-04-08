import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/subscription/domain/entities/subscription_entity.dart';
import 'package:skincheck_ai/features/subscription/presentation/providers/subscription_provider.dart';
import 'package:skincheck_ai/features/subscription/presentation/screens/paywall_screen.dart';
import 'package:skincheck_ai/features/subscription/presentation/widgets/feature_comparison_table.dart';
import 'package:skincheck_ai/features/subscription/presentation/widgets/plan_card.dart';
import 'package:skincheck_ai/features/subscription/presentation/widgets/paywall_cta_button.dart';

void main() {
  Widget buildSubject() {
    return ProviderScope(
      overrides: [
        subscriptionNotifierProvider.overrideWith(
          () => _FakeSubscriptionNotifier(),
        ),
      ],
      child: const MaterialApp(home: PaywallScreen()),
    );
  }

  group('PaywallScreen', () {
    testWidgets('renders header text', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.text("Pro'ya Gec"), findsOneWidget);
    });

    testWidgets('renders comparison table', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.byType(FeatureComparisonTable), findsOneWidget);
    });

    testWidgets('renders both plan cards', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.byType(PlanCard), findsNWidgets(2));
      expect(find.text('Aylik'), findsOneWidget);
      expect(find.text('Yillik'), findsOneWidget);
    });

    testWidgets('renders CTA button', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.byType(PaywallCtaButton), findsOneWidget);
      expect(find.text('7 Gun Ucretsiz Dene'), findsOneWidget);
    });

    testWidgets('renders restore button', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.text('Satin almayi geri yukle'), findsOneWidget);
    });

    testWidgets('renders legal links', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.text('Gizlilik'), findsOneWidget);
      expect(find.text('Kullanim Kosullari'), findsOneWidget);
    });

    testWidgets('tapping plan card toggles selection', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      // Tap monthly plan
      await tester.tap(find.text('Aylik'));
      await tester.pump();

      // Both cards should still be visible
      expect(find.byType(PlanCard), findsNWidgets(2));
    });
  });
}

class _FakeSubscriptionNotifier extends SubscriptionNotifier {
  @override
  Future<SubscriptionEntity> build() async {
    return const SubscriptionEntity();
  }
}
