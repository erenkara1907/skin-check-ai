// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'f6e7342312b805bd44777819d0c1a4055e6c2871';

/// Provides the [AuthRepository] instance.
///
/// Copied from [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$isAuthenticatedHash() => r'5c7a3f80c080a2e4381dd3f9e772717e1bb7d064';

/// Whether the user is currently authenticated.
///
/// Copied from [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = AutoDisposeProvider<bool>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAuthenticatedRef = AutoDisposeProviderRef<bool>;
String _$isOnboardingCompletedHash() =>
    r'4dead17c2345f2d73e9231447baa36c9c3f1f5ba';

/// Whether the user has completed onboarding.
///
/// Copied from [isOnboardingCompleted].
@ProviderFor(isOnboardingCompleted)
final isOnboardingCompletedProvider = AutoDisposeProvider<bool>.internal(
  isOnboardingCompleted,
  name: r'isOnboardingCompletedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isOnboardingCompletedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsOnboardingCompletedRef = AutoDisposeProviderRef<bool>;
String _$authNotifierHash() => r'd22cf8847dd6ea8b56abba4f124db855b204a9b0';

/// Manages authentication state across the app.
///
/// Copied from [AuthNotifier].
@ProviderFor(AuthNotifier)
final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, UserEntity?>.internal(
      AuthNotifier.new,
      name: r'authNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AuthNotifier = AsyncNotifier<UserEntity?>;
String _$userProfileHash() => r'd11ac886f3a5ca48e98fcfdceb42b49627ddd56e';

/// Fetches the full user profile from the database.
///
/// Copied from [UserProfile].
@ProviderFor(UserProfile)
final userProfileProvider =
    AsyncNotifierProvider<UserProfile, UserEntity?>.internal(
      UserProfile.new,
      name: r'userProfileProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userProfileHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UserProfile = AsyncNotifier<UserEntity?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
