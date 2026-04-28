// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_summary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WeeklySummaryEntity _$WeeklySummaryEntityFromJson(Map<String, dynamic> json) {
  return _WeeklySummaryEntity.fromJson(json);
}

/// @nodoc
mixin _$WeeklySummaryEntity {
  int get morningCompleted => throw _privateConstructorUsedError;
  int get eveningCompleted => throw _privateConstructorUsedError;
  int get totalDays => throw _privateConstructorUsedError;
  int get analysisCount => throw _privateConstructorUsedError;

  /// Serializes this WeeklySummaryEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeeklySummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklySummaryEntityCopyWith<WeeklySummaryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklySummaryEntityCopyWith<$Res> {
  factory $WeeklySummaryEntityCopyWith(
    WeeklySummaryEntity value,
    $Res Function(WeeklySummaryEntity) then,
  ) = _$WeeklySummaryEntityCopyWithImpl<$Res, WeeklySummaryEntity>;
  @useResult
  $Res call({
    int morningCompleted,
    int eveningCompleted,
    int totalDays,
    int analysisCount,
  });
}

/// @nodoc
class _$WeeklySummaryEntityCopyWithImpl<$Res, $Val extends WeeklySummaryEntity>
    implements $WeeklySummaryEntityCopyWith<$Res> {
  _$WeeklySummaryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklySummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? morningCompleted = null,
    Object? eveningCompleted = null,
    Object? totalDays = null,
    Object? analysisCount = null,
  }) {
    return _then(
      _value.copyWith(
            morningCompleted: null == morningCompleted
                ? _value.morningCompleted
                : morningCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            eveningCompleted: null == eveningCompleted
                ? _value.eveningCompleted
                : eveningCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            totalDays: null == totalDays
                ? _value.totalDays
                : totalDays // ignore: cast_nullable_to_non_nullable
                      as int,
            analysisCount: null == analysisCount
                ? _value.analysisCount
                : analysisCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WeeklySummaryEntityImplCopyWith<$Res>
    implements $WeeklySummaryEntityCopyWith<$Res> {
  factory _$$WeeklySummaryEntityImplCopyWith(
    _$WeeklySummaryEntityImpl value,
    $Res Function(_$WeeklySummaryEntityImpl) then,
  ) = __$$WeeklySummaryEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int morningCompleted,
    int eveningCompleted,
    int totalDays,
    int analysisCount,
  });
}

/// @nodoc
class __$$WeeklySummaryEntityImplCopyWithImpl<$Res>
    extends _$WeeklySummaryEntityCopyWithImpl<$Res, _$WeeklySummaryEntityImpl>
    implements _$$WeeklySummaryEntityImplCopyWith<$Res> {
  __$$WeeklySummaryEntityImplCopyWithImpl(
    _$WeeklySummaryEntityImpl _value,
    $Res Function(_$WeeklySummaryEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeeklySummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? morningCompleted = null,
    Object? eveningCompleted = null,
    Object? totalDays = null,
    Object? analysisCount = null,
  }) {
    return _then(
      _$WeeklySummaryEntityImpl(
        morningCompleted: null == morningCompleted
            ? _value.morningCompleted
            : morningCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        eveningCompleted: null == eveningCompleted
            ? _value.eveningCompleted
            : eveningCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        totalDays: null == totalDays
            ? _value.totalDays
            : totalDays // ignore: cast_nullable_to_non_nullable
                  as int,
        analysisCount: null == analysisCount
            ? _value.analysisCount
            : analysisCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WeeklySummaryEntityImpl implements _WeeklySummaryEntity {
  const _$WeeklySummaryEntityImpl({
    this.morningCompleted = 0,
    this.eveningCompleted = 0,
    this.totalDays = 7,
    this.analysisCount = 0,
  });

  factory _$WeeklySummaryEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklySummaryEntityImplFromJson(json);

  @override
  @JsonKey()
  final int morningCompleted;
  @override
  @JsonKey()
  final int eveningCompleted;
  @override
  @JsonKey()
  final int totalDays;
  @override
  @JsonKey()
  final int analysisCount;

  @override
  String toString() {
    return 'WeeklySummaryEntity(morningCompleted: $morningCompleted, eveningCompleted: $eveningCompleted, totalDays: $totalDays, analysisCount: $analysisCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklySummaryEntityImpl &&
            (identical(other.morningCompleted, morningCompleted) ||
                other.morningCompleted == morningCompleted) &&
            (identical(other.eveningCompleted, eveningCompleted) ||
                other.eveningCompleted == eveningCompleted) &&
            (identical(other.totalDays, totalDays) ||
                other.totalDays == totalDays) &&
            (identical(other.analysisCount, analysisCount) ||
                other.analysisCount == analysisCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    morningCompleted,
    eveningCompleted,
    totalDays,
    analysisCount,
  );

  /// Create a copy of WeeklySummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklySummaryEntityImplCopyWith<_$WeeklySummaryEntityImpl> get copyWith =>
      __$$WeeklySummaryEntityImplCopyWithImpl<_$WeeklySummaryEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklySummaryEntityImplToJson(this);
  }
}

abstract class _WeeklySummaryEntity implements WeeklySummaryEntity {
  const factory _WeeklySummaryEntity({
    final int morningCompleted,
    final int eveningCompleted,
    final int totalDays,
    final int analysisCount,
  }) = _$WeeklySummaryEntityImpl;

  factory _WeeklySummaryEntity.fromJson(Map<String, dynamic> json) =
      _$WeeklySummaryEntityImpl.fromJson;

  @override
  int get morningCompleted;
  @override
  int get eveningCompleted;
  @override
  int get totalDays;
  @override
  int get analysisCount;

  /// Create a copy of WeeklySummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklySummaryEntityImplCopyWith<_$WeeklySummaryEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
