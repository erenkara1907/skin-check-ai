// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streak_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StreakEntity _$StreakEntityFromJson(Map<String, dynamic> json) {
  return _StreakEntity.fromJson(json);
}

/// @nodoc
mixin _$StreakEntity {
  @JsonKey(name: 'current_streak')
  int get currentStreak => throw _privateConstructorUsedError;
  @JsonKey(name: 'longest_streak')
  int get longestStreak => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_completed_date')
  DateTime? get lastCompletedDate => throw _privateConstructorUsedError;

  /// Serializes this StreakEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StreakEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreakEntityCopyWith<StreakEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreakEntityCopyWith<$Res> {
  factory $StreakEntityCopyWith(
    StreakEntity value,
    $Res Function(StreakEntity) then,
  ) = _$StreakEntityCopyWithImpl<$Res, StreakEntity>;
  @useResult
  $Res call({
    @JsonKey(name: 'current_streak') int currentStreak,
    @JsonKey(name: 'longest_streak') int longestStreak,
    @JsonKey(name: 'last_completed_date') DateTime? lastCompletedDate,
  });
}

/// @nodoc
class _$StreakEntityCopyWithImpl<$Res, $Val extends StreakEntity>
    implements $StreakEntityCopyWith<$Res> {
  _$StreakEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreakEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? lastCompletedDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            longestStreak: null == longestStreak
                ? _value.longestStreak
                : longestStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            lastCompletedDate: freezed == lastCompletedDate
                ? _value.lastCompletedDate
                : lastCompletedDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StreakEntityImplCopyWith<$Res>
    implements $StreakEntityCopyWith<$Res> {
  factory _$$StreakEntityImplCopyWith(
    _$StreakEntityImpl value,
    $Res Function(_$StreakEntityImpl) then,
  ) = __$$StreakEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'current_streak') int currentStreak,
    @JsonKey(name: 'longest_streak') int longestStreak,
    @JsonKey(name: 'last_completed_date') DateTime? lastCompletedDate,
  });
}

/// @nodoc
class __$$StreakEntityImplCopyWithImpl<$Res>
    extends _$StreakEntityCopyWithImpl<$Res, _$StreakEntityImpl>
    implements _$$StreakEntityImplCopyWith<$Res> {
  __$$StreakEntityImplCopyWithImpl(
    _$StreakEntityImpl _value,
    $Res Function(_$StreakEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreakEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? lastCompletedDate = freezed,
  }) {
    return _then(
      _$StreakEntityImpl(
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        longestStreak: null == longestStreak
            ? _value.longestStreak
            : longestStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        lastCompletedDate: freezed == lastCompletedDate
            ? _value.lastCompletedDate
            : lastCompletedDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StreakEntityImpl implements _StreakEntity {
  const _$StreakEntityImpl({
    @JsonKey(name: 'current_streak') this.currentStreak = 0,
    @JsonKey(name: 'longest_streak') this.longestStreak = 0,
    @JsonKey(name: 'last_completed_date') this.lastCompletedDate,
  });

  factory _$StreakEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreakEntityImplFromJson(json);

  @override
  @JsonKey(name: 'current_streak')
  final int currentStreak;
  @override
  @JsonKey(name: 'longest_streak')
  final int longestStreak;
  @override
  @JsonKey(name: 'last_completed_date')
  final DateTime? lastCompletedDate;

  @override
  String toString() {
    return 'StreakEntity(currentStreak: $currentStreak, longestStreak: $longestStreak, lastCompletedDate: $lastCompletedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreakEntityImpl &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.lastCompletedDate, lastCompletedDate) ||
                other.lastCompletedDate == lastCompletedDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentStreak, longestStreak, lastCompletedDate);

  /// Create a copy of StreakEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreakEntityImplCopyWith<_$StreakEntityImpl> get copyWith =>
      __$$StreakEntityImplCopyWithImpl<_$StreakEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StreakEntityImplToJson(this);
  }
}

abstract class _StreakEntity implements StreakEntity {
  const factory _StreakEntity({
    @JsonKey(name: 'current_streak') final int currentStreak,
    @JsonKey(name: 'longest_streak') final int longestStreak,
    @JsonKey(name: 'last_completed_date') final DateTime? lastCompletedDate,
  }) = _$StreakEntityImpl;

  factory _StreakEntity.fromJson(Map<String, dynamic> json) =
      _$StreakEntityImpl.fromJson;

  @override
  @JsonKey(name: 'current_streak')
  int get currentStreak;
  @override
  @JsonKey(name: 'longest_streak')
  int get longestStreak;
  @override
  @JsonKey(name: 'last_completed_date')
  DateTime? get lastCompletedDate;

  /// Create a copy of StreakEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreakEntityImplCopyWith<_$StreakEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
