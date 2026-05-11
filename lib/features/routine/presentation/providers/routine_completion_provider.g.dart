// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_completion_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routineCompletionNotifierHash() =>
    r'a8eb40bddab0c432af4c3e197416d1305cf02c41';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$RoutineCompletionNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Map<int, bool>> {
  late final String routineId;

  FutureOr<Map<int, bool>> build(String routineId);
}

/// Tracks step completion state for a routine today.
///
/// Copied from [RoutineCompletionNotifier].
@ProviderFor(RoutineCompletionNotifier)
const routineCompletionNotifierProvider = RoutineCompletionNotifierFamily();

/// Tracks step completion state for a routine today.
///
/// Copied from [RoutineCompletionNotifier].
class RoutineCompletionNotifierFamily
    extends Family<AsyncValue<Map<int, bool>>> {
  /// Tracks step completion state for a routine today.
  ///
  /// Copied from [RoutineCompletionNotifier].
  const RoutineCompletionNotifierFamily();

  /// Tracks step completion state for a routine today.
  ///
  /// Copied from [RoutineCompletionNotifier].
  RoutineCompletionNotifierProvider call(String routineId) {
    return RoutineCompletionNotifierProvider(routineId);
  }

  @override
  RoutineCompletionNotifierProvider getProviderOverride(
    covariant RoutineCompletionNotifierProvider provider,
  ) {
    return call(provider.routineId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'routineCompletionNotifierProvider';
}

/// Tracks step completion state for a routine today.
///
/// Copied from [RoutineCompletionNotifier].
class RoutineCompletionNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          RoutineCompletionNotifier,
          Map<int, bool>
        > {
  /// Tracks step completion state for a routine today.
  ///
  /// Copied from [RoutineCompletionNotifier].
  RoutineCompletionNotifierProvider(String routineId)
    : this._internal(
        () => RoutineCompletionNotifier()..routineId = routineId,
        from: routineCompletionNotifierProvider,
        name: r'routineCompletionNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$routineCompletionNotifierHash,
        dependencies: RoutineCompletionNotifierFamily._dependencies,
        allTransitiveDependencies:
            RoutineCompletionNotifierFamily._allTransitiveDependencies,
        routineId: routineId,
      );

  RoutineCompletionNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.routineId,
  }) : super.internal();

  final String routineId;

  @override
  FutureOr<Map<int, bool>> runNotifierBuild(
    covariant RoutineCompletionNotifier notifier,
  ) {
    return notifier.build(routineId);
  }

  @override
  Override overrideWith(RoutineCompletionNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: RoutineCompletionNotifierProvider._internal(
        () => create()..routineId = routineId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        routineId: routineId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    RoutineCompletionNotifier,
    Map<int, bool>
  >
  createElement() {
    return _RoutineCompletionNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RoutineCompletionNotifierProvider &&
        other.routineId == routineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, routineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RoutineCompletionNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<Map<int, bool>> {
  /// The parameter `routineId` of this provider.
  String get routineId;
}

class _RoutineCompletionNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          RoutineCompletionNotifier,
          Map<int, bool>
        >
    with RoutineCompletionNotifierRef {
  _RoutineCompletionNotifierProviderElement(super.provider);

  @override
  String get routineId =>
      (origin as RoutineCompletionNotifierProvider).routineId;
}

String _$streakNotifierHash() => r'f1befb99b0284c7375639a698509051c8cc19bb1';

abstract class _$StreakNotifier
    extends BuildlessAutoDisposeAsyncNotifier<StreakEntity> {
  late final String userId;

  FutureOr<StreakEntity> build(String userId);
}

/// Provides the user's current streak.
///
/// Copied from [StreakNotifier].
@ProviderFor(StreakNotifier)
const streakNotifierProvider = StreakNotifierFamily();

/// Provides the user's current streak.
///
/// Copied from [StreakNotifier].
class StreakNotifierFamily extends Family<AsyncValue<StreakEntity>> {
  /// Provides the user's current streak.
  ///
  /// Copied from [StreakNotifier].
  const StreakNotifierFamily();

  /// Provides the user's current streak.
  ///
  /// Copied from [StreakNotifier].
  StreakNotifierProvider call(String userId) {
    return StreakNotifierProvider(userId);
  }

  @override
  StreakNotifierProvider getProviderOverride(
    covariant StreakNotifierProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'streakNotifierProvider';
}

/// Provides the user's current streak.
///
/// Copied from [StreakNotifier].
class StreakNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<StreakNotifier, StreakEntity> {
  /// Provides the user's current streak.
  ///
  /// Copied from [StreakNotifier].
  StreakNotifierProvider(String userId)
    : this._internal(
        () => StreakNotifier()..userId = userId,
        from: streakNotifierProvider,
        name: r'streakNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$streakNotifierHash,
        dependencies: StreakNotifierFamily._dependencies,
        allTransitiveDependencies:
            StreakNotifierFamily._allTransitiveDependencies,
        userId: userId,
      );

  StreakNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  FutureOr<StreakEntity> runNotifierBuild(covariant StreakNotifier notifier) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(StreakNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: StreakNotifierProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<StreakNotifier, StreakEntity>
  createElement() {
    return _StreakNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreakNotifierProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StreakNotifierRef on AutoDisposeAsyncNotifierProviderRef<StreakEntity> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _StreakNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<StreakNotifier, StreakEntity>
    with StreakNotifierRef {
  _StreakNotifierProviderElement(super.provider);

  @override
  String get userId => (origin as StreakNotifierProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
