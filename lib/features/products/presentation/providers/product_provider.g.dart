// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productRepositoryHash() => r'8d740ed78483f293c890279b1e31ab6fecb1ac53';

/// Provides the [ProductRepository] instance.
///
/// Copied from [productRepository].
@ProviderFor(productRepository)
final productRepositoryProvider = Provider<ProductRepository>.internal(
  productRepository,
  name: r'productRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductRepositoryRef = ProviderRef<ProductRepository>;
String _$allProductsHash() => r'5f3b31e382264cacfe12fe2ef7c0556edff3a3ff';

/// Fetches all products grouped by category.
///
/// Copied from [allProducts].
@ProviderFor(allProducts)
final allProductsProvider =
    AutoDisposeFutureProvider<
      Map<ProductCategory, List<ProductEntity>>
    >.internal(
      allProducts,
      name: r'allProductsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allProductsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllProductsRef =
    AutoDisposeFutureProviderRef<Map<ProductCategory, List<ProductEntity>>>;
String _$recommendedProductsHash() =>
    r'375a0e7e8256742248d95aba27df2ab64eb44d05';

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

/// Fetches products matching the given [concerns].
///
/// Copied from [recommendedProducts].
@ProviderFor(recommendedProducts)
const recommendedProductsProvider = RecommendedProductsFamily();

/// Fetches products matching the given [concerns].
///
/// Copied from [recommendedProducts].
class RecommendedProductsFamily
    extends Family<AsyncValue<Map<ProductCategory, List<ProductEntity>>>> {
  /// Fetches products matching the given [concerns].
  ///
  /// Copied from [recommendedProducts].
  const RecommendedProductsFamily();

  /// Fetches products matching the given [concerns].
  ///
  /// Copied from [recommendedProducts].
  RecommendedProductsProvider call(List<String> concerns) {
    return RecommendedProductsProvider(concerns);
  }

  @override
  RecommendedProductsProvider getProviderOverride(
    covariant RecommendedProductsProvider provider,
  ) {
    return call(provider.concerns);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recommendedProductsProvider';
}

/// Fetches products matching the given [concerns].
///
/// Copied from [recommendedProducts].
class RecommendedProductsProvider
    extends
        AutoDisposeFutureProvider<Map<ProductCategory, List<ProductEntity>>> {
  /// Fetches products matching the given [concerns].
  ///
  /// Copied from [recommendedProducts].
  RecommendedProductsProvider(List<String> concerns)
    : this._internal(
        (ref) => recommendedProducts(ref as RecommendedProductsRef, concerns),
        from: recommendedProductsProvider,
        name: r'recommendedProductsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$recommendedProductsHash,
        dependencies: RecommendedProductsFamily._dependencies,
        allTransitiveDependencies:
            RecommendedProductsFamily._allTransitiveDependencies,
        concerns: concerns,
      );

  RecommendedProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.concerns,
  }) : super.internal();

  final List<String> concerns;

  @override
  Override overrideWith(
    FutureOr<Map<ProductCategory, List<ProductEntity>>> Function(
      RecommendedProductsRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecommendedProductsProvider._internal(
        (ref) => create(ref as RecommendedProductsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        concerns: concerns,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<ProductCategory, List<ProductEntity>>>
  createElement() {
    return _RecommendedProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecommendedProductsProvider && other.concerns == concerns;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, concerns.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecommendedProductsRef
    on AutoDisposeFutureProviderRef<Map<ProductCategory, List<ProductEntity>>> {
  /// The parameter `concerns` of this provider.
  List<String> get concerns;
}

class _RecommendedProductsProviderElement
    extends
        AutoDisposeFutureProviderElement<
          Map<ProductCategory, List<ProductEntity>>
        >
    with RecommendedProductsRef {
  _RecommendedProductsProviderElement(super.provider);

  @override
  List<String> get concerns => (origin as RecommendedProductsProvider).concerns;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
