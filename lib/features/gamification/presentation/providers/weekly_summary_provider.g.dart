// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_summary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weeklySummaryNotifierHash() =>
    r'806436f63efc8d7658ad505325f0787372c201bd';

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

abstract class _$WeeklySummaryNotifier
    extends BuildlessAutoDisposeAsyncNotifier<WeeklySummaryEntity> {
  late final String userId;

  FutureOr<WeeklySummaryEntity> build(String userId);
}

/// Provides the weekly routine completion summary.
///
/// Copied from [WeeklySummaryNotifier].
@ProviderFor(WeeklySummaryNotifier)
const weeklySummaryNotifierProvider = WeeklySummaryNotifierFamily();

/// Provides the weekly routine completion summary.
///
/// Copied from [WeeklySummaryNotifier].
class WeeklySummaryNotifierFamily
    extends Family<AsyncValue<WeeklySummaryEntity>> {
  /// Provides the weekly routine completion summary.
  ///
  /// Copied from [WeeklySummaryNotifier].
  const WeeklySummaryNotifierFamily();

  /// Provides the weekly routine completion summary.
  ///
  /// Copied from [WeeklySummaryNotifier].
  WeeklySummaryNotifierProvider call(String userId) {
    return WeeklySummaryNotifierProvider(userId);
  }

  @override
  WeeklySummaryNotifierProvider getProviderOverride(
    covariant WeeklySummaryNotifierProvider provider,
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
  String? get name => r'weeklySummaryNotifierProvider';
}

/// Provides the weekly routine completion summary.
///
/// Copied from [WeeklySummaryNotifier].
class WeeklySummaryNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          WeeklySummaryNotifier,
          WeeklySummaryEntity
        > {
  /// Provides the weekly routine completion summary.
  ///
  /// Copied from [WeeklySummaryNotifier].
  WeeklySummaryNotifierProvider(String userId)
    : this._internal(
        () => WeeklySummaryNotifier()..userId = userId,
        from: weeklySummaryNotifierProvider,
        name: r'weeklySummaryNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$weeklySummaryNotifierHash,
        dependencies: WeeklySummaryNotifierFamily._dependencies,
        allTransitiveDependencies:
            WeeklySummaryNotifierFamily._allTransitiveDependencies,
        userId: userId,
      );

  WeeklySummaryNotifierProvider._internal(
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
  FutureOr<WeeklySummaryEntity> runNotifierBuild(
    covariant WeeklySummaryNotifier notifier,
  ) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(WeeklySummaryNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: WeeklySummaryNotifierProvider._internal(
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
    WeeklySummaryNotifier,
    WeeklySummaryEntity
  >
  createElement() {
    return _WeeklySummaryNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WeeklySummaryNotifierProvider && other.userId == userId;
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
mixin WeeklySummaryNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<WeeklySummaryEntity> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _WeeklySummaryNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          WeeklySummaryNotifier,
          WeeklySummaryEntity
        >
    with WeeklySummaryNotifierRef {
  _WeeklySummaryNotifierProviderElement(super.provider);

  @override
  String get userId => (origin as WeeklySummaryNotifierProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
