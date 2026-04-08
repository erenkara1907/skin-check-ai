// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_card_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShareCardData _$ShareCardDataFromJson(Map<String, dynamic> json) {
  return _ShareCardData.fromJson(json);
}

/// @nodoc
mixin _$ShareCardData {
  double get overallScore => throw _privateConstructorUsedError;
  int get skinAge => throw _privateConstructorUsedError;
  List<ZoneScoreEntity> get zones => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  /// Serializes this ShareCardData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShareCardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShareCardDataCopyWith<ShareCardData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShareCardDataCopyWith<$Res> {
  factory $ShareCardDataCopyWith(
    ShareCardData value,
    $Res Function(ShareCardData) then,
  ) = _$ShareCardDataCopyWithImpl<$Res, ShareCardData>;
  @useResult
  $Res call({
    double overallScore,
    int skinAge,
    List<ZoneScoreEntity> zones,
    String label,
  });
}

/// @nodoc
class _$ShareCardDataCopyWithImpl<$Res, $Val extends ShareCardData>
    implements $ShareCardDataCopyWith<$Res> {
  _$ShareCardDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShareCardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallScore = null,
    Object? skinAge = null,
    Object? zones = null,
    Object? label = null,
  }) {
    return _then(
      _value.copyWith(
            overallScore: null == overallScore
                ? _value.overallScore
                : overallScore // ignore: cast_nullable_to_non_nullable
                      as double,
            skinAge: null == skinAge
                ? _value.skinAge
                : skinAge // ignore: cast_nullable_to_non_nullable
                      as int,
            zones: null == zones
                ? _value.zones
                : zones // ignore: cast_nullable_to_non_nullable
                      as List<ZoneScoreEntity>,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShareCardDataImplCopyWith<$Res>
    implements $ShareCardDataCopyWith<$Res> {
  factory _$$ShareCardDataImplCopyWith(
    _$ShareCardDataImpl value,
    $Res Function(_$ShareCardDataImpl) then,
  ) = __$$ShareCardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double overallScore,
    int skinAge,
    List<ZoneScoreEntity> zones,
    String label,
  });
}

/// @nodoc
class __$$ShareCardDataImplCopyWithImpl<$Res>
    extends _$ShareCardDataCopyWithImpl<$Res, _$ShareCardDataImpl>
    implements _$$ShareCardDataImplCopyWith<$Res> {
  __$$ShareCardDataImplCopyWithImpl(
    _$ShareCardDataImpl _value,
    $Res Function(_$ShareCardDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShareCardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallScore = null,
    Object? skinAge = null,
    Object? zones = null,
    Object? label = null,
  }) {
    return _then(
      _$ShareCardDataImpl(
        overallScore: null == overallScore
            ? _value.overallScore
            : overallScore // ignore: cast_nullable_to_non_nullable
                  as double,
        skinAge: null == skinAge
            ? _value.skinAge
            : skinAge // ignore: cast_nullable_to_non_nullable
                  as int,
        zones: null == zones
            ? _value._zones
            : zones // ignore: cast_nullable_to_non_nullable
                  as List<ZoneScoreEntity>,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShareCardDataImpl implements _ShareCardData {
  const _$ShareCardDataImpl({
    required this.overallScore,
    required this.skinAge,
    final List<ZoneScoreEntity> zones = const [],
    this.label = 'Analiz Sonucu',
  }) : _zones = zones;

  factory _$ShareCardDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShareCardDataImplFromJson(json);

  @override
  final double overallScore;
  @override
  final int skinAge;
  final List<ZoneScoreEntity> _zones;
  @override
  @JsonKey()
  List<ZoneScoreEntity> get zones {
    if (_zones is EqualUnmodifiableListView) return _zones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_zones);
  }

  @override
  @JsonKey()
  final String label;

  @override
  String toString() {
    return 'ShareCardData(overallScore: $overallScore, skinAge: $skinAge, zones: $zones, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShareCardDataImpl &&
            (identical(other.overallScore, overallScore) ||
                other.overallScore == overallScore) &&
            (identical(other.skinAge, skinAge) || other.skinAge == skinAge) &&
            const DeepCollectionEquality().equals(other._zones, _zones) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    overallScore,
    skinAge,
    const DeepCollectionEquality().hash(_zones),
    label,
  );

  /// Create a copy of ShareCardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShareCardDataImplCopyWith<_$ShareCardDataImpl> get copyWith =>
      __$$ShareCardDataImplCopyWithImpl<_$ShareCardDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShareCardDataImplToJson(this);
  }
}

abstract class _ShareCardData implements ShareCardData {
  const factory _ShareCardData({
    required final double overallScore,
    required final int skinAge,
    final List<ZoneScoreEntity> zones,
    final String label,
  }) = _$ShareCardDataImpl;

  factory _ShareCardData.fromJson(Map<String, dynamic> json) =
      _$ShareCardDataImpl.fromJson;

  @override
  double get overallScore;
  @override
  int get skinAge;
  @override
  List<ZoneScoreEntity> get zones;
  @override
  String get label;

  /// Create a copy of ShareCardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShareCardDataImplCopyWith<_$ShareCardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
