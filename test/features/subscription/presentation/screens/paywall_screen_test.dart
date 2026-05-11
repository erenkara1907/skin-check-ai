import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/subscription/domain/entities/subscription_entity.dart';
import 'package:skincheck_ai/features/subscription/presentation/providers/subscription_provider.dart';
import 'package:skincheck_ai/features/subscription/presentation/screens/paywall_screen.dart';
import 'package:skincheck_ai/features/subscription/presentation/widgets/feature_comparison_table.dart';
import 'package:skincheck_ai/features/subscription/presentation/widgets/plan_card.dart';
import 'package:skincheck_ai/features/subscription/presentation/widgets/paywall_cta_button.dart';

import '../../../../helpers/test_app.dart';

void main() {
  pumpPaywall(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1500, 4500);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      pumpableTestApp(
        const PaywallScreen(),
        overrides: [
          subscriptionNotifierProvider
              .overrideWith(() => _FakeSubscriptionNotifier()),
        ],
      ),
    );
    await tester.pump();
  }

  group('PaywallScreen', () {
    testWidgets('renders header text', (tester) async {
      await pumpPaywall(tester);
      expect(find.text("Pro'ya Geç"), findsOneWidget);
    });

    testWidgets('renders comparison table', (tester) async {
      await pumpPaywall(tester);
      expect(find.byType(FeatureComparisonTable), findsOneWidget);
    });

    testWidgets('renders both plan cards', (tester) async {
      await pumpPaywall(tester);

      expect(find.byType(PlanCard), findsNWidgets(2));
      expect(find.text('Aylık'), findsOneWidget);
      expect(find.text('Yıllık'), findsOneWidget);
    });

    testWidgets('renders CTA button', (tester) async {
      await pumpPaywall(tester);

      expect(find.byType(PaywallCtaButton), findsOneWidget);
      expect(find.text('7 Gün Ücretsiz Dene'), findsOneWidget);
    });

    testWidgets('renders restore button', (tester) async {
      await pumpPaywall(tester);
      expect(find.text('Satın almayı geri yükle'), findsOneWidget);
    });

    testWidgets('renders legal links', (tester) async {
      await pumpPaywall(tester);
      expect(find.text('Gizlilik'), findsOneWidget);
      expect(find.text('Kullanım Koşulları'), findsOneWidget);
    });

    testWidgets('tapping plan card toggles selection', (tester) async {
      await pumpPaywall(tester);

      await tester.tap(find.text('Aylık'));
      await tester.pump();

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
