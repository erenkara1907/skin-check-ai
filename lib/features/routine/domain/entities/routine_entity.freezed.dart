// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RoutineEntity _$RoutineEntityFromJson(Map<String, dynamic> json) {
  return _RoutineEntity.fromJson(json);
}

/// @nodoc
mixin _$RoutineEntity {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  List<RoutineStepDetailEntity> get steps => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this RoutineEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoutineEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoutineEntityCopyWith<RoutineEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutineEntityCopyWith<$Res> {
  factory $RoutineEntityCopyWith(
    RoutineEntity value,
    $Res Function(RoutineEntity) then,
  ) = _$RoutineEntityCopyWithImpl<$Res, RoutineEntity>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    String type,
    List<RoutineStepDetailEntity> steps,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class _$RoutineEntityCopyWithImpl<$Res, $Val extends RoutineEntity>
    implements $RoutineEntityCopyWith<$Res> {
  _$RoutineEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoutineEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? steps = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            steps: null == steps
                ? _value.steps
                : steps // ignore: cast_nullable_to_non_nullable
                      as List<RoutineStepDetailEntity>,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoutineEntityImplCopyWith<$Res>
    implements $RoutineEntityCopyWith<$Res> {
  factory _$$RoutineEntityImplCopyWith(
    _$RoutineEntityImpl value,
    $Res Function(_$RoutineEntityImpl) then,
  ) = __$$RoutineEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    String type,
    List<RoutineStepDetailEntity> steps,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class __$$RoutineEntityImplCopyWithImpl<$Res>
    extends _$RoutineEntityCopyWithImpl<$Res, _$RoutineEntityImpl>
    implements _$$RoutineEntityImplCopyWith<$Res> {
  __$$RoutineEntityImplCopyWithImpl(
    _$RoutineEntityImpl _value,
    $Res Function(_$RoutineEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoutineEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? steps = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$RoutineEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        steps: null == steps
            ? _value._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<RoutineStepDetailEntity>,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutineEntityImpl implements _RoutineEntity {
  const _$RoutineEntityImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    required this.type,
    final List<RoutineStepDetailEntity> steps = const [],
    @JsonKey(name: 'is_active') this.isActive = true,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  }) : _steps = steps;

  factory _$RoutineEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoutineEntityImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String type;
  final List<RoutineStepDetailEntity> _steps;
  @override
  @JsonKey()
  List<RoutineStepDetailEntity> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'RoutineEntity(id: $id, userId: $userId, type: $type, steps: $steps, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    type,
    const DeepCollectionEquality().hash(_steps),
    isActive,
    createdAt,
    updatedAt,
  );

  /// Create a copy of RoutineEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineEntityImplCopyWith<_$RoutineEntityImpl> get copyWith =>
      __$$RoutineEntityImplCopyWithImpl<_$RoutineEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutineEntityImplToJson(this);
  }
}

abstract class _RoutineEntity implements RoutineEntity {
  const factory _RoutineEntity({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    required final String type,
    final List<RoutineStepDetailEntity> steps,
    @JsonKey(name: 'is_active') final bool isActive,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$RoutineEntityImpl;

  factory _RoutineEntity.fromJson(Map<String, dynamic> json) =
      _$RoutineEntityImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get type;
  @override
  List<RoutineStepDetailEntity> get steps;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of RoutineEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutineEntityImplCopyWith<_$RoutineEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
