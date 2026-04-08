import '../../../auth/domain/entities/user_entity.dart';

/// Abstract profile repository interface.
abstract class ProfileRepository {
  /// Updates the user's name and email.
  Future<UserEntity> updateProfile({
    required String userId,
    String? name,
    String? email,
  });

  /// Fetches the total analysis count for a user.
  Future<int> getAnalysisCount(String userId);

  /// Fetches the user's account creation date.
  Future<DateTime?> getJoinDate(String userId);

  /// Exports all user data as a JSON map.
  Future<Map<String, dynamic>> exportUserData(String userId);

  /// Deletes the user account and all associated data.
  Future<void> deleteAccount(String userId);
}
