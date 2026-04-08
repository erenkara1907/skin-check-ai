// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_step_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RoutineStepEntity _$RoutineStepEntityFromJson(Map<String, dynamic> json) {
  return _RoutineStepEntity.fromJson(json);
}

/// @nodoc
mixin _$RoutineStepEntity {
  String get step => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_type')
  String get productType => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  /// Serializes this RoutineStepEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoutineStepEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoutineStepEntityCopyWith<RoutineStepEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutineStepEntityCopyWith<$Res> {
  factory $RoutineStepEntityCopyWith(
    RoutineStepEntity value,
    $Res Function(RoutineStepEntity) then,
  ) = _$RoutineStepEntityCopyWithImpl<$Res, RoutineStepEntity>;
  @useResult
  $Res call({
    String step,
    @JsonKey(name: 'product_type') String productType,
    String reason,
  });
}

/// @nodoc
class _$RoutineStepEntityCopyWithImpl<$Res, $Val extends RoutineStepEntity>
    implements $RoutineStepEntityCopyWith<$Res> {
  _$RoutineStepEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoutineStepEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? productType = null,
    Object? reason = null,
  }) {
    return _then(
      _value.copyWith(
            step: null == step
                ? _value.step
                : step // ignore: cast_nullable_to_non_nullable
                      as String,
            productType: null == productType
                ? _value.productType
                : productType // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoutineStepEntityImplCopyWith<$Res>
    implements $RoutineStepEntityCopyWith<$Res> {
  factory _$$RoutineStepEntityImplCopyWith(
    _$RoutineStepEntityImpl value,
    $Res Function(_$RoutineStepEntityImpl) then,
  ) = __$$RoutineStepEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String step,
    @JsonKey(name: 'product_type') String productType,
    String reason,
  });
}

/// @nodoc
class __$$RoutineStepEntityImplCopyWithImpl<$Res>
    extends _$RoutineStepEntityCopyWithImpl<$Res, _$RoutineStepEntityImpl>
    implements _$$RoutineStepEntityImplCopyWith<$Res> {
  __$$RoutineStepEntityImplCopyWithImpl(
    _$RoutineStepEntityImpl _value,
    $Res Function(_$RoutineStepEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoutineStepEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? productType = null,
    Object? reason = null,
  }) {
    return _then(
      _$RoutineStepEntityImpl(
        step: null == step
            ? _value.step
            : step // ignore: cast_nullable_to_non_nullable
                  as String,
        productType: null == productType
            ? _value.productType
            : productType // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutineStepEntityImpl implements _RoutineStepEntity {
  const _$RoutineStepEntityImpl({
    required this.step,
    @JsonKey(name: 'product_type') required this.productType,
    required this.reason,
  });

  factory _$RoutineStepEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoutineStepEntityImplFromJson(json);

  @override
  final String step;
  @override
  @JsonKey(name: 'product_type')
  final String productType;
  @override
  final String reason;

  @override
  String toString() {
    return 'RoutineStepEntity(step: $step, productType: $productType, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineStepEntityImpl &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.productType, productType) ||
                other.productType == productType) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, step, productType, reason);

  /// Create a copy of RoutineStepEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineStepEntityImplCopyWith<_$RoutineStepEntityImpl> get copyWith =>
      __$$RoutineStepEntityImplCopyWithImpl<_$RoutineStepEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutineStepEntityImplToJson(this);
  }
}

abstract class _RoutineStepEntity implements RoutineStepEntity {
  const factory _RoutineStepEntity({
    required final String step,
    @JsonKey(name: 'product_type') required final String productType,
    required final String reason,
  }) = _$RoutineStepEntityImpl;

  factory _RoutineStepEntity.fromJson(Map<String, dynamic> json) =
      _$RoutineStepEntityImpl.fromJson;

  @override
  String get step;
  @override
  @JsonKey(name: 'product_type')
  String get productType;
  @override
  String get reason;

  /// Create a copy of RoutineStepEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutineStepEntityImplCopyWith<_$RoutineStepEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
