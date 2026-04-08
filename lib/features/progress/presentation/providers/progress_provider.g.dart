// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$progressRepositoryHash() =>
    r'3c5c791b19e8411f6adcf1e41c999e617b0efea3';

/// Provides the [ProgressRepository] instance.
///
/// Copied from [progressRepository].
@ProviderFor(progressRepository)
final progressRepositoryProvider = Provider<ProgressRepository>.internal(
  progressRepository,
  name: r'progressRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$progressRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProgressRepositoryRef = ProviderRef<ProgressRepository>;
String _$progressSummaryNotifierHash() =>
    r'743038230f334f902b01ef0f68df5b97f598a928';

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

abstract class _$ProgressSummaryNotifier
    extends BuildlessAutoDisposeAsyncNotifier<ProgressSummaryEntity> {
  late final String userId;

  FutureOr<ProgressSummaryEntity> build(String userId);
}

/// Loads the progress dashboard summary.
///
/// Copied from [ProgressSummaryNotifier].
@ProviderFor(ProgressSummaryNotifier)
const progressSummaryNotifierProvider = ProgressSummaryNotifierFamily();

/// Loads the progress dashboard summary.
///
/// Copied from [ProgressSummaryNotifier].
class ProgressSummaryNotifierFamily
    extends Family<AsyncValue<ProgressSummaryEntity>> {
  /// Loads the progress dashboard summary.
  ///
  /// Copied from [ProgressSummaryNotifier].
  const ProgressSummaryNotifierFamily();

  /// Loads the progress dashboard summary.
  ///
  /// Copied from [ProgressSummaryNotifier].
  ProgressSummaryNotifierProvider call(String userId) {
    return ProgressSummaryNotifierProvider(userId);
  }

  @override
  ProgressSummaryNotifierProvider getProviderOverride(
    covariant ProgressSummaryNotifierProvider provider,
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
  String? get name => r'progressSummaryNotifierProvider';
}

/// Loads the progress dashboard summary.
///
/// Copied from [ProgressSummaryNotifier].
class ProgressSummaryNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ProgressSummaryNotifier,
          ProgressSummaryEntity
        > {
  /// Loads the progress dashboard summary.
  ///
  /// Copied from [ProgressSummaryNotifier].
  ProgressSummaryNotifierProvider(String userId)
    : this._internal(
        () => ProgressSummaryNotifier()..userId = userId,
        from: progressSummaryNotifierProvider,
        name: r'progressSummaryNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$progressSummaryNotifierHash,
        dependencies: ProgressSummaryNotifierFamily._dependencies,
        allTransitiveDependencies:
            ProgressSummaryNotifierFamily._allTransitiveDependencies,
        userId: userId,
      );

  ProgressSummaryNotifierProvider._internal(
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
  FutureOr<ProgressSummaryEntity> runNotifierBuild(
    covariant ProgressSummaryNotifier notifier,
  ) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(ProgressSummaryNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProgressSummaryNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<
    ProgressSummaryNotifier,
    ProgressSummaryEntity
  >
  createElement() {
    return _ProgressSummaryNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProgressSummaryNotifierProvider && other.userId == userId;
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
mixin ProgressSummaryNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<ProgressSummaryEntity> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _ProgressSummaryNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ProgressSummaryNotifier,
          ProgressSummaryEntity
        >
    with ProgressSummaryNotifierRef {
  _ProgressSummaryNotifierProviderElement(super.provider);

  @override
  String get userId => (origin as ProgressSummaryNotifierProvider).userId;
}

String _$scoreTrendNotifierHash() =>
    r'0f44a7f4018c12a084748c7fdc558ae3ea971c59';

abstract class _$ScoreTrendNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<ScoreTrendEntity>> {
  late final String userId;

  FutureOr<List<ScoreTrendEntity>> build(String userId);
}

/// Loads score trend data for the chart.
///
/// Copied from [ScoreTrendNotifier].
@ProviderFor(ScoreTrendNotifier)
const scoreTrendNotifierProvider = ScoreTrendNotifierFamily();

/// Loads score trend data for the chart.
///
/// Copied from [ScoreTrendNotifier].
class ScoreTrendNotifierFamily
    extends Family<AsyncValue<List<ScoreTrendEntity>>> {
  /// Loads score trend data for the chart.
  ///
  /// Copied from [ScoreTrendNotifier].
  const ScoreTrendNotifierFamily();

  /// Loads score trend data for the chart.
  ///
  /// Copied from [ScoreTrendNotifier].
  ScoreTrendNotifierProvider call(String userId) {
    return ScoreTrendNotifierProvider(userId);
  }

  @override
  ScoreTrendNotifierProvider getProviderOverride(
    covariant ScoreTrendNotifierProvider provider,
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
  String? get name => r'scoreTrendNotifierProvider';
}

/// Loads score trend data for the chart.
///
/// Copied from [ScoreTrendNotifier].
class ScoreTrendNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ScoreTrendNotifier,
          List<ScoreTrendEntity>
        > {
  /// Loads score trend data for the chart.
  ///
  /// Copied from [ScoreTrendNotifier].
  ScoreTrendNotifierProvider(String userId)
    : this._internal(
        () => ScoreTrendNotifier()..userId = userId,
        from: scoreTrendNotifierProvider,
        name: r'scoreTrendNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$scoreTrendNotifierHash,
        dependencies: ScoreTrendNotifierFamily._dependencies,
        allTransitiveDependencies:
            ScoreTrendNotifierFamily._allTransitiveDependencies,
        userId: userId,
      );

  ScoreTrendNotifierProvider._internal(
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
  FutureOr<List<ScoreTrendEntity>> runNotifierBuild(
    covariant ScoreTrendNotifier notifier,
  ) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(ScoreTrendNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ScoreTrendNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<
    ScoreTrendNotifier,
    List<ScoreTrendEntity>
  >
  createElement() {
    return _ScoreTrendNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScoreTrendNotifierProvider && other.userId == userId;
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
mixin ScoreTrendNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<ScoreTrendEntity>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _ScoreTrendNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ScoreTrendNotifier,
          List<ScoreTrendEntity>
        >
    with ScoreTrendNotifierRef {
  _ScoreTrendNotifierProviderElement(super.provider);

  @override
  String get userId => (origin as ScoreTrendNotifierProvider).userId;
}

String _$zoneProgressNotifierHash() =>
    r'746bbce46f3ebc8a2657a1dd57d406edcd2f691b';

abstract class _$ZoneProgressNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<ZoneProgressEntity>> {
  late final String userId;

  FutureOr<List<ZoneProgressEntity>> build(String userId);
}

/// Loads zone-by-zone progress data.
///
/// Copied from [ZoneProgressNotifier].
@ProviderFor(ZoneProgressNotifier)
const zoneProgressNotifierProvider = ZoneProgressNotifierFamily();

/// Loads zone-by-zone progress data.
///
/// Copied from [ZoneProgressNotifier].
class ZoneProgressNotifierFamily
    extends Family<AsyncValue<List<ZoneProgressEntity>>> {
  /// Loads zone-by-zone progress data.
  ///
  /// Copied from [ZoneProgressNotifier].
  const ZoneProgressNotifierFamily();

  /// Loads zone-by-zone progress data.
  ///
  /// Copied from [ZoneProgressNotifier].
  ZoneProgressNotifierProvider call(String userId) {
    return ZoneProgressNotifierProvider(userId);
  }

  @override
  ZoneProgressNotifierProvider getProviderOverride(
    covariant ZoneProgressNotifierProvider provider,
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
  String? get name => r'zoneProgressNotifierProvider';
}

/// Loads zone-by-zone progress data.
///
/// Copied from [ZoneProgressNotifier].
class ZoneProgressNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ZoneProgressNotifier,
          List<ZoneProgressEntity>
        > {
  /// Loads zone-by-zone progress data.
  ///
  /// Copied from [ZoneProgressNotifier].
  ZoneProgressNotifierProvider(String userId)
    : this._internal(
        () => ZoneProgressNotifier()..userId = userId,
        from: zoneProgressNotifierProvider,
        name: r'zoneProgressNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$zoneProgressNotifierHash,
        dependencies: ZoneProgressNotifierFamily._dependencies,
        allTransitiveDependencies:
            ZoneProgressNotifierFamily._allTransitiveDependencies,
        userId: userId,
      );

  ZoneProgressNotifierProvider._internal(
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
  FutureOr<List<ZoneProgressEntity>> runNotifierBuild(
    covariant ZoneProgressNotifier notifier,
  ) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(ZoneProgressNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ZoneProgressNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<
    ZoneProgressNotifier,
    List<ZoneProgressEntity>
  >
  createElement() {
    return _ZoneProgressNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ZoneProgressNotifierProvider && other.userId == userId;
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
mixin ZoneProgressNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<ZoneProgressEntity>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _ZoneProgressNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ZoneProgressNotifier,
          List<ZoneProgressEntity>
        >
    with ZoneProgressNotifierRef {
  _ZoneProgressNotifierProviderElement(super.provider);

  @override
  String get userId => (origin as ZoneProgressNotifierProvider).userId;
}

String _$photoComparisonNotifierHash() =>
    r'3b471959b6d656e06783fe9cc4a0de7bc5eee39d';

abstract class _$PhotoComparisonNotifier
    extends BuildlessAutoDisposeAsyncNotifier<PhotoComparisonEntity> {
  late final String userId;

  FutureOr<PhotoComparisonEntity> build(String userId);
}

/// Loads photo comparison data.
///
/// Copied from [PhotoComparisonNotifier].
@ProviderFor(PhotoComparisonNotifier)
const photoComparisonNotifierProvider = PhotoComparisonNotifierFamily();

/// Loads photo comparison data.
///
/// Copied from [PhotoComparisonNotifier].
class PhotoComparisonNotifierFamily
    extends Family<AsyncValue<PhotoComparisonEntity>> {
  /// Loads photo comparison data.
  ///
  /// Copied from [PhotoComparisonNotifier].
  const PhotoComparisonNotifierFamily();

  /// Loads photo comparison data.
  ///
  /// Copied from [PhotoComparisonNotifier].
  PhotoComparisonNotifierProvider call(String userId) {
    return PhotoComparisonNotifierProvider(userId);
  }

  @override
  PhotoComparisonNotifierProvider getProviderOverride(
    covariant PhotoComparisonNotifierProvider provider,
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
  String? get name => r'photoComparisonNotifierProvider';
}

/// Loads photo comparison data.
///
/// Copied from [PhotoComparisonNotifier].
class PhotoComparisonNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          PhotoComparisonNotifier,
          PhotoComparisonEntity
        > {
  /// Loads photo comparison data.
  ///
  /// Copied from [PhotoComparisonNotifier].
  PhotoComparisonNotifierProvider(String userId)
    : this._internal(
        () => PhotoComparisonNotifier()..userId = userId,
        from: photoComparisonNotifierProvider,
        name: r'photoComparisonNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$photoComparisonNotifierHash,
        dependencies: PhotoComparisonNotifierFamily._dependencies,
        allTransitiveDependencies:
            PhotoComparisonNotifierFamily._allTransitiveDependencies,
        userId: userId,
      );

  PhotoComparisonNotifierProvider._internal(
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
  FutureOr<PhotoComparisonEntity> runNotifierBuild(
    covariant PhotoComparisonNotifier notifier,
  ) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(PhotoComparisonNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PhotoComparisonNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<
    PhotoComparisonNotifier,
    PhotoComparisonEntity
  >
  createElement() {
    return _PhotoComparisonNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PhotoComparisonNotifierProvider && other.userId == userId;
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
mixin PhotoComparisonNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<PhotoComparisonEntity> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _PhotoComparisonNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          PhotoComparisonNotifier,
          PhotoComparisonEntity
        >
    with PhotoComparisonNotifierRef {
  _PhotoComparisonNotifierProviderElement(super.provider);

  @override
  String get userId => (origin as PhotoComparisonNotifierProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
