import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entity.freezed.dart';
part 'product_entity.g.dart';

/// Product categories with Turkish display labels.
enum ProductCategory {
  temizleyici('Temizleyici'),
  tonik('Tonik'),
  serum('Serum'),
  nemlendirici('Nemlendirici'),
  spf('Güneş Koruyucu'),
  // ignore: constant_identifier_names
  goz_kremi('Göz Kremi');

  const ProductCategory(this.label);

  /// Turkish display label.
  final String label;
}

/// A skincare product with matching concern tags.
@freezed
class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    required String id,
    required String name,
    required String brand,
    required String category,
    @JsonKey(name: 'price_range') required String priceRange,
    @JsonKey(name: 'suitable_concerns')
    @Default([])
    List<String> suitableConcerns,
    @JsonKey(name: 'image_url') @Default('') String imageUrl,
    @JsonKey(name: 'affiliate_url') @Default('') String affiliateUrl,
    @Default(4.0) double rating,
    @Default('') String description,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ProductEntity;

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);
}
