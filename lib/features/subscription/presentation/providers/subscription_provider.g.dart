// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$subscriptionRepositoryHash() =>
    r'0a1d4f2326dce40bf84405af35462425b409c94d';

/// Provides the [SubscriptionRepository] instance.
///
/// Copied from [subscriptionRepository].
@ProviderFor(subscriptionRepository)
final subscriptionRepositoryProvider =
    Provider<SubscriptionRepository>.internal(
      subscriptionRepository,
      name: r'subscriptionRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$subscriptionRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubscriptionRepositoryRef = ProviderRef<SubscriptionRepository>;
String _$isProHash() => r'a564164a5b645a3ee835cf546fc3a5877fa683ec';

/// Whether the current user has an active Pro subscription.
///
/// Copied from [isPro].
@ProviderFor(isPro)
final isProProvider = AutoDisposeProvider<bool>.internal(
  isPro,
  name: r'isProProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isProHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsProRef = AutoDisposeProviderRef<bool>;
String _$weeklyAnalysisCountHash() =>
    r'aa199177baa8b1d8ea630206dbc26da73272ca75';

/// Number of analyses the user has performed this week.
///
/// Copied from [weeklyAnalysisCount].
@ProviderFor(weeklyAnalysisCount)
final weeklyAnalysisCountProvider = AutoDisposeFutureProvider<int>.internal(
  weeklyAnalysisCount,
  name: r'weeklyAnalysisCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weeklyAnalysisCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeeklyAnalysisCountRef = AutoDisposeFutureProviderRef<int>;
String _$canAnalyzeHash() => r'8f84810a0665952b134b6052db1f4cdf098860d7';

/// Whether the user can perform a new analysis.
///
/// Copied from [canAnalyze].
@ProviderFor(canAnalyze)
final canAnalyzeProvider = AutoDisposeFutureProvider<bool>.internal(
  canAnalyze,
  name: r'canAnalyzeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$canAnalyzeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CanAnalyzeRef = AutoDisposeFutureProviderRef<bool>;
String _$subscriptionNotifierHash() =>
    r'5a95ba41d47201cebb02d824afeb8024cdb09bf3';

/// Manages subscription state across the app.
///
/// Copied from [SubscriptionNotifier].
@ProviderFor(SubscriptionNotifier)
final subscriptionNotifierProvider =
    AsyncNotifierProvider<SubscriptionNotifier, SubscriptionEntity>.internal(
      SubscriptionNotifier.new,
      name: r'subscriptionNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$subscriptionNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SubscriptionNotifier = AsyncNotifier<SubscriptionEntity>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
