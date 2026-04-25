import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/products/domain/entities/product_entity.dart';
import 'package:skincheck_ai/features/products/presentation/providers/product_provider.dart';
import 'package:skincheck_ai/features/products/presentation/screens/products_screen.dart';

import '../../../../helpers/test_app.dart';

void main() {
  final testGrouped = {
    ProductCategory.temizleyici: [
      const ProductEntity(
        id: '1',
        name: 'Test Cleanser',
        brand: 'TestBrand',
        category: 'temizleyici',
        priceRange: '₺100-200',
        suitableConcerns: ['acne'],
        imageUrl: '',
        affiliateUrl: 'https://example.com',
        rating: 4.5,
        description: 'A test product',
      ),
    ],
    ProductCategory.serum: [
      const ProductEntity(
        id: '2',
        name: 'Test Serum',
        brand: 'SerumBrand',
        category: 'serum',
        priceRange: '₺200-300',
        suitableConcerns: ['wrinkles'],
        imageUrl: '',
        affiliateUrl: 'https://example.com',
        rating: 4.2,
        description: 'A test serum',
      ),
    ],
  };

  Widget buildTestWidget({
    required AsyncValue<Map<ProductCategory, List<ProductEntity>>> value,
    List<String> concerns = const [],
  }) {
    return pumpableTestApp(
      ProductsScreen(concerns: concerns),
      overrides: [
        allProductsProvider.overrideWith((_) => value.requireValue),
        recommendedProductsProvider(concerns)
            .overrideWith((_) => value.requireValue),
      ],
    );
  }

  group('ProductsScreen', () {
    testWidgets('shows loading state', (tester) async {
      await tester.pumpWidget(
        pumpableTestApp(const ProductsScreen()),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows category sections when data loads', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(value: AsyncData(testGrouped)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Temizleyici'), findsOneWidget);
      expect(find.text('Serum'), findsOneWidget);
    });

    testWidgets('shows product names in cards', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(value: AsyncData(testGrouped)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Cleanser'), findsOneWidget);
      expect(find.text('Test Serum'), findsOneWidget);
    });

    testWidgets('shows brand names', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(value: AsyncData(testGrouped)),
      );
      await tester.pumpAndSettle();

      expect(find.text('TestBrand'), findsOneWidget);
      expect(find.text('SerumBrand'), findsOneWidget);
    });

    testWidgets('shows "Ürün Kataloğu" title when no concerns', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(value: AsyncData(testGrouped)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Ürün Kataloğu'), findsOneWidget);
    });

    testWidgets('shows "Önerilen Ürünler" when concerns provided',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: AsyncData(testGrouped),
          concerns: ['acne'],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Önerilen Ürünler'), findsOneWidget);
    });

    testWidgets('shows empty view when no products', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          value: const AsyncData({}),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Henüz ürün eklenmemiş'), findsOneWidget);
    });

    testWidgets('shows buy buttons', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(value: AsyncData(testGrouped)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Satın Al'), findsNWidgets(2));
    });
  });
}
