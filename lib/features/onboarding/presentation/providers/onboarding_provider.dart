import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/logger.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/onboarding_datasource.dart';
import '../../data/repositories/onboarding_repository_impl.dart';
import '../../domain/entities/skin_concern.dart';
import '../../domain/entities/skin_type.dart';
import '../../domain/repositories/onboarding_repository.dart';

part 'onboarding_provider.g.dart';

/// Provides the [OnboardingRepository] instance.
@riverpod
OnboardingRepository onboardingRepository(Ref ref) {
  return OnboardingRepositoryImpl(
    OnboardingDataSource(SupabaseService.client),
  );
}

/// State for the onboarding flow.
class OnboardingState {
  const OnboardingState({
    this.currentPage = 0,
    this.selectedSkinType,
    this.selectedConcerns = const {},
    this.isLoading = false,
  });

  final int currentPage;
  final SkinType? selectedSkinType;
  final Set<SkinConcern> selectedConcerns;
  final bool isLoading;

  /// Whether the user can proceed from the current page.
  bool get canProceed {
    switch (currentPage) {
      case 0:
        return true;
      case 1:
        return selectedSkinType != null;
      case 2:
        return selectedConcerns.isNotEmpty;
      case 3:
        return true;
      default:
        return false;
    }
  }

  OnboardingState copyWith({
    int? currentPage,
    SkinType? selectedSkinType,
    Set<SkinConcern>? selectedConcerns,
    bool? isLoading,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      selectedSkinType: selectedSkinType ?? this.selectedSkinType,
      selectedConcerns: selectedConcerns ?? this.selectedConcerns,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Manages the onboarding flow state.
@riverpod
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  OnboardingState build() => const OnboardingState();

  /// Navigate to the next page.
  void nextPage() {
    if (state.currentPage < 3) {
      state = state.copyWith(currentPage: state.currentPage + 1);
    }
  }

  /// Navigate to a specific page.
  void goToPage(int page) {
    state = state.copyWith(currentPage: page);
  }

  /// Select a skin type.
  void selectSkinType(SkinType type) {
    state = state.copyWith(selectedSkinType: type);
  }

  /// Toggle a skin concern selection.
  void toggleConcern(SkinConcern concern) {
    final concerns = Set<SkinConcern>.from(state.selectedConcerns);
    if (concerns.contains(concern)) {
      concerns.remove(concern);
    } else {
      concerns.add(concern);
    }
    state = state.copyWith(selectedConcerns: concerns);
  }

  /// Save onboarding data to Supabase and complete.
  Future<bool> completeOnboarding() async {
    final user = ref.read(authNotifierProvider).valueOrNull;
    if (user == null || state.selectedSkinType == null) return false;

    state = state.copyWith(isLoading: true);
    try {
      final repo = ref.read(onboardingRepositoryProvider);
      await repo.completeOnboarding(
        userId: user.id,
        skinType: state.selectedSkinType!,
        concerns: state.selectedConcerns.toList(),
      );
      log.i('Onboarding completed for user: ${user.id}');
      return true;
    } catch (e, st) {
      log.e('Onboarding completion failed', e, st);
      state = state.copyWith(isLoading: false);
      return false;
    }
  }
}
