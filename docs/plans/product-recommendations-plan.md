# Feature Plan: Product Recommendations

**Feature ID:** `product-recommendations`
**Date:** 2026-04-08

---

## Overview

AI-powered skincare product recommendation system that matches products to user's skin concerns from analysis results. Includes product catalog with categories, concern-based matching, and affiliate purchase links.

---

## 1. Database Changes (Supabase)

### `products` table — seed with 24 sample products

| Column | Type | Description |
|--------|------|-------------|
| id | uuid (PK) | Auto-generated |
| name | text | Product name |
| brand | text | Brand name |
| category | text | temizleyici, tonik, serum, nemlendirici, spf, goz_kremi |
| price_range | text | e.g. "₺150-250" |
| suitable_concerns | text[] | Array: acne, wrinkles, spots, pores, dryness, oiliness, darkCircles, redness |
| image_url | text | Placeholder image URL |
| affiliate_url | text | Affiliate purchase link |
| rating | double precision | 1.0-5.0 |
| description | text | Short product description |
| created_at | timestamptz | Default now() |

**RLS:** Read-only for authenticated users.

### Seed data: 4 products per category (24 total)
- Temizleyici (Cleanser)
- Tonik (Toner)
- Serum
- Nemlendirici (Moisturizer)
- SPF (Sunscreen)
- Göz Kremi (Eye Cream)

---

## 2. Domain Layer

### `lib/features/products/domain/entities/product_entity.dart`
- Freezed entity matching DB schema
- `ProductCategory` enum with Turkish labels

### `lib/features/products/domain/repositories/product_repository.dart`
- `Future<List<ProductEntity>> getAllProducts()`
- `Future<List<ProductEntity>> getProductsByConcerns(List<String> concerns)`
- `Future<List<ProductEntity>> getProductsByCategory(String category)`

---

## 3. Data Layer

### `lib/features/products/data/datasources/product_datasource.dart`
- Supabase queries against `products` table
- Filter by `suitable_concerns` using Supabase `overlaps` operator

### `lib/features/products/data/repositories/product_repository_impl.dart`
- Implements `ProductRepository`

---

## 4. Presentation Layer

### Providers
**`lib/features/products/presentation/providers/product_provider.dart`**
- `productRepositoryProvider` — DI for repo
- `allProductsProvider` — fetches all products grouped by category
- `recommendedProductsProvider(List<String> concerns)` — fetches matched products

### Screens
**`lib/features/products/presentation/screens/products_screen.dart`** (replace placeholder)
- Full product catalog grouped by category
- Horizontal scroll per category
- Optional `concerns` query param for pre-filtering

### Widgets
**`lib/features/products/presentation/widgets/product_card.dart`**
- Compact card: image, name, brand, price, rating stars
- "Satın Al" button → url_launcher
- "Neden bu ürün?" button → shows AI explanation dialog

**`lib/features/products/presentation/widgets/product_category_section.dart`**
- Category title + horizontal ListView of ProductCards

**`lib/features/products/presentation/widgets/product_reason_dialog.dart`**
- Dialog showing why this product matches user's concerns

### Analysis Result Screen Integration
**`lib/features/analysis/presentation/widgets/recommended_products_section.dart`**
- "Önerilen Ürünler" section at bottom of result screen
- Shows top 6 matched products in horizontal scroll
- "Tümünü Gör" button → navigates to full products screen

---

## 5. Router Changes

**`lib/core/router/app_router.dart`**
- Update `/products` route to accept optional `concerns` query parameter

---

## 6. Files to Create/Modify

### Create:
1. `lib/features/products/domain/entities/product_entity.dart`
2. `lib/features/products/domain/repositories/product_repository.dart`
3. `lib/features/products/data/datasources/product_datasource.dart`
4. `lib/features/products/data/repositories/product_repository_impl.dart`
5. `lib/features/products/presentation/providers/product_provider.dart`
6. `lib/features/products/presentation/widgets/product_card.dart`
7. `lib/features/products/presentation/widgets/product_category_section.dart`
8. `lib/features/products/presentation/widgets/product_reason_dialog.dart`
9. `lib/features/analysis/presentation/widgets/recommended_products_section.dart`
10. `supabase/migrations/20260408_create_products.sql`

### Modify:
1. `lib/features/products/presentation/screens/products_screen.dart` — full rewrite
2. `lib/features/analysis/presentation/screens/analysis_result_screen.dart` — add recommended products section
3. `lib/core/router/app_router.dart` — update products route

---

## 7. Test Cases

### Unit Tests:
- `test/features/products/data/repositories/product_repository_impl_test.dart`
  - Fetch all products
  - Filter by concerns
  - Filter by category
  - Empty results handling

### Widget Tests:
- `test/features/products/presentation/screens/products_screen_test.dart`
  - Renders category sections
  - Renders product cards
  - Loading state
  - Error state
  - Empty state

---

## 8. Security Concerns

- RLS: authenticated users can only SELECT from products (no insert/update/delete)
- Affiliate URLs opened via url_launcher (external browser) — no in-app webview with credentials
- No user data exposed in product queries
- Product images from placeholder URLs only (no user-uploaded content)
