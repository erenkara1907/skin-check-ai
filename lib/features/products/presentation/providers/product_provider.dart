import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/supabase_service.dart';
import '../../data/datasources/product_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

part 'product_provider.g.dart';

/// Provides the [ProductRepository] instance.
@Riverpod(keepAlive: true)
ProductRepository productRepository(Ref ref) {
  return ProductRepositoryImpl(
    ProductDataSource(SupabaseService.client),
  );
}

/// Fetches all products grouped by category.
@riverpod
FutureOr<Map<ProductCategory, List<ProductEntity>>> allProducts(
  Ref ref,
) async {
  final repo = ref.read(productRepositoryProvider);
  final products = await repo.getAllProducts();
  return _groupByCategory(products);
}

/// Fetches products matching the given [concerns].
@riverpod
FutureOr<Map<ProductCategory, List<ProductEntity>>> recommendedProducts(
  Ref ref,
  List<String> concerns,
) async {
  if (concerns.isEmpty) return {};
  final repo = ref.read(productRepositoryProvider);
  final products = await repo.getProductsByConcerns(concerns);
  return _groupByCategory(products);
}

/// Groups a flat product list by [ProductCategory].
Map<ProductCategory, List<ProductEntity>> _groupByCategory(
  List<ProductEntity> products,
) {
  final map = <ProductCategory, List<ProductEntity>>{};
  for (final product in products) {
    final category = ProductCategory.values.firstWhere(
      (c) => c.name == product.category,
      orElse: () => ProductCategory.serum,
    );
    map.putIfAbsent(category, () => []).add(product);
  }
  return map;
}
