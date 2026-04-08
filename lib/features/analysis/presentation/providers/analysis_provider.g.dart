// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$analysisRepositoryHash() =>
    r'9d63ea3645e77de55d3189249fedbb665b4ee730';

/// Provides the [AnalysisRepository] instance.
///
/// Copied from [analysisRepository].
@ProviderFor(analysisRepository)
final analysisRepositoryProvider = Provider<AnalysisRepository>.internal(
  analysisRepository,
  name: r'analysisRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$analysisRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AnalysisRepositoryRef = ProviderRef<AnalysisRepository>;
String _$analysisNotifierHash() => r'1f52838584d897b45214d57e409e71f4a24ec81f';

/// Manages the full analysis pipeline: upload → analyze → result.
///
/// Copied from [AnalysisNotifier].
@ProviderFor(AnalysisNotifier)
final analysisNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      AnalysisNotifier,
      AnalysisEntity?
    >.internal(
      AnalysisNotifier.new,
      name: r'analysisNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$analysisNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AnalysisNotifier = AutoDisposeAsyncNotifier<AnalysisEntity?>;
String _$analysisHistoryHash() => r'66d736de007bbba0dcd03ba7c6a2ad933c654a94';

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

abstract class _$AnalysisHistory
    extends BuildlessAutoDisposeAsyncNotifier<List<AnalysisEntity>> {
  late final String userId;

  FutureOr<List<AnalysisEntity>> build(String userId);
}

/// Provides analysis history for the current user.
///
/// Copied from [AnalysisHistory].
@ProviderFor(AnalysisHistory)
const analysisHistoryProvider = AnalysisHistoryFamily();

/// Provides analysis history for the current user.
///
/// Copied from [AnalysisHistory].
class AnalysisHistoryFamily extends Family<AsyncValue<List<AnalysisEntity>>> {
  /// Provides analysis history for the current user.
  ///
  /// Copied from [AnalysisHistory].
  const AnalysisHistoryFamily();

  /// Provides analysis history for the current user.
  ///
  /// Copied from [AnalysisHistory].
  AnalysisHistoryProvider call(String userId) {
    return AnalysisHistoryProvider(userId);
  }

  @override
  AnalysisHistoryProvider getProviderOverride(
    covariant AnalysisHistoryProvider provider,
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
  String? get name => r'analysisHistoryProvider';
}

/// Provides analysis history for the current user.
///
/// Copied from [AnalysisHistory].
class AnalysisHistoryProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          AnalysisHistory,
          List<AnalysisEntity>
        > {
  /// Provides analysis history for the current user.
  ///
  /// Copied from [AnalysisHistory].
  AnalysisHistoryProvider(String userId)
    : this._internal(
        () => AnalysisHistory()..userId = userId,
        from: analysisHistoryProvider,
        name: r'analysisHistoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$analysisHistoryHash,
        dependencies: AnalysisHistoryFamily._dependencies,
        allTransitiveDependencies:
            AnalysisHistoryFamily._allTransitiveDependencies,
        userId: userId,
      );

  AnalysisHistoryProvider._internal(
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
  FutureOr<List<AnalysisEntity>> runNotifierBuild(
    covariant AnalysisHistory notifier,
  ) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(AnalysisHistory Function() create) {
    return ProviderOverride(
      origin: this,
      override: AnalysisHistoryProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<AnalysisHistory, List<AnalysisEntity>>
  createElement() {
    return _AnalysisHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AnalysisHistoryProvider && other.userId == userId;
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
mixin AnalysisHistoryRef
    on AutoDisposeAsyncNotifierProviderRef<List<AnalysisEntity>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _AnalysisHistoryProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          AnalysisHistory,
          List<AnalysisEntity>
        >
    with AnalysisHistoryRef {
  _AnalysisHistoryProviderElement(super.provider);

  @override
  String get userId => (origin as AnalysisHistoryProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
