import 'dart:typed_data';

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

/// Total number of onboarding pages.
const kOnboardingPageCount = 7;

/// State for the onboarding flow.
class OnboardingState {
  const OnboardingState({
    this.currentPage = 0,
    this.selectedSkinType,
    this.selectedConcerns = const {},
    this.isLoading = false,
    this.profileSaved = false,
    this.capturedPhoto,
    this.analysisStarted = false,
  });

  final int currentPage;
  final SkinType? selectedSkinType;
  final Set<SkinConcern> selectedConcerns;
  final bool isLoading;
  final bool profileSaved;
  final Uint8List? capturedPhoto;
  final bool analysisStarted;

  /// Whether the user can proceed from the current page.
  bool get canProceed {
    switch (currentPage) {
      case 4:
        return selectedSkinType != null;
      case 5:
        return selectedConcerns.isNotEmpty;
      default:
        return true;
    }
  }

  OnboardingState copyWith({
    int? currentPage,
    SkinType? selectedSkinType,
    Set<SkinConcern>? selectedConcerns,
    bool? isLoading,
    bool? profileSaved,
    Uint8List? capturedPhoto,
    bool? analysisStarted,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      selectedSkinType: selectedSkinType ?? this.selectedSkinType,
      selectedConcerns: selectedConcerns ?? this.selectedConcerns,
      isLoading: isLoading ?? this.isLoading,
      profileSaved: profileSaved ?? this.profileSaved,
      capturedPhoto: capturedPhoto ?? this.capturedPhoto,
      analysisStarted: analysisStarted ?? this.analysisStarted,
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
    if (state.currentPage < kOnboardingPageCount - 1) {
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

  /// Store captured photo bytes.
  void setCapturedPhoto(Uint8List bytes) {
    state = state.copyWith(capturedPhoto: bytes, analysisStarted: true);
  }

  /// Save profile data without completing onboarding.
  Future<bool> saveProfile() async {
    final user = ref.read(authNotifierProvider).valueOrNull;
    if (user == null || state.selectedSkinType == null) return false;

    state = state.copyWith(isLoading: true);
    try {
      final repo = ref.read(onboardingRepositoryProvider);
      await repo.saveProfile(
        userId: user.id,
        skinType: state.selectedSkinType!,
        concerns: state.selectedConcerns.toList(),
      );
      log.i('Profile saved for user: ${user.id}');
      state = state.copyWith(isLoading: false, profileSaved: true);
      return true;
    } catch (e, st) {
      log.e('Profile save failed', e, st);
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  /// Mark onboarding as complete and navigate to home.
  Future<bool> finishOnboarding() async {
    final user = ref.read(authNotifierProvider).valueOrNull;
    if (user == null) return false;

    state = state.copyWith(isLoading: true);
    try {
      final repo = ref.read(onboardingRepositoryProvider);

      // If profile wasn't saved yet, do full save
      if (!state.profileSaved && state.selectedSkinType != null) {
        await repo.completeOnboarding(
          userId: user.id,
          skinType: state.selectedSkinType!,
          concerns: state.selectedConcerns.toList(),
        );
      } else {
        await repo.markComplete(userId: user.id);
      }

      log.i('Onboarding completed for user: ${user.id}');
      ref.invalidate(userProfileProvider);
      return true;
    } catch (e, st) {
      log.e('Onboarding completion failed', e, st);
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  /// Legacy method — saves profile and marks complete in one call.
  Future<bool> completeOnboarding() async {
    return finishOnboarding();
  }
}
