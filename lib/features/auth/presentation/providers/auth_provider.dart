import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/logger.dart';
import '../../data/datasources/supabase_auth_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_provider.g.dart';

/// Provides the [AuthRepository] instance.
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    SupabaseAuthDataSource(SupabaseService.client),
  );
}

/// Manages authentication state across the app.
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  late final AuthRepository _repo;

  @override
  FutureOr<UserEntity?> build() {
    _repo = ref.read(authRepositoryProvider);
    _listenAuthChanges();
    return _repo.currentUser;
  }

  void _listenAuthChanges() {
    _repo.authStateChanges().listen(
      (user) => state = AsyncData(user),
      onError: (e, st) {
        log.e('Auth state error', e, st);
        state = AsyncError(e, st);
      },
    );
  }

  /// Sign in with email and password.
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _repo.signInWithEmail(email: email, password: password),
    );
  }

  /// Sign up with email, password and name.
  Future<void> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _repo.signUp(email: email, password: password, name: name),
    );
  }

  /// Sign in with Google.
  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signInWithGoogle());
  }

  /// Sign in with Apple.
  Future<void> signInWithApple() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signInWithApple());
  }

  /// Sign out.
  Future<void> signOut() async {
    await _repo.signOut();
    state = const AsyncData(null);
  }
}

/// Whether the user is currently authenticated.
@riverpod
bool isAuthenticated(Ref ref) {
  final auth = ref.watch(authNotifierProvider);
  return auth.valueOrNull != null;
}
