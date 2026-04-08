// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SubscriptionEntity _$SubscriptionEntityFromJson(Map<String, dynamic> json) {
  return _SubscriptionEntity.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionEntity {
  String get tier => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  bool get hasProEntitlement => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionEntityCopyWith<SubscriptionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionEntityCopyWith<$Res> {
  factory $SubscriptionEntityCopyWith(
    SubscriptionEntity value,
    $Res Function(SubscriptionEntity) then,
  ) = _$SubscriptionEntityCopyWithImpl<$Res, SubscriptionEntity>;
  @useResult
  $Res call({
    String tier,
    bool isActive,
    DateTime? expiresAt,
    bool hasProEntitlement,
  });
}

/// @nodoc
class _$SubscriptionEntityCopyWithImpl<$Res, $Val extends SubscriptionEntity>
    implements $SubscriptionEntityCopyWith<$Res> {
  _$SubscriptionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tier = null,
    Object? isActive = null,
    Object? expiresAt = freezed,
    Object? hasProEntitlement = null,
  }) {
    return _then(
      _value.copyWith(
            tier: null == tier
                ? _value.tier
                : tier // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            hasProEntitlement: null == hasProEntitlement
                ? _value.hasProEntitlement
                : hasProEntitlement // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionEntityImplCopyWith<$Res>
    implements $SubscriptionEntityCopyWith<$Res> {
  factory _$$SubscriptionEntityImplCopyWith(
    _$SubscriptionEntityImpl value,
    $Res Function(_$SubscriptionEntityImpl) then,
  ) = __$$SubscriptionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String tier,
    bool isActive,
    DateTime? expiresAt,
    bool hasProEntitlement,
  });
}

/// @nodoc
class __$$SubscriptionEntityImplCopyWithImpl<$Res>
    extends _$SubscriptionEntityCopyWithImpl<$Res, _$SubscriptionEntityImpl>
    implements _$$SubscriptionEntityImplCopyWith<$Res> {
  __$$SubscriptionEntityImplCopyWithImpl(
    _$SubscriptionEntityImpl _value,
    $Res Function(_$SubscriptionEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tier = null,
    Object? isActive = null,
    Object? expiresAt = freezed,
    Object? hasProEntitlement = null,
  }) {
    return _then(
      _$SubscriptionEntityImpl(
        tier: null == tier
            ? _value.tier
            : tier // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        hasProEntitlement: null == hasProEntitlement
            ? _value.hasProEntitlement
            : hasProEntitlement // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionEntityImpl implements _SubscriptionEntity {
  const _$SubscriptionEntityImpl({
    this.tier = 'free',
    this.isActive = false,
    this.expiresAt,
    this.hasProEntitlement = false,
  });

  factory _$SubscriptionEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionEntityImplFromJson(json);

  @override
  @JsonKey()
  final String tier;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? expiresAt;
  @override
  @JsonKey()
  final bool hasProEntitlement;

  @override
  String toString() {
    return 'SubscriptionEntity(tier: $tier, isActive: $isActive, expiresAt: $expiresAt, hasProEntitlement: $hasProEntitlement)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionEntityImpl &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.hasProEntitlement, hasProEntitlement) ||
                other.hasProEntitlement == hasProEntitlement));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tier, isActive, expiresAt, hasProEntitlement);

  /// Create a copy of SubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionEntityImplCopyWith<_$SubscriptionEntityImpl> get copyWith =>
      __$$SubscriptionEntityImplCopyWithImpl<_$SubscriptionEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionEntityImplToJson(this);
  }
}

abstract class _SubscriptionEntity implements SubscriptionEntity {
  const factory _SubscriptionEntity({
    final String tier,
    final bool isActive,
    final DateTime? expiresAt,
    final bool hasProEntitlement,
  }) = _$SubscriptionEntityImpl;

  factory _SubscriptionEntity.fromJson(Map<String, dynamic> json) =
      _$SubscriptionEntityImpl.fromJson;

  @override
  String get tier;
  @override
  bool get isActive;
  @override
  DateTime? get expiresAt;
  @override
  bool get hasProEntitlement;

  /// Create a copy of SubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionEntityImplCopyWith<_$SubscriptionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
