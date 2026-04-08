// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zone_score_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ZoneScoreEntity _$ZoneScoreEntityFromJson(Map<String, dynamic> json) {
  return _ZoneScoreEntity.fromJson(json);
}

/// @nodoc
mixin _$ZoneScoreEntity {
  String get zone => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  List<String> get concerns => throw _privateConstructorUsedError;
  int get severity => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;

  /// Serializes this ZoneScoreEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ZoneScoreEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ZoneScoreEntityCopyWith<ZoneScoreEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ZoneScoreEntityCopyWith<$Res> {
  factory $ZoneScoreEntityCopyWith(
    ZoneScoreEntity value,
    $Res Function(ZoneScoreEntity) then,
  ) = _$ZoneScoreEntityCopyWithImpl<$Res, ZoneScoreEntity>;
  @useResult
  $Res call({
    String zone,
    double score,
    List<String> concerns,
    int severity,
    List<String> recommendations,
  });
}

/// @nodoc
class _$ZoneScoreEntityCopyWithImpl<$Res, $Val extends ZoneScoreEntity>
    implements $ZoneScoreEntityCopyWith<$Res> {
  _$ZoneScoreEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ZoneScoreEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zone = null,
    Object? score = null,
    Object? concerns = null,
    Object? severity = null,
    Object? recommendations = null,
  }) {
    return _then(
      _value.copyWith(
            zone: null == zone
                ? _value.zone
                : zone // ignore: cast_nullable_to_non_nullable
                      as String,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as double,
            concerns: null == concerns
                ? _value.concerns
                : concerns // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as int,
            recommendations: null == recommendations
                ? _value.recommendations
                : recommendations // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ZoneScoreEntityImplCopyWith<$Res>
    implements $ZoneScoreEntityCopyWith<$Res> {
  factory _$$ZoneScoreEntityImplCopyWith(
    _$ZoneScoreEntityImpl value,
    $Res Function(_$ZoneScoreEntityImpl) then,
  ) = __$$ZoneScoreEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String zone,
    double score,
    List<String> concerns,
    int severity,
    List<String> recommendations,
  });
}

/// @nodoc
class __$$ZoneScoreEntityImplCopyWithImpl<$Res>
    extends _$ZoneScoreEntityCopyWithImpl<$Res, _$ZoneScoreEntityImpl>
    implements _$$ZoneScoreEntityImplCopyWith<$Res> {
  __$$ZoneScoreEntityImplCopyWithImpl(
    _$ZoneScoreEntityImpl _value,
    $Res Function(_$ZoneScoreEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ZoneScoreEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zone = null,
    Object? score = null,
    Object? concerns = null,
    Object? severity = null,
    Object? recommendations = null,
  }) {
    return _then(
      _$ZoneScoreEntityImpl(
        zone: null == zone
            ? _value.zone
            : zone // ignore: cast_nullable_to_non_nullable
                  as String,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as double,
        concerns: null == concerns
            ? _value._concerns
            : concerns // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as int,
        recommendations: null == recommendations
            ? _value._recommendations
            : recommendations // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ZoneScoreEntityImpl implements _ZoneScoreEntity {
  const _$ZoneScoreEntityImpl({
    required this.zone,
    required this.score,
    final List<String> concerns = const [],
    this.severity = 5,
    final List<String> recommendations = const [],
  }) : _concerns = concerns,
       _recommendations = recommendations;

  factory _$ZoneScoreEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ZoneScoreEntityImplFromJson(json);

  @override
  final String zone;
  @override
  final double score;
  final List<String> _concerns;
  @override
  @JsonKey()
  List<String> get concerns {
    if (_concerns is EqualUnmodifiableListView) return _concerns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_concerns);
  }

  @override
  @JsonKey()
  final int severity;
  final List<String> _recommendations;
  @override
  @JsonKey()
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  String toString() {
    return 'ZoneScoreEntity(zone: $zone, score: $score, concerns: $concerns, severity: $severity, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ZoneScoreEntityImpl &&
            (identical(other.zone, zone) || other.zone == zone) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other._concerns, _concerns) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            const DeepCollectionEquality().equals(
              other._recommendations,
              _recommendations,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    zone,
    score,
    const DeepCollectionEquality().hash(_concerns),
    severity,
    const DeepCollectionEquality().hash(_recommendations),
  );

  /// Create a copy of ZoneScoreEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ZoneScoreEntityImplCopyWith<_$ZoneScoreEntityImpl> get copyWith =>
      __$$ZoneScoreEntityImplCopyWithImpl<_$ZoneScoreEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ZoneScoreEntityImplToJson(this);
  }
}

abstract class _ZoneScoreEntity implements ZoneScoreEntity {
  const factory _ZoneScoreEntity({
    required final String zone,
    required final double score,
    final List<String> concerns,
    final int severity,
    final List<String> recommendations,
  }) = _$ZoneScoreEntityImpl;

  factory _ZoneScoreEntity.fromJson(Map<String, dynamic> json) =
      _$ZoneScoreEntityImpl.fromJson;

  @override
  String get zone;
  @override
  double get score;
  @override
  List<String> get concerns;
  @override
  int get severity;
  @override
  List<String> get recommendations;

  /// Create a copy of ZoneScoreEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ZoneScoreEntityImplCopyWith<_$ZoneScoreEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
