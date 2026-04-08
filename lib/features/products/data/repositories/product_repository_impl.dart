import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_datasource.dart';

/// Supabase-backed implementation of [ProductRepository].
class ProductRepositoryImpl implements ProductRepository {
  /// Creates a [ProductRepositoryImpl] with the given [dataSource].
  ProductRepositoryImpl(this._dataSource);

  final ProductDataSource _dataSource;

  @override
  Future<List<ProductEntity>> getAllProducts() => _dataSource.fetchAll();

  @override
  Future<List<ProductEntity>> getProductsByConcerns(
    List<String> concerns,
  ) =>
      _dataSource.fetchByConcerns(concerns);

  @override
  Future<List<ProductEntity>> getProductsByCategory(String category) =>
      _dataSource.fetchByCategory(category);
}
