import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skincheck_ai/features/products/data/datasources/product_datasource.dart';
import 'package:skincheck_ai/features/products/data/repositories/product_repository_impl.dart';
import 'package:skincheck_ai/features/products/domain/entities/product_entity.dart';

class MockProductDataSource extends Mock implements ProductDataSource {}

void main() {
  late MockProductDataSource mockDataSource;
  late ProductRepositoryImpl repository;

  final testProducts = [
    const ProductEntity(
      id: '1',
      name: 'Test Cleanser',
      brand: 'TestBrand',
      category: 'temizleyici',
      priceRange: '₺100-200',
      suitableConcerns: ['acne', 'oiliness'],
      rating: 4.5,
      description: 'A test product',
    ),
    const ProductEntity(
      id: '2',
      name: 'Test Serum',
      brand: 'TestBrand',
      category: 'serum',
      priceRange: '₺200-300',
      suitableConcerns: ['wrinkles', 'spots'],
      rating: 4.2,
      description: 'Another test product',
    ),
  ];

  setUp(() {
    mockDataSource = MockProductDataSource();
    repository = ProductRepositoryImpl(mockDataSource);
  });

  group('ProductRepositoryImpl', () {
    test('getAllProducts returns all products from data source', () async {
      when(() => mockDataSource.fetchAll())
          .thenAnswer((_) async => testProducts);

      final result = await repository.getAllProducts();

      expect(result, testProducts);
      verify(() => mockDataSource.fetchAll()).called(1);
    });

    test('getProductsByConcerns filters by concerns', () async {
      final filtered = [testProducts.first];
      when(() => mockDataSource.fetchByConcerns(['acne']))
          .thenAnswer((_) async => filtered);

      final result = await repository.getProductsByConcerns(['acne']);

      expect(result, filtered);
      expect(result.first.suitableConcerns, contains('acne'));
      verify(() => mockDataSource.fetchByConcerns(['acne'])).called(1);
    });

    test('getProductsByCategory filters by category', () async {
      final filtered = [testProducts.first];
      when(() => mockDataSource.fetchByCategory('temizleyici'))
          .thenAnswer((_) async => filtered);

      final result = await repository.getProductsByCategory('temizleyici');

      expect(result, filtered);
      expect(result.first.category, 'temizleyici');
      verify(() => mockDataSource.fetchByCategory('temizleyici')).called(1);
    });

    test('getAllProducts returns empty list when no products', () async {
      when(() => mockDataSource.fetchAll())
          .thenAnswer((_) async => <ProductEntity>[]);

      final result = await repository.getAllProducts();

      expect(result, isEmpty);
    });

    test('getProductsByConcerns returns empty for no matches', () async {
      when(() => mockDataSource.fetchByConcerns(['unknown']))
          .thenAnswer((_) async => <ProductEntity>[]);

      final result = await repository.getProductsByConcerns(['unknown']);

      expect(result, isEmpty);
    });
  });
}
