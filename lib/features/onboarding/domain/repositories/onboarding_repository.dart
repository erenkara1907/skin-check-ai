import '../entities/skin_concern.dart';
import '../entities/skin_type.dart';

/// Repository interface for onboarding data persistence.
abstract class OnboardingRepository {
  /// Saves onboarding selections and marks onboarding as completed.
  Future<void> completeOnboarding({
    required String userId,
    required SkinType skinType,
    required List<SkinConcern> concerns,
  });
}
