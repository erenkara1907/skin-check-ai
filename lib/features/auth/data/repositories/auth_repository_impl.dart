import '../../../../core/utils/logger.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/supabase_auth_datasource.dart';

/// Implementation of [AuthRepository] using Supabase.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final SupabaseAuthDataSource _dataSource;

  @override
  Stream<UserEntity?> authStateChanges() => _dataSource.authStateChanges();

  @override
  UserEntity? get currentUser => _dataSource.currentUser;

  @override
  Future<UserEntity> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _dataSource.signInWithEmail(
        email: email,
        password: password,
      );
    } catch (e, st) {
      log.e('Sign in failed', e, st);
      rethrow;
    }
  }

  @override
  Future<UserEntity> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      return await _dataSource.signUp(
        email: email,
        password: password,
        name: name,
      );
    } catch (e, st) {
      log.e('Sign up failed', e, st);
      rethrow;
    }
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      await _dataSource.signInWithGoogle();
      // OAuth returns via deep link; listen to authStateChanges
      return await authStateChanges()
          .where((user) => user != null)
          .map((user) => user!)
          .first;
    } catch (e, st) {
      log.e('Google sign in failed', e, st);
      rethrow;
    }
  }

  @override
  Future<UserEntity> signInWithApple() async {
    try {
      await _dataSource.signInWithApple();
      return await authStateChanges()
          .where((user) => user != null)
          .map((user) => user!)
          .first;
    } catch (e, st) {
      log.e('Apple sign in failed', e, st);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _dataSource.signOut();
    } catch (e, st) {
      log.e('Sign out failed', e, st);
      rethrow;
    }
  }

  @override
  String? get authProvider => _dataSource.authProvider;

  @override
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _dataSource.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } catch (e, st) {
      log.e('Password update failed', e, st);
      rethrow;
    }
  }

  @override
  Future<UserEntity> fetchUserProfile(String userId) async {
    try {
      return await _dataSource.fetchUserProfile(userId);
    } catch (e, st) {
      log.e('Fetch user profile failed', e, st);
      rethrow;
    }
  }
}
