// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BadgeEntity _$BadgeEntityFromJson(Map<String, dynamic> json) {
  return _BadgeEntity.fromJson(json);
}

/// @nodoc
mixin _$BadgeEntity {
  String get id => throw _privateConstructorUsedError;
  String get titleKey => throw _privateConstructorUsedError;
  String get descriptionKey => throw _privateConstructorUsedError;
  String get iconName => throw _privateConstructorUsedError;
  DateTime? get unlockedAt => throw _privateConstructorUsedError;

  /// Serializes this BadgeEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BadgeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BadgeEntityCopyWith<BadgeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeEntityCopyWith<$Res> {
  factory $BadgeEntityCopyWith(
    BadgeEntity value,
    $Res Function(BadgeEntity) then,
  ) = _$BadgeEntityCopyWithImpl<$Res, BadgeEntity>;
  @useResult
  $Res call({
    String id,
    String titleKey,
    String descriptionKey,
    String iconName,
    DateTime? unlockedAt,
  });
}

/// @nodoc
class _$BadgeEntityCopyWithImpl<$Res, $Val extends BadgeEntity>
    implements $BadgeEntityCopyWith<$Res> {
  _$BadgeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BadgeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titleKey = null,
    Object? descriptionKey = null,
    Object? iconName = null,
    Object? unlockedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            titleKey: null == titleKey
                ? _value.titleKey
                : titleKey // ignore: cast_nullable_to_non_nullable
                      as String,
            descriptionKey: null == descriptionKey
                ? _value.descriptionKey
                : descriptionKey // ignore: cast_nullable_to_non_nullable
                      as String,
            iconName: null == iconName
                ? _value.iconName
                : iconName // ignore: cast_nullable_to_non_nullable
                      as String,
            unlockedAt: freezed == unlockedAt
                ? _value.unlockedAt
                : unlockedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BadgeEntityImplCopyWith<$Res>
    implements $BadgeEntityCopyWith<$Res> {
  factory _$$BadgeEntityImplCopyWith(
    _$BadgeEntityImpl value,
    $Res Function(_$BadgeEntityImpl) then,
  ) = __$$BadgeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String titleKey,
    String descriptionKey,
    String iconName,
    DateTime? unlockedAt,
  });
}

/// @nodoc
class __$$BadgeEntityImplCopyWithImpl<$Res>
    extends _$BadgeEntityCopyWithImpl<$Res, _$BadgeEntityImpl>
    implements _$$BadgeEntityImplCopyWith<$Res> {
  __$$BadgeEntityImplCopyWithImpl(
    _$BadgeEntityImpl _value,
    $Res Function(_$BadgeEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BadgeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titleKey = null,
    Object? descriptionKey = null,
    Object? iconName = null,
    Object? unlockedAt = freezed,
  }) {
    return _then(
      _$BadgeEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        titleKey: null == titleKey
            ? _value.titleKey
            : titleKey // ignore: cast_nullable_to_non_nullable
                  as String,
        descriptionKey: null == descriptionKey
            ? _value.descriptionKey
            : descriptionKey // ignore: cast_nullable_to_non_nullable
                  as String,
        iconName: null == iconName
            ? _value.iconName
            : iconName // ignore: cast_nullable_to_non_nullable
                  as String,
        unlockedAt: freezed == unlockedAt
            ? _value.unlockedAt
            : unlockedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BadgeEntityImpl implements _BadgeEntity {
  const _$BadgeEntityImpl({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.iconName,
    this.unlockedAt,
  });

  factory _$BadgeEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$BadgeEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String titleKey;
  @override
  final String descriptionKey;
  @override
  final String iconName;
  @override
  final DateTime? unlockedAt;

  @override
  String toString() {
    return 'BadgeEntity(id: $id, titleKey: $titleKey, descriptionKey: $descriptionKey, iconName: $iconName, unlockedAt: $unlockedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.titleKey, titleKey) ||
                other.titleKey == titleKey) &&
            (identical(other.descriptionKey, descriptionKey) ||
                other.descriptionKey == descriptionKey) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    titleKey,
    descriptionKey,
    iconName,
    unlockedAt,
  );

  /// Create a copy of BadgeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgeEntityImplCopyWith<_$BadgeEntityImpl> get copyWith =>
      __$$BadgeEntityImplCopyWithImpl<_$BadgeEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BadgeEntityImplToJson(this);
  }
}

abstract class _BadgeEntity implements BadgeEntity {
  const factory _BadgeEntity({
    required final String id,
    required final String titleKey,
    required final String descriptionKey,
    required final String iconName,
    final DateTime? unlockedAt,
  }) = _$BadgeEntityImpl;

  factory _BadgeEntity.fromJson(Map<String, dynamic> json) =
      _$BadgeEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get titleKey;
  @override
  String get descriptionKey;
  @override
  String get iconName;
  @override
  DateTime? get unlockedAt;

  /// Create a copy of BadgeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BadgeEntityImplCopyWith<_$BadgeEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
