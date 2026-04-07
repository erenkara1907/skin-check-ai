import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/config/env_config.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/user_entity.dart';

/// Supabase authentication data source.
class SupabaseAuthDataSource {
  SupabaseAuthDataSource(this._client);

  final SupabaseClient _client;

  /// Stream of auth state changes mapped to [UserEntity].
  Stream<UserEntity?> authStateChanges() {
    return _client.auth.onAuthStateChange.map((event) {
      final user = event.session?.user;
      return user != null ? _mapUser(user) : null;
    });
  }

  /// Currently signed-in user, or null.
  UserEntity? get currentUser {
    final user = _client.auth.currentUser;
    return user != null ? _mapUser(user) : null;
  }

  /// Sign in with email and password.
  Future<UserEntity> signInWithEmail({
    required String email,
    required String password,
  }) async {
    log.d('Signing in with email: $email');
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return _mapUser(response.user!);
  }

  /// Sign up with email, password and optional name.
  Future<UserEntity> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    log.d('Signing up with email: $email');
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: name != null ? {'name': name} : null,
    );
    return _mapUser(response.user!);
  }

  /// Sign in with Google using native SDK + Supabase ID token.
  Future<UserEntity> signInWithGoogle() async {
    log.d('Signing in with Google (native)');

    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize(
      clientId: EnvConfig.googleClientIdIos,
      serverClientId: EnvConfig.googleWebClientId,
    );

    final account = await googleSignIn.authenticate();
    final idToken = account.authentication.idToken;

    if (idToken == null) {
      throw Exception('No ID token from Google');
    }

    final response = await _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );

    return _mapUser(response.user!);
  }

  /// Sign in with Apple OAuth.
  Future<void> signInWithApple() async {
    log.d('Signing in with Apple');
    await _client.auth.signInWithOAuth(
      OAuthProvider.apple,
      redirectTo: 'io.supabase.skincheckAI://login-callback/',
    );
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    log.d('Signing out');
    await _client.auth.signOut();
  }

  UserEntity _mapUser(User user) {
    return UserEntity(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] as String? ??
          user.userMetadata?['full_name'] as String?,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
    );
  }
}
