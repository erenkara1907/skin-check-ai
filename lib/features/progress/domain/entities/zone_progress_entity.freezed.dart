// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zone_progress_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ZoneProgressEntity _$ZoneProgressEntityFromJson(Map<String, dynamic> json) {
  return _ZoneProgressEntity.fromJson(json);
}

/// @nodoc
mixin _$ZoneProgressEntity {
  String get zone => throw _privateConstructorUsedError;
  String get zoneName => throw _privateConstructorUsedError;
  double get currentScore => throw _privateConstructorUsedError;
  double get previousScore => throw _privateConstructorUsedError;
  double get changePercent => throw _privateConstructorUsedError;

  /// Serializes this ZoneProgressEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ZoneProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ZoneProgressEntityCopyWith<ZoneProgressEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ZoneProgressEntityCopyWith<$Res> {
  factory $ZoneProgressEntityCopyWith(
    ZoneProgressEntity value,
    $Res Function(ZoneProgressEntity) then,
  ) = _$ZoneProgressEntityCopyWithImpl<$Res, ZoneProgressEntity>;
  @useResult
  $Res call({
    String zone,
    String zoneName,
    double currentScore,
    double previousScore,
    double changePercent,
  });
}

/// @nodoc
class _$ZoneProgressEntityCopyWithImpl<$Res, $Val extends ZoneProgressEntity>
    implements $ZoneProgressEntityCopyWith<$Res> {
  _$ZoneProgressEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ZoneProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zone = null,
    Object? zoneName = null,
    Object? currentScore = null,
    Object? previousScore = null,
    Object? changePercent = null,
  }) {
    return _then(
      _value.copyWith(
            zone: null == zone
                ? _value.zone
                : zone // ignore: cast_nullable_to_non_nullable
                      as String,
            zoneName: null == zoneName
                ? _value.zoneName
                : zoneName // ignore: cast_nullable_to_non_nullable
                      as String,
            currentScore: null == currentScore
                ? _value.currentScore
                : currentScore // ignore: cast_nullable_to_non_nullable
                      as double,
            previousScore: null == previousScore
                ? _value.previousScore
                : previousScore // ignore: cast_nullable_to_non_nullable
                      as double,
            changePercent: null == changePercent
                ? _value.changePercent
                : changePercent // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ZoneProgressEntityImplCopyWith<$Res>
    implements $ZoneProgressEntityCopyWith<$Res> {
  factory _$$ZoneProgressEntityImplCopyWith(
    _$ZoneProgressEntityImpl value,
    $Res Function(_$ZoneProgressEntityImpl) then,
  ) = __$$ZoneProgressEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String zone,
    String zoneName,
    double currentScore,
    double previousScore,
    double changePercent,
  });
}

/// @nodoc
class __$$ZoneProgressEntityImplCopyWithImpl<$Res>
    extends _$ZoneProgressEntityCopyWithImpl<$Res, _$ZoneProgressEntityImpl>
    implements _$$ZoneProgressEntityImplCopyWith<$Res> {
  __$$ZoneProgressEntityImplCopyWithImpl(
    _$ZoneProgressEntityImpl _value,
    $Res Function(_$ZoneProgressEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ZoneProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zone = null,
    Object? zoneName = null,
    Object? currentScore = null,
    Object? previousScore = null,
    Object? changePercent = null,
  }) {
    return _then(
      _$ZoneProgressEntityImpl(
        zone: null == zone
            ? _value.zone
            : zone // ignore: cast_nullable_to_non_nullable
                  as String,
        zoneName: null == zoneName
            ? _value.zoneName
            : zoneName // ignore: cast_nullable_to_non_nullable
                  as String,
        currentScore: null == currentScore
            ? _value.currentScore
            : currentScore // ignore: cast_nullable_to_non_nullable
                  as double,
        previousScore: null == previousScore
            ? _value.previousScore
            : previousScore // ignore: cast_nullable_to_non_nullable
                  as double,
        changePercent: null == changePercent
            ? _value.changePercent
            : changePercent // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ZoneProgressEntityImpl implements _ZoneProgressEntity {
  const _$ZoneProgressEntityImpl({
    required this.zone,
    required this.zoneName,
    required this.currentScore,
    required this.previousScore,
    required this.changePercent,
  });

  factory _$ZoneProgressEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ZoneProgressEntityImplFromJson(json);

  @override
  final String zone;
  @override
  final String zoneName;
  @override
  final double currentScore;
  @override
  final double previousScore;
  @override
  final double changePercent;

  @override
  String toString() {
    return 'ZoneProgressEntity(zone: $zone, zoneName: $zoneName, currentScore: $currentScore, previousScore: $previousScore, changePercent: $changePercent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ZoneProgressEntityImpl &&
            (identical(other.zone, zone) || other.zone == zone) &&
            (identical(other.zoneName, zoneName) ||
                other.zoneName == zoneName) &&
            (identical(other.currentScore, currentScore) ||
                other.currentScore == currentScore) &&
            (identical(other.previousScore, previousScore) ||
                other.previousScore == previousScore) &&
            (identical(other.changePercent, changePercent) ||
                other.changePercent == changePercent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    zone,
    zoneName,
    currentScore,
    previousScore,
    changePercent,
  );

  /// Create a copy of ZoneProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ZoneProgressEntityImplCopyWith<_$ZoneProgressEntityImpl> get copyWith =>
      __$$ZoneProgressEntityImplCopyWithImpl<_$ZoneProgressEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ZoneProgressEntityImplToJson(this);
  }
}

abstract class _ZoneProgressEntity implements ZoneProgressEntity {
  const factory _ZoneProgressEntity({
    required final String zone,
    required final String zoneName,
    required final double currentScore,
    required final double previousScore,
    required final double changePercent,
  }) = _$ZoneProgressEntityImpl;

  factory _ZoneProgressEntity.fromJson(Map<String, dynamic> json) =
      _$ZoneProgressEntityImpl.fromJson;

  @override
  String get zone;
  @override
  String get zoneName;
  @override
  double get currentScore;
  @override
  double get previousScore;
  @override
  double get changePercent;

  /// Create a copy of ZoneProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ZoneProgressEntityImplCopyWith<_$ZoneProgressEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
