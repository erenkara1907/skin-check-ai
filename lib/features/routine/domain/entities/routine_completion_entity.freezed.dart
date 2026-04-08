// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_completion_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RoutineCompletionEntity _$RoutineCompletionEntityFromJson(
  Map<String, dynamic> json,
) {
  return _RoutineCompletionEntity.fromJson(json);
}

/// @nodoc
mixin _$RoutineCompletionEntity {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'routine_id')
  String get routineId => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  DateTime get completedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_steps')
  List<String> get completedSteps => throw _privateConstructorUsedError;

  /// Serializes this RoutineCompletionEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoutineCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoutineCompletionEntityCopyWith<RoutineCompletionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutineCompletionEntityCopyWith<$Res> {
  factory $RoutineCompletionEntityCopyWith(
    RoutineCompletionEntity value,
    $Res Function(RoutineCompletionEntity) then,
  ) = _$RoutineCompletionEntityCopyWithImpl<$Res, RoutineCompletionEntity>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'routine_id') String routineId,
    @JsonKey(name: 'completed_at') DateTime completedAt,
    @JsonKey(name: 'completed_steps') List<String> completedSteps,
  });
}

/// @nodoc
class _$RoutineCompletionEntityCopyWithImpl<
  $Res,
  $Val extends RoutineCompletionEntity
>
    implements $RoutineCompletionEntityCopyWith<$Res> {
  _$RoutineCompletionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoutineCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? routineId = null,
    Object? completedAt = null,
    Object? completedSteps = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            routineId: null == routineId
                ? _value.routineId
                : routineId // ignore: cast_nullable_to_non_nullable
                      as String,
            completedAt: null == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedSteps: null == completedSteps
                ? _value.completedSteps
                : completedSteps // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoutineCompletionEntityImplCopyWith<$Res>
    implements $RoutineCompletionEntityCopyWith<$Res> {
  factory _$$RoutineCompletionEntityImplCopyWith(
    _$RoutineCompletionEntityImpl value,
    $Res Function(_$RoutineCompletionEntityImpl) then,
  ) = __$$RoutineCompletionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'routine_id') String routineId,
    @JsonKey(name: 'completed_at') DateTime completedAt,
    @JsonKey(name: 'completed_steps') List<String> completedSteps,
  });
}

/// @nodoc
class __$$RoutineCompletionEntityImplCopyWithImpl<$Res>
    extends
        _$RoutineCompletionEntityCopyWithImpl<
          $Res,
          _$RoutineCompletionEntityImpl
        >
    implements _$$RoutineCompletionEntityImplCopyWith<$Res> {
  __$$RoutineCompletionEntityImplCopyWithImpl(
    _$RoutineCompletionEntityImpl _value,
    $Res Function(_$RoutineCompletionEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoutineCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? routineId = null,
    Object? completedAt = null,
    Object? completedSteps = null,
  }) {
    return _then(
      _$RoutineCompletionEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        routineId: null == routineId
            ? _value.routineId
            : routineId // ignore: cast_nullable_to_non_nullable
                  as String,
        completedAt: null == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedSteps: null == completedSteps
            ? _value._completedSteps
            : completedSteps // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutineCompletionEntityImpl implements _RoutineCompletionEntity {
  const _$RoutineCompletionEntityImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'routine_id') required this.routineId,
    @JsonKey(name: 'completed_at') required this.completedAt,
    @JsonKey(name: 'completed_steps')
    final List<String> completedSteps = const [],
  }) : _completedSteps = completedSteps;

  factory _$RoutineCompletionEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoutineCompletionEntityImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'routine_id')
  final String routineId;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime completedAt;
  final List<String> _completedSteps;
  @override
  @JsonKey(name: 'completed_steps')
  List<String> get completedSteps {
    if (_completedSteps is EqualUnmodifiableListView) return _completedSteps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedSteps);
  }

  @override
  String toString() {
    return 'RoutineCompletionEntity(id: $id, userId: $userId, routineId: $routineId, completedAt: $completedAt, completedSteps: $completedSteps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineCompletionEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.routineId, routineId) ||
                other.routineId == routineId) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality().equals(
              other._completedSteps,
              _completedSteps,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    routineId,
    completedAt,
    const DeepCollectionEquality().hash(_completedSteps),
  );

  /// Create a copy of RoutineCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineCompletionEntityImplCopyWith<_$RoutineCompletionEntityImpl>
  get copyWith =>
      __$$RoutineCompletionEntityImplCopyWithImpl<
        _$RoutineCompletionEntityImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutineCompletionEntityImplToJson(this);
  }
}

abstract class _RoutineCompletionEntity implements RoutineCompletionEntity {
  const factory _RoutineCompletionEntity({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'routine_id') required final String routineId,
    @JsonKey(name: 'completed_at') required final DateTime completedAt,
    @JsonKey(name: 'completed_steps') final List<String> completedSteps,
  }) = _$RoutineCompletionEntityImpl;

  factory _RoutineCompletionEntity.fromJson(Map<String, dynamic> json) =
      _$RoutineCompletionEntityImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'routine_id')
  String get routineId;
  @override
  @JsonKey(name: 'completed_at')
  DateTime get completedAt;
  @override
  @JsonKey(name: 'completed_steps')
  List<String> get completedSteps;

  /// Create a copy of RoutineCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutineCompletionEntityImplCopyWith<_$RoutineCompletionEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
