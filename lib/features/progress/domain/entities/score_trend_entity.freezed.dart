// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score_trend_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScoreTrendEntity _$ScoreTrendEntityFromJson(Map<String, dynamic> json) {
  return _ScoreTrendEntity.fromJson(json);
}

/// @nodoc
mixin _$ScoreTrendEntity {
  DateTime get date => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;

  /// Serializes this ScoreTrendEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScoreTrendEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScoreTrendEntityCopyWith<ScoreTrendEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreTrendEntityCopyWith<$Res> {
  factory $ScoreTrendEntityCopyWith(
    ScoreTrendEntity value,
    $Res Function(ScoreTrendEntity) then,
  ) = _$ScoreTrendEntityCopyWithImpl<$Res, ScoreTrendEntity>;
  @useResult
  $Res call({DateTime date, double score});
}

/// @nodoc
class _$ScoreTrendEntityCopyWithImpl<$Res, $Val extends ScoreTrendEntity>
    implements $ScoreTrendEntityCopyWith<$Res> {
  _$ScoreTrendEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScoreTrendEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? score = null}) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScoreTrendEntityImplCopyWith<$Res>
    implements $ScoreTrendEntityCopyWith<$Res> {
  factory _$$ScoreTrendEntityImplCopyWith(
    _$ScoreTrendEntityImpl value,
    $Res Function(_$ScoreTrendEntityImpl) then,
  ) = __$$ScoreTrendEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, double score});
}

/// @nodoc
class __$$ScoreTrendEntityImplCopyWithImpl<$Res>
    extends _$ScoreTrendEntityCopyWithImpl<$Res, _$ScoreTrendEntityImpl>
    implements _$$ScoreTrendEntityImplCopyWith<$Res> {
  __$$ScoreTrendEntityImplCopyWithImpl(
    _$ScoreTrendEntityImpl _value,
    $Res Function(_$ScoreTrendEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScoreTrendEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? score = null}) {
    return _then(
      _$ScoreTrendEntityImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScoreTrendEntityImpl implements _ScoreTrendEntity {
  const _$ScoreTrendEntityImpl({required this.date, required this.score});

  factory _$ScoreTrendEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScoreTrendEntityImplFromJson(json);

  @override
  final DateTime date;
  @override
  final double score;

  @override
  String toString() {
    return 'ScoreTrendEntity(date: $date, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoreTrendEntityImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, score);

  /// Create a copy of ScoreTrendEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreTrendEntityImplCopyWith<_$ScoreTrendEntityImpl> get copyWith =>
      __$$ScoreTrendEntityImplCopyWithImpl<_$ScoreTrendEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ScoreTrendEntityImplToJson(this);
  }
}

abstract class _ScoreTrendEntity implements ScoreTrendEntity {
  const factory _ScoreTrendEntity({
    required final DateTime date,
    required final double score,
  }) = _$ScoreTrendEntityImpl;

  factory _ScoreTrendEntity.fromJson(Map<String, dynamic> json) =
      _$ScoreTrendEntityImpl.fromJson;

  @override
  DateTime get date;
  @override
  double get score;

  /// Create a copy of ScoreTrendEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScoreTrendEntityImplCopyWith<_$ScoreTrendEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
