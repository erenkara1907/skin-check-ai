// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'concern_timeline_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ConcernTimelineEntity _$ConcernTimelineEntityFromJson(
  Map<String, dynamic> json,
) {
  return _ConcernTimelineEntity.fromJson(json);
}

/// @nodoc
mixin _$ConcernTimelineEntity {
  DateTime get date => throw _privateConstructorUsedError;
  String get concern => throw _privateConstructorUsedError;
  int get severity => throw _privateConstructorUsedError;
  String get zone => throw _privateConstructorUsedError;

  /// Serializes this ConcernTimelineEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConcernTimelineEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConcernTimelineEntityCopyWith<ConcernTimelineEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConcernTimelineEntityCopyWith<$Res> {
  factory $ConcernTimelineEntityCopyWith(
    ConcernTimelineEntity value,
    $Res Function(ConcernTimelineEntity) then,
  ) = _$ConcernTimelineEntityCopyWithImpl<$Res, ConcernTimelineEntity>;
  @useResult
  $Res call({DateTime date, String concern, int severity, String zone});
}

/// @nodoc
class _$ConcernTimelineEntityCopyWithImpl<
  $Res,
  $Val extends ConcernTimelineEntity
>
    implements $ConcernTimelineEntityCopyWith<$Res> {
  _$ConcernTimelineEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConcernTimelineEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? concern = null,
    Object? severity = null,
    Object? zone = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            concern: null == concern
                ? _value.concern
                : concern // ignore: cast_nullable_to_non_nullable
                      as String,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as int,
            zone: null == zone
                ? _value.zone
                : zone // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConcernTimelineEntityImplCopyWith<$Res>
    implements $ConcernTimelineEntityCopyWith<$Res> {
  factory _$$ConcernTimelineEntityImplCopyWith(
    _$ConcernTimelineEntityImpl value,
    $Res Function(_$ConcernTimelineEntityImpl) then,
  ) = __$$ConcernTimelineEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, String concern, int severity, String zone});
}

/// @nodoc
class __$$ConcernTimelineEntityImplCopyWithImpl<$Res>
    extends
        _$ConcernTimelineEntityCopyWithImpl<$Res, _$ConcernTimelineEntityImpl>
    implements _$$ConcernTimelineEntityImplCopyWith<$Res> {
  __$$ConcernTimelineEntityImplCopyWithImpl(
    _$ConcernTimelineEntityImpl _value,
    $Res Function(_$ConcernTimelineEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConcernTimelineEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? concern = null,
    Object? severity = null,
    Object? zone = null,
  }) {
    return _then(
      _$ConcernTimelineEntityImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        concern: null == concern
            ? _value.concern
            : concern // ignore: cast_nullable_to_non_nullable
                  as String,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as int,
        zone: null == zone
            ? _value.zone
            : zone // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConcernTimelineEntityImpl implements _ConcernTimelineEntity {
  const _$ConcernTimelineEntityImpl({
    required this.date,
    required this.concern,
    required this.severity,
    required this.zone,
  });

  factory _$ConcernTimelineEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConcernTimelineEntityImplFromJson(json);

  @override
  final DateTime date;
  @override
  final String concern;
  @override
  final int severity;
  @override
  final String zone;

  @override
  String toString() {
    return 'ConcernTimelineEntity(date: $date, concern: $concern, severity: $severity, zone: $zone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConcernTimelineEntityImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.concern, concern) || other.concern == concern) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.zone, zone) || other.zone == zone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, concern, severity, zone);

  /// Create a copy of ConcernTimelineEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConcernTimelineEntityImplCopyWith<_$ConcernTimelineEntityImpl>
  get copyWith =>
      __$$ConcernTimelineEntityImplCopyWithImpl<_$ConcernTimelineEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConcernTimelineEntityImplToJson(this);
  }
}

abstract class _ConcernTimelineEntity implements ConcernTimelineEntity {
  const factory _ConcernTimelineEntity({
    required final DateTime date,
    required final String concern,
    required final int severity,
    required final String zone,
  }) = _$ConcernTimelineEntityImpl;

  factory _ConcernTimelineEntity.fromJson(Map<String, dynamic> json) =
      _$ConcernTimelineEntityImpl.fromJson;

  @override
  DateTime get date;
  @override
  String get concern;
  @override
  int get severity;
  @override
  String get zone;

  /// Create a copy of ConcernTimelineEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConcernTimelineEntityImplCopyWith<_$ConcernTimelineEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
