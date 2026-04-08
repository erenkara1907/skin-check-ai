// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductEntityImpl _$$ProductEntityImplFromJson(Map<String, dynamic> json) =>
    _$ProductEntityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      category: json['category'] as String,
      priceRange: json['price_range'] as String,
      suitableConcerns:
          (json['suitable_concerns'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      imageUrl: json['image_url'] as String? ?? '',
      affiliateUrl: json['affiliate_url'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.0,
      description: json['description'] as String? ?? '',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ProductEntityImplToJson(_$ProductEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'brand': instance.brand,
      'category': instance.category,
      'price_range': instance.priceRange,
      'suitable_concerns': instance.suitableConcerns,
      'image_url': instance.imageUrl,
      'affiliate_url': instance.affiliateUrl,
      'rating': instance.rating,
      'description': instance.description,
      'created_at': instance.createdAt?.toIso8601String(),
    };
