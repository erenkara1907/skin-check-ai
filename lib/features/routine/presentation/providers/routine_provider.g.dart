// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routineRepositoryHash() => r'b1dad97689d21b007acb086eebf131b0e2af4c12';

/// Provides the [RoutineRepository] singleton.
///
/// Copied from [routineRepository].
@ProviderFor(routineRepository)
final routineRepositoryProvider = Provider<RoutineRepository>.internal(
  routineRepository,
  name: r'routineRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routineRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RoutineRepositoryRef = ProviderRef<RoutineRepository>;
String _$routineNotifierHash() => r'eda77a5e215899d7be1600dd978e596915af33ce';

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

abstract class _$RoutineNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<RoutineEntity>> {
  late final String userId;

  FutureOr<List<RoutineEntity>> build(String userId);
}

/// Manages the user's active routines (morning + evening).
///
/// Copied from [RoutineNotifier].
@ProviderFor(RoutineNotifier)
const routineNotifierProvider = RoutineNotifierFamily();

/// Manages the user's active routines (morning + evening).
///
/// Copied from [RoutineNotifier].
class RoutineNotifierFamily extends Family<AsyncValue<List<RoutineEntity>>> {
  /// Manages the user's active routines (morning + evening).
  ///
  /// Copied from [RoutineNotifier].
  const RoutineNotifierFamily();

  /// Manages the user's active routines (morning + evening).
  ///
  /// Copied from [RoutineNotifier].
  RoutineNotifierProvider call(String userId) {
    return RoutineNotifierProvider(userId);
  }

  @override
  RoutineNotifierProvider getProviderOverride(
    covariant RoutineNotifierProvider provider,
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
  String? get name => r'routineNotifierProvider';
}

/// Manages the user's active routines (morning + evening).
///
/// Copied from [RoutineNotifier].
class RoutineNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          RoutineNotifier,
          List<RoutineEntity>
        > {
  /// Manages the user's active routines (morning + evening).
  ///
  /// Copied from [RoutineNotifier].
  RoutineNotifierProvider(String userId)
    : this._internal(
        () => RoutineNotifier()..userId = userId,
        from: routineNotifierProvider,
        name: r'routineNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$routineNotifierHash,
        dependencies: RoutineNotifierFamily._dependencies,
        allTransitiveDependencies:
            RoutineNotifierFamily._allTransitiveDependencies,
        userId: userId,
      );

  RoutineNotifierProvider._internal(
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
  FutureOr<List<RoutineEntity>> runNotifierBuild(
    covariant RoutineNotifier notifier,
  ) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(RoutineNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: RoutineNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<RoutineNotifier, List<RoutineEntity>>
  createElement() {
    return _RoutineNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RoutineNotifierProvider && other.userId == userId;
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
mixin RoutineNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<RoutineEntity>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _RoutineNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          RoutineNotifier,
          List<RoutineEntity>
        >
    with RoutineNotifierRef {
  _RoutineNotifierProviderElement(super.provider);

  @override
  String get userId => (origin as RoutineNotifierProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
