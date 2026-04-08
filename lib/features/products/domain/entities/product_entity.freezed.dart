// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) {
  return _ProductEntity.fromJson(json);
}

/// @nodoc
mixin _$ProductEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_range')
  String get priceRange => throw _privateConstructorUsedError;
  @JsonKey(name: 'suitable_concerns')
  List<String> get suitableConcerns => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'affiliate_url')
  String get affiliateUrl => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ProductEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductEntityCopyWith<ProductEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductEntityCopyWith<$Res> {
  factory $ProductEntityCopyWith(
    ProductEntity value,
    $Res Function(ProductEntity) then,
  ) = _$ProductEntityCopyWithImpl<$Res, ProductEntity>;
  @useResult
  $Res call({
    String id,
    String name,
    String brand,
    String category,
    @JsonKey(name: 'price_range') String priceRange,
    @JsonKey(name: 'suitable_concerns') List<String> suitableConcerns,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'affiliate_url') String affiliateUrl,
    double rating,
    String description,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$ProductEntityCopyWithImpl<$Res, $Val extends ProductEntity>
    implements $ProductEntityCopyWith<$Res> {
  _$ProductEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brand = null,
    Object? category = null,
    Object? priceRange = null,
    Object? suitableConcerns = null,
    Object? imageUrl = null,
    Object? affiliateUrl = null,
    Object? rating = null,
    Object? description = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            brand: null == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            priceRange: null == priceRange
                ? _value.priceRange
                : priceRange // ignore: cast_nullable_to_non_nullable
                      as String,
            suitableConcerns: null == suitableConcerns
                ? _value.suitableConcerns
                : suitableConcerns // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            affiliateUrl: null == affiliateUrl
                ? _value.affiliateUrl
                : affiliateUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductEntityImplCopyWith<$Res>
    implements $ProductEntityCopyWith<$Res> {
  factory _$$ProductEntityImplCopyWith(
    _$ProductEntityImpl value,
    $Res Function(_$ProductEntityImpl) then,
  ) = __$$ProductEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String brand,
    String category,
    @JsonKey(name: 'price_range') String priceRange,
    @JsonKey(name: 'suitable_concerns') List<String> suitableConcerns,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'affiliate_url') String affiliateUrl,
    double rating,
    String description,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$ProductEntityImplCopyWithImpl<$Res>
    extends _$ProductEntityCopyWithImpl<$Res, _$ProductEntityImpl>
    implements _$$ProductEntityImplCopyWith<$Res> {
  __$$ProductEntityImplCopyWithImpl(
    _$ProductEntityImpl _value,
    $Res Function(_$ProductEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brand = null,
    Object? category = null,
    Object? priceRange = null,
    Object? suitableConcerns = null,
    Object? imageUrl = null,
    Object? affiliateUrl = null,
    Object? rating = null,
    Object? description = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$ProductEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        brand: null == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        priceRange: null == priceRange
            ? _value.priceRange
            : priceRange // ignore: cast_nullable_to_non_nullable
                  as String,
        suitableConcerns: null == suitableConcerns
            ? _value._suitableConcerns
            : suitableConcerns // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        affiliateUrl: null == affiliateUrl
            ? _value.affiliateUrl
            : affiliateUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductEntityImpl implements _ProductEntity {
  const _$ProductEntityImpl({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    @JsonKey(name: 'price_range') required this.priceRange,
    @JsonKey(name: 'suitable_concerns')
    final List<String> suitableConcerns = const [],
    @JsonKey(name: 'image_url') this.imageUrl = '',
    @JsonKey(name: 'affiliate_url') this.affiliateUrl = '',
    this.rating = 4.0,
    this.description = '',
    @JsonKey(name: 'created_at') this.createdAt,
  }) : _suitableConcerns = suitableConcerns;

  factory _$ProductEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String brand;
  @override
  final String category;
  @override
  @JsonKey(name: 'price_range')
  final String priceRange;
  final List<String> _suitableConcerns;
  @override
  @JsonKey(name: 'suitable_concerns')
  List<String> get suitableConcerns {
    if (_suitableConcerns is EqualUnmodifiableListView)
      return _suitableConcerns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suitableConcerns);
  }

  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'affiliate_url')
  final String affiliateUrl;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ProductEntity(id: $id, name: $name, brand: $brand, category: $category, priceRange: $priceRange, suitableConcerns: $suitableConcerns, imageUrl: $imageUrl, affiliateUrl: $affiliateUrl, rating: $rating, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.priceRange, priceRange) ||
                other.priceRange == priceRange) &&
            const DeepCollectionEquality().equals(
              other._suitableConcerns,
              _suitableConcerns,
            ) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.affiliateUrl, affiliateUrl) ||
                other.affiliateUrl == affiliateUrl) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    brand,
    category,
    priceRange,
    const DeepCollectionEquality().hash(_suitableConcerns),
    imageUrl,
    affiliateUrl,
    rating,
    description,
    createdAt,
  );

  /// Create a copy of ProductEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductEntityImplCopyWith<_$ProductEntityImpl> get copyWith =>
      __$$ProductEntityImplCopyWithImpl<_$ProductEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductEntityImplToJson(this);
  }
}

abstract class _ProductEntity implements ProductEntity {
  const factory _ProductEntity({
    required final String id,
    required final String name,
    required final String brand,
    required final String category,
    @JsonKey(name: 'price_range') required final String priceRange,
    @JsonKey(name: 'suitable_concerns') final List<String> suitableConcerns,
    @JsonKey(name: 'image_url') final String imageUrl,
    @JsonKey(name: 'affiliate_url') final String affiliateUrl,
    final double rating,
    final String description,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$ProductEntityImpl;

  factory _ProductEntity.fromJson(Map<String, dynamic> json) =
      _$ProductEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get brand;
  @override
  String get category;
  @override
  @JsonKey(name: 'price_range')
  String get priceRange;
  @override
  @JsonKey(name: 'suitable_concerns')
  List<String> get suitableConcerns;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @JsonKey(name: 'affiliate_url')
  String get affiliateUrl;
  @override
  double get rating;
  @override
  String get description;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of ProductEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductEntityImplCopyWith<_$ProductEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
