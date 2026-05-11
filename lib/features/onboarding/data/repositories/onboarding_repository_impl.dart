import '../../../../core/utils/logger.dart';
import '../../domain/entities/skin_concern.dart';
import '../../domain/entities/skin_type.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_datasource.dart';

/// Implementation of [OnboardingRepository] using Supabase.
class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._dataSource);

  final OnboardingDataSource _dataSource;

  @override
  Future<void> saveProfile({
    required String userId,
    required SkinType skinType,
    required List<SkinConcern> concerns,
  }) async {
    try {
      await _dataSource.saveProfile(
        userId: userId,
        skinType: skinType,
        concerns: concerns,
      );
    } catch (e, st) {
      log.e('Save profile failed', e, st);
      rethrow;
    }
  }

  @override
  Future<void> markComplete({required String userId}) async {
    try {
      await _dataSource.markComplete(userId: userId);
    } catch (e, st) {
      log.e('Mark complete failed', e, st);
      rethrow;
    }
  }

  @override
  Future<void> completeOnboarding({
    required String userId,
    required SkinType skinType,
    required List<SkinConcern> concerns,
  }) async {
    try {
      await _dataSource.completeOnboarding(
        userId: userId,
        skinType: skinType,
        concerns: concerns,
      );
    } catch (e, st) {
      log.e('Complete onboarding failed', e, st);
      rethrow;
    }
  }
}
