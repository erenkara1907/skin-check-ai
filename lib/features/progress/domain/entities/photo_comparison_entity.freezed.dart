// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_comparison_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PhotoComparisonEntity _$PhotoComparisonEntityFromJson(
  Map<String, dynamic> json,
) {
  return _PhotoComparisonEntity.fromJson(json);
}

/// @nodoc
mixin _$PhotoComparisonEntity {
  String? get firstPhotoUrl => throw _privateConstructorUsedError;
  DateTime? get firstDate => throw _privateConstructorUsedError;
  double get firstScore => throw _privateConstructorUsedError;
  String? get latestPhotoUrl => throw _privateConstructorUsedError;
  DateTime? get latestDate => throw _privateConstructorUsedError;
  double get latestScore => throw _privateConstructorUsedError;

  /// Serializes this PhotoComparisonEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhotoComparisonEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhotoComparisonEntityCopyWith<PhotoComparisonEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoComparisonEntityCopyWith<$Res> {
  factory $PhotoComparisonEntityCopyWith(
    PhotoComparisonEntity value,
    $Res Function(PhotoComparisonEntity) then,
  ) = _$PhotoComparisonEntityCopyWithImpl<$Res, PhotoComparisonEntity>;
  @useResult
  $Res call({
    String? firstPhotoUrl,
    DateTime? firstDate,
    double firstScore,
    String? latestPhotoUrl,
    DateTime? latestDate,
    double latestScore,
  });
}

/// @nodoc
class _$PhotoComparisonEntityCopyWithImpl<
  $Res,
  $Val extends PhotoComparisonEntity
>
    implements $PhotoComparisonEntityCopyWith<$Res> {
  _$PhotoComparisonEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhotoComparisonEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstPhotoUrl = freezed,
    Object? firstDate = freezed,
    Object? firstScore = null,
    Object? latestPhotoUrl = freezed,
    Object? latestDate = freezed,
    Object? latestScore = null,
  }) {
    return _then(
      _value.copyWith(
            firstPhotoUrl: freezed == firstPhotoUrl
                ? _value.firstPhotoUrl
                : firstPhotoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            firstDate: freezed == firstDate
                ? _value.firstDate
                : firstDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            firstScore: null == firstScore
                ? _value.firstScore
                : firstScore // ignore: cast_nullable_to_non_nullable
                      as double,
            latestPhotoUrl: freezed == latestPhotoUrl
                ? _value.latestPhotoUrl
                : latestPhotoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            latestDate: freezed == latestDate
                ? _value.latestDate
                : latestDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            latestScore: null == latestScore
                ? _value.latestScore
                : latestScore // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PhotoComparisonEntityImplCopyWith<$Res>
    implements $PhotoComparisonEntityCopyWith<$Res> {
  factory _$$PhotoComparisonEntityImplCopyWith(
    _$PhotoComparisonEntityImpl value,
    $Res Function(_$PhotoComparisonEntityImpl) then,
  ) = __$$PhotoComparisonEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? firstPhotoUrl,
    DateTime? firstDate,
    double firstScore,
    String? latestPhotoUrl,
    DateTime? latestDate,
    double latestScore,
  });
}

/// @nodoc
class __$$PhotoComparisonEntityImplCopyWithImpl<$Res>
    extends
        _$PhotoComparisonEntityCopyWithImpl<$Res, _$PhotoComparisonEntityImpl>
    implements _$$PhotoComparisonEntityImplCopyWith<$Res> {
  __$$PhotoComparisonEntityImplCopyWithImpl(
    _$PhotoComparisonEntityImpl _value,
    $Res Function(_$PhotoComparisonEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PhotoComparisonEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstPhotoUrl = freezed,
    Object? firstDate = freezed,
    Object? firstScore = null,
    Object? latestPhotoUrl = freezed,
    Object? latestDate = freezed,
    Object? latestScore = null,
  }) {
    return _then(
      _$PhotoComparisonEntityImpl(
        firstPhotoUrl: freezed == firstPhotoUrl
            ? _value.firstPhotoUrl
            : firstPhotoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        firstDate: freezed == firstDate
            ? _value.firstDate
            : firstDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        firstScore: null == firstScore
            ? _value.firstScore
            : firstScore // ignore: cast_nullable_to_non_nullable
                  as double,
        latestPhotoUrl: freezed == latestPhotoUrl
            ? _value.latestPhotoUrl
            : latestPhotoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        latestDate: freezed == latestDate
            ? _value.latestDate
            : latestDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        latestScore: null == latestScore
            ? _value.latestScore
            : latestScore // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PhotoComparisonEntityImpl implements _PhotoComparisonEntity {
  const _$PhotoComparisonEntityImpl({
    this.firstPhotoUrl,
    this.firstDate,
    this.firstScore = 0,
    this.latestPhotoUrl,
    this.latestDate,
    this.latestScore = 0,
  });

  factory _$PhotoComparisonEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhotoComparisonEntityImplFromJson(json);

  @override
  final String? firstPhotoUrl;
  @override
  final DateTime? firstDate;
  @override
  @JsonKey()
  final double firstScore;
  @override
  final String? latestPhotoUrl;
  @override
  final DateTime? latestDate;
  @override
  @JsonKey()
  final double latestScore;

  @override
  String toString() {
    return 'PhotoComparisonEntity(firstPhotoUrl: $firstPhotoUrl, firstDate: $firstDate, firstScore: $firstScore, latestPhotoUrl: $latestPhotoUrl, latestDate: $latestDate, latestScore: $latestScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoComparisonEntityImpl &&
            (identical(other.firstPhotoUrl, firstPhotoUrl) ||
                other.firstPhotoUrl == firstPhotoUrl) &&
            (identical(other.firstDate, firstDate) ||
                other.firstDate == firstDate) &&
            (identical(other.firstScore, firstScore) ||
                other.firstScore == firstScore) &&
            (identical(other.latestPhotoUrl, latestPhotoUrl) ||
                other.latestPhotoUrl == latestPhotoUrl) &&
            (identical(other.latestDate, latestDate) ||
                other.latestDate == latestDate) &&
            (identical(other.latestScore, latestScore) ||
                other.latestScore == latestScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    firstPhotoUrl,
    firstDate,
    firstScore,
    latestPhotoUrl,
    latestDate,
    latestScore,
  );

  /// Create a copy of PhotoComparisonEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoComparisonEntityImplCopyWith<_$PhotoComparisonEntityImpl>
  get copyWith =>
      __$$PhotoComparisonEntityImplCopyWithImpl<_$PhotoComparisonEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PhotoComparisonEntityImplToJson(this);
  }
}

abstract class _PhotoComparisonEntity implements PhotoComparisonEntity {
  const factory _PhotoComparisonEntity({
    final String? firstPhotoUrl,
    final DateTime? firstDate,
    final double firstScore,
    final String? latestPhotoUrl,
    final DateTime? latestDate,
    final double latestScore,
  }) = _$PhotoComparisonEntityImpl;

  factory _PhotoComparisonEntity.fromJson(Map<String, dynamic> json) =
      _$PhotoComparisonEntityImpl.fromJson;

  @override
  String? get firstPhotoUrl;
  @override
  DateTime? get firstDate;
  @override
  double get firstScore;
  @override
  String? get latestPhotoUrl;
  @override
  DateTime? get latestDate;
  @override
  double get latestScore;

  /// Create a copy of PhotoComparisonEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhotoComparisonEntityImplCopyWith<_$PhotoComparisonEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
