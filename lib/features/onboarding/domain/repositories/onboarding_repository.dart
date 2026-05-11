import '../entities/skin_concern.dart';
import '../entities/skin_type.dart';

/// Repository interface for onboarding data persistence.
abstract class OnboardingRepository {
  /// Saves skin type and concerns without marking onboarding complete.
  Future<void> saveProfile({
    required String userId,
    required SkinType skinType,
    required List<SkinConcern> concerns,
  });

  /// Marks onboarding as completed.
  Future<void> markComplete({required String userId});

  /// Saves onboarding selections and marks onboarding as completed.
  Future<void> completeOnboarding({
    required String userId,
    required SkinType skinType,
    required List<SkinConcern> concerns,
  });
}
