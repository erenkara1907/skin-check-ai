import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/onboarding/domain/entities/skin_concern.dart';
import 'package:skincheck_ai/features/onboarding/domain/entities/skin_type.dart';
import 'package:skincheck_ai/features/onboarding/presentation/providers/onboarding_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('OnboardingNotifier', () {
    test('initial state has defaults', () {
      final state = container.read(onboardingNotifierProvider);
      expect(state.currentPage, 0);
      expect(state.selectedSkinType, isNull);
      expect(state.selectedConcerns, isEmpty);
      expect(state.isLoading, false);
    });

    test('nextPage increments current page', () {
      final notifier =
          container.read(onboardingNotifierProvider.notifier);
      notifier.nextPage();
      expect(container.read(onboardingNotifierProvider).currentPage, 1);
    });

    test('nextPage does not exceed max page', () {
      final notifier =
          container.read(onboardingNotifierProvider.notifier);
      notifier.goToPage(3);
      notifier.nextPage();
      expect(container.read(onboardingNotifierProvider).currentPage, 3);
    });

    test('goToPage sets specific page', () {
      final notifier =
          container.read(onboardingNotifierProvider.notifier);
      notifier.goToPage(2);
      expect(container.read(onboardingNotifierProvider).currentPage, 2);
    });

    test('selectSkinType updates state', () {
      final notifier =
          container.read(onboardingNotifierProvider.notifier);
      notifier.selectSkinType(SkinType.oily);
      expect(
        container.read(onboardingNotifierProvider).selectedSkinType,
        SkinType.oily,
      );
    });

    test('toggleConcern adds and removes', () {
      final notifier =
          container.read(onboardingNotifierProvider.notifier);

      notifier.toggleConcern(SkinConcern.acne);
      expect(
        container.read(onboardingNotifierProvider).selectedConcerns,
        {SkinConcern.acne},
      );

      notifier.toggleConcern(SkinConcern.redness);
      expect(
        container.read(onboardingNotifierProvider).selectedConcerns,
        {SkinConcern.acne, SkinConcern.redness},
      );

      notifier.toggleConcern(SkinConcern.acne);
      expect(
        container.read(onboardingNotifierProvider).selectedConcerns,
        {SkinConcern.redness},
      );
    });
  });

  group('OnboardingState.canProceed', () {
    test('page 0 always true', () {
      const state = OnboardingState(currentPage: 0);
      expect(state.canProceed, true);
    });

    test('page 1 requires skin type', () {
      const stateNo = OnboardingState(currentPage: 1);
      expect(stateNo.canProceed, false);

      const stateYes = OnboardingState(
        currentPage: 1,
        selectedSkinType: SkinType.dry,
      );
      expect(stateYes.canProceed, true);
    });

    test('page 2 requires at least one concern', () {
      const stateNo = OnboardingState(currentPage: 2);
      expect(stateNo.canProceed, false);

      const stateYes = OnboardingState(
        currentPage: 2,
        selectedConcerns: {SkinConcern.spots},
      );
      expect(stateYes.canProceed, true);
    });

    test('page 3 always true', () {
      const state = OnboardingState(currentPage: 3);
      expect(state.canProceed, true);
    });
  });
}
