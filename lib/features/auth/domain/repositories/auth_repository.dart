import '../entities/user_entity.dart';

/// Abstract auth repository interface.
abstract class AuthRepository {
  /// Stream of auth state changes (null = signed out).
  Stream<UserEntity?> authStateChanges();

  /// Currently signed-in user, or null.
  UserEntity? get currentUser;

  /// Sign in with email and password.
  Future<UserEntity> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sign up with email, password and optional name.
  Future<UserEntity> signUp({
    required String email,
    required String password,
    String? name,
  });

  /// Sign in with Google OAuth.
  Future<UserEntity> signInWithGoogle();

  /// Sign in with Apple OAuth.
  Future<UserEntity> signInWithApple();

  /// Sign out the current user.
  Future<void> signOut();
}
