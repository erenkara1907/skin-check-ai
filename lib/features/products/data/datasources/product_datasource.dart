import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/logger.dart';
import '../../domain/entities/product_entity.dart';

/// Remote data source for products via Supabase.
class ProductDataSource {
  /// Creates a [ProductDataSource] with the given Supabase [client].
  ProductDataSource(this._client);

  final SupabaseClient _client;

  /// Fetches all products ordered by rating descending.
  Future<List<ProductEntity>> fetchAll() async {
    log.d('Fetching all products');
    final response = await _client
        .from('products')
        .select()
        .order('rating', ascending: false);

    return (response as List)
        .map((json) => ProductEntity.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Fetches products whose `suitable_concerns` overlaps [concerns].
  Future<List<ProductEntity>> fetchByConcerns(List<String> concerns) async {
    log.d('Fetching products for concerns: $concerns');
    final response = await _client
        .from('products')
        .select()
        .overlaps('suitable_concerns', concerns)
        .order('rating', ascending: false);

    return (response as List)
        .map((json) => ProductEntity.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Fetches products filtered by [category].
  Future<List<ProductEntity>> fetchByCategory(String category) async {
    log.d('Fetching products for category: $category');
    final response = await _client
        .from('products')
        .select()
        .eq('category', category)
        .order('rating', ascending: false);

    return (response as List)
        .map((json) => ProductEntity.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
