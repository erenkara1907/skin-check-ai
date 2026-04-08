// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$latestAnalysisHash() => r'8f5cd695f8612f6a47aa02f2ef49b982157659b2';

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

/// Provides the latest analysis for the current user.
///
/// Copied from [latestAnalysis].
@ProviderFor(latestAnalysis)
const latestAnalysisProvider = LatestAnalysisFamily();

/// Provides the latest analysis for the current user.
///
/// Copied from [latestAnalysis].
class LatestAnalysisFamily extends Family<AsyncValue<AnalysisEntity?>> {
  /// Provides the latest analysis for the current user.
  ///
  /// Copied from [latestAnalysis].
  const LatestAnalysisFamily();

  /// Provides the latest analysis for the current user.
  ///
  /// Copied from [latestAnalysis].
  LatestAnalysisProvider call(String userId) {
    return LatestAnalysisProvider(userId);
  }

  @override
  LatestAnalysisProvider getProviderOverride(
    covariant LatestAnalysisProvider provider,
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
  String? get name => r'latestAnalysisProvider';
}

/// Provides the latest analysis for the current user.
///
/// Copied from [latestAnalysis].
class LatestAnalysisProvider
    extends AutoDisposeFutureProvider<AnalysisEntity?> {
  /// Provides the latest analysis for the current user.
  ///
  /// Copied from [latestAnalysis].
  LatestAnalysisProvider(String userId)
    : this._internal(
        (ref) => latestAnalysis(ref as LatestAnalysisRef, userId),
        from: latestAnalysisProvider,
        name: r'latestAnalysisProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$latestAnalysisHash,
        dependencies: LatestAnalysisFamily._dependencies,
        allTransitiveDependencies:
            LatestAnalysisFamily._allTransitiveDependencies,
        userId: userId,
      );

  LatestAnalysisProvider._internal(
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
  Override overrideWith(
    FutureOr<AnalysisEntity?> Function(LatestAnalysisRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LatestAnalysisProvider._internal(
        (ref) => create(ref as LatestAnalysisRef),
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
  AutoDisposeFutureProviderElement<AnalysisEntity?> createElement() {
    return _LatestAnalysisProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LatestAnalysisProvider && other.userId == userId;
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
mixin LatestAnalysisRef on AutoDisposeFutureProviderRef<AnalysisEntity?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _LatestAnalysisProviderElement
    extends AutoDisposeFutureProviderElement<AnalysisEntity?>
    with LatestAnalysisRef {
  _LatestAnalysisProviderElement(super.provider);

  @override
  String get userId => (origin as LatestAnalysisProvider).userId;
}

String _$homeRoutinesHash() => r'c8ef760dbb2c9bc8d8cc08e062c7ab7ba599667f';

/// Provides today's active routines for the home dashboard.
///
/// Copied from [homeRoutines].
@ProviderFor(homeRoutines)
const homeRoutinesProvider = HomeRoutinesFamily();

/// Provides today's active routines for the home dashboard.
///
/// Copied from [homeRoutines].
class HomeRoutinesFamily extends Family<AsyncValue<List<RoutineEntity>>> {
  /// Provides today's active routines for the home dashboard.
  ///
  /// Copied from [homeRoutines].
  const HomeRoutinesFamily();

  /// Provides today's active routines for the home dashboard.
  ///
  /// Copied from [homeRoutines].
  HomeRoutinesProvider call(String userId) {
    return HomeRoutinesProvider(userId);
  }

  @override
  HomeRoutinesProvider getProviderOverride(
    covariant HomeRoutinesProvider provider,
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
  String? get name => r'homeRoutinesProvider';
}

/// Provides today's active routines for the home dashboard.
///
/// Copied from [homeRoutines].
class HomeRoutinesProvider
    extends AutoDisposeFutureProvider<List<RoutineEntity>> {
  /// Provides today's active routines for the home dashboard.
  ///
  /// Copied from [homeRoutines].
  HomeRoutinesProvider(String userId)
    : this._internal(
        (ref) => homeRoutines(ref as HomeRoutinesRef, userId),
        from: homeRoutinesProvider,
        name: r'homeRoutinesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$homeRoutinesHash,
        dependencies: HomeRoutinesFamily._dependencies,
        allTransitiveDependencies:
            HomeRoutinesFamily._allTransitiveDependencies,
        userId: userId,
      );

  HomeRoutinesProvider._internal(
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
  Override overrideWith(
    FutureOr<List<RoutineEntity>> Function(HomeRoutinesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HomeRoutinesProvider._internal(
        (ref) => create(ref as HomeRoutinesRef),
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
  AutoDisposeFutureProviderElement<List<RoutineEntity>> createElement() {
    return _HomeRoutinesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HomeRoutinesProvider && other.userId == userId;
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
mixin HomeRoutinesRef on AutoDisposeFutureProviderRef<List<RoutineEntity>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _HomeRoutinesProviderElement
    extends AutoDisposeFutureProviderElement<List<RoutineEntity>>
    with HomeRoutinesRef {
  _HomeRoutinesProviderElement(super.provider);

  @override
  String get userId => (origin as HomeRoutinesProvider).userId;
}

String _$homeTrendHash() => r'e9f23ebaa2f52e2d0a0569b56db853bc4a34c5c2';

/// Provides the last 4 weeks of score trend for the mini chart.
///
/// Copied from [homeTrend].
@ProviderFor(homeTrend)
const homeTrendProvider = HomeTrendFamily();

/// Provides the last 4 weeks of score trend for the mini chart.
///
/// Copied from [homeTrend].
class HomeTrendFamily extends Family<AsyncValue<List<ScoreTrendEntity>>> {
  /// Provides the last 4 weeks of score trend for the mini chart.
  ///
  /// Copied from [homeTrend].
  const HomeTrendFamily();

  /// Provides the last 4 weeks of score trend for the mini chart.
  ///
  /// Copied from [homeTrend].
  HomeTrendProvider call(String userId) {
    return HomeTrendProvider(userId);
  }

  @override
  HomeTrendProvider getProviderOverride(covariant HomeTrendProvider provider) {
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
  String? get name => r'homeTrendProvider';
}

/// Provides the last 4 weeks of score trend for the mini chart.
///
/// Copied from [homeTrend].
class HomeTrendProvider
    extends AutoDisposeFutureProvider<List<ScoreTrendEntity>> {
  /// Provides the last 4 weeks of score trend for the mini chart.
  ///
  /// Copied from [homeTrend].
  HomeTrendProvider(String userId)
    : this._internal(
        (ref) => homeTrend(ref as HomeTrendRef, userId),
        from: homeTrendProvider,
        name: r'homeTrendProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$homeTrendHash,
        dependencies: HomeTrendFamily._dependencies,
        allTransitiveDependencies: HomeTrendFamily._allTransitiveDependencies,
        userId: userId,
      );

  HomeTrendProvider._internal(
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
  Override overrideWith(
    FutureOr<List<ScoreTrendEntity>> Function(HomeTrendRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HomeTrendProvider._internal(
        (ref) => create(ref as HomeTrendRef),
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
  AutoDisposeFutureProviderElement<List<ScoreTrendEntity>> createElement() {
    return _HomeTrendProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HomeTrendProvider && other.userId == userId;
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
mixin HomeTrendRef on AutoDisposeFutureProviderRef<List<ScoreTrendEntity>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _HomeTrendProviderElement
    extends AutoDisposeFutureProviderElement<List<ScoreTrendEntity>>
    with HomeTrendRef {
  _HomeTrendProviderElement(super.provider);

  @override
  String get userId => (origin as HomeTrendProvider).userId;
}

String _$hasAnalysisHash() => r'2f72559bff14fa596b632da032c99b0d309a54d3';

/// Whether the current user has any analysis history.
///
/// Copied from [hasAnalysis].
@ProviderFor(hasAnalysis)
const hasAnalysisProvider = HasAnalysisFamily();

/// Whether the current user has any analysis history.
///
/// Copied from [hasAnalysis].
class HasAnalysisFamily extends Family<AsyncValue<bool>> {
  /// Whether the current user has any analysis history.
  ///
  /// Copied from [hasAnalysis].
  const HasAnalysisFamily();

  /// Whether the current user has any analysis history.
  ///
  /// Copied from [hasAnalysis].
  HasAnalysisProvider call(String userId) {
    return HasAnalysisProvider(userId);
  }

  @override
  HasAnalysisProvider getProviderOverride(
    covariant HasAnalysisProvider provider,
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
  String? get name => r'hasAnalysisProvider';
}

/// Whether the current user has any analysis history.
///
/// Copied from [hasAnalysis].
class HasAnalysisProvider extends AutoDisposeFutureProvider<bool> {
  /// Whether the current user has any analysis history.
  ///
  /// Copied from [hasAnalysis].
  HasAnalysisProvider(String userId)
    : this._internal(
        (ref) => hasAnalysis(ref as HasAnalysisRef, userId),
        from: hasAnalysisProvider,
        name: r'hasAnalysisProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$hasAnalysisHash,
        dependencies: HasAnalysisFamily._dependencies,
        allTransitiveDependencies: HasAnalysisFamily._allTransitiveDependencies,
        userId: userId,
      );

  HasAnalysisProvider._internal(
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
  Override overrideWith(
    FutureOr<bool> Function(HasAnalysisRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HasAnalysisProvider._internal(
        (ref) => create(ref as HasAnalysisRef),
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
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _HasAnalysisProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HasAnalysisProvider && other.userId == userId;
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
mixin HasAnalysisRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _HasAnalysisProviderElement extends AutoDisposeFutureProviderElement<bool>
    with HasAnalysisRef {
  _HasAnalysisProviderElement(super.provider);

  @override
  String get userId => (origin as HasAnalysisProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
