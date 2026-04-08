import '../../../../core/utils/logger.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_datasource.dart';

/// Implementation of [ProfileRepository] using Supabase.
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._datasource);

  final ProfileDatasource _datasource;

  @override
  Future<UserEntity> updateProfile({
    required String userId,
    String? name,
    String? email,
  }) async {
    try {
      return await _datasource.updateProfile(
        userId: userId,
        name: name,
        email: email,
      );
    } catch (e, st) {
      log.e('Update profile failed', e, st);
      rethrow;
    }
  }

  @override
  Future<int> getAnalysisCount(String userId) async {
    try {
      return await _datasource.getAnalysisCount(userId);
    } catch (e, st) {
      log.e('Get analysis count failed', e, st);
      rethrow;
    }
  }

  @override
  Future<DateTime?> getJoinDate(String userId) async {
    try {
      return await _datasource.getJoinDate(userId);
    } catch (e, st) {
      log.e('Get join date failed', e, st);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> exportUserData(String userId) async {
    try {
      return await _datasource.exportUserData(userId);
    } catch (e, st) {
      log.e('Export user data failed', e, st);
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount(String userId) async {
    try {
      await _datasource.deleteAccount(userId);
    } catch (e, st) {
      log.e('Delete account failed', e, st);
      rethrow;
    }
  }
}
