// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileRepositoryHash() => r'daf136edf8fbd502e8e72beb199a5ca75b439827';

/// Provides the [ProfileRepository] instance.
///
/// Copied from [profileRepository].
@ProviderFor(profileRepository)
final profileRepositoryProvider = Provider<ProfileRepository>.internal(
  profileRepository,
  name: r'profileRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profileRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileRepositoryRef = ProviderRef<ProfileRepository>;
String _$analysisCountHash() => r'8b921d44283e101648ce9a89a817584442adadd1';

/// Total analysis count for the current user.
///
/// Copied from [analysisCount].
@ProviderFor(analysisCount)
final analysisCountProvider = AutoDisposeFutureProvider<int>.internal(
  analysisCount,
  name: r'analysisCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$analysisCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AnalysisCountRef = AutoDisposeFutureProviderRef<int>;
String _$joinDateHash() => r'ae4f9faf8db4d110f61a2dc254959019fda39ef5';

/// Account creation date for the current user.
///
/// Copied from [joinDate].
@ProviderFor(joinDate)
final joinDateProvider = AutoDisposeFutureProvider<DateTime?>.internal(
  joinDate,
  name: r'joinDateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$joinDateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JoinDateRef = AutoDisposeFutureProviderRef<DateTime?>;
String _$currentAuthProviderHash() =>
    r'67e1fee91f852e461ed74883c47932837a0c9a14';

/// Authentication provider for the current session
/// (`email`, `google`, `apple`). Used to hide the "Change Password"
/// entry for OAuth users who never set a password.
///
/// Copied from [currentAuthProvider].
@ProviderFor(currentAuthProvider)
final currentAuthProviderProvider = AutoDisposeProvider<String?>.internal(
  currentAuthProvider,
  name: r'currentAuthProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentAuthProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentAuthProviderRef = AutoDisposeProviderRef<String?>;
String _$profileActionsHash() => r'5ba1f65b9e9a1e1f4f3f6315b95424c12e91ddf8';

/// Manages profile update operations.
///
/// Copied from [ProfileActions].
@ProviderFor(ProfileActions)
final profileActionsProvider =
    AutoDisposeAsyncNotifierProvider<ProfileActions, void>.internal(
      ProfileActions.new,
      name: r'profileActionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProfileActions = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
