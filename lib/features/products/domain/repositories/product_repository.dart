import '../entities/product_entity.dart';

/// Contract for accessing product data.
abstract class ProductRepository {
  /// Fetches all products.
  Future<List<ProductEntity>> getAllProducts();

  /// Fetches products matching any of the given [concerns].
  Future<List<ProductEntity>> getProductsByConcerns(List<String> concerns);

  /// Fetches products in a specific [category].
  Future<List<ProductEntity>> getProductsByCategory(String category);
}
