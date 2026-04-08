// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analysis_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AnalysisEntity _$AnalysisEntityFromJson(Map<String, dynamic> json) {
  return _AnalysisEntity.fromJson(json);
}

/// @nodoc
mixin _$AnalysisEntity {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_url')
  String? get photoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'overall_score')
  double get overallScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'skin_age')
  int get skinAge => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  List<ZoneScoreEntity> get zones => throw _privateConstructorUsedError;
  @JsonKey(name: 'morning_routine')
  List<RoutineStepEntity> get morningRoutine =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'evening_routine')
  List<RoutineStepEntity> get eveningRoutine =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AnalysisEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalysisEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalysisEntityCopyWith<AnalysisEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisEntityCopyWith<$Res> {
  factory $AnalysisEntityCopyWith(
    AnalysisEntity value,
    $Res Function(AnalysisEntity) then,
  ) = _$AnalysisEntityCopyWithImpl<$Res, AnalysisEntity>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'photo_url') String? photoUrl,
    @JsonKey(name: 'overall_score') double overallScore,
    @JsonKey(name: 'skin_age') int skinAge,
    String summary,
    List<ZoneScoreEntity> zones,
    @JsonKey(name: 'morning_routine') List<RoutineStepEntity> morningRoutine,
    @JsonKey(name: 'evening_routine') List<RoutineStepEntity> eveningRoutine,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$AnalysisEntityCopyWithImpl<$Res, $Val extends AnalysisEntity>
    implements $AnalysisEntityCopyWith<$Res> {
  _$AnalysisEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalysisEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? photoUrl = freezed,
    Object? overallScore = null,
    Object? skinAge = null,
    Object? summary = null,
    Object? zones = null,
    Object? morningRoutine = null,
    Object? eveningRoutine = null,
    Object? createdAt = freezed,
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
            photoUrl: freezed == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            overallScore: null == overallScore
                ? _value.overallScore
                : overallScore // ignore: cast_nullable_to_non_nullable
                      as double,
            skinAge: null == skinAge
                ? _value.skinAge
                : skinAge // ignore: cast_nullable_to_non_nullable
                      as int,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            zones: null == zones
                ? _value.zones
                : zones // ignore: cast_nullable_to_non_nullable
                      as List<ZoneScoreEntity>,
            morningRoutine: null == morningRoutine
                ? _value.morningRoutine
                : morningRoutine // ignore: cast_nullable_to_non_nullable
                      as List<RoutineStepEntity>,
            eveningRoutine: null == eveningRoutine
                ? _value.eveningRoutine
                : eveningRoutine // ignore: cast_nullable_to_non_nullable
                      as List<RoutineStepEntity>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnalysisEntityImplCopyWith<$Res>
    implements $AnalysisEntityCopyWith<$Res> {
  factory _$$AnalysisEntityImplCopyWith(
    _$AnalysisEntityImpl value,
    $Res Function(_$AnalysisEntityImpl) then,
  ) = __$$AnalysisEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'photo_url') String? photoUrl,
    @JsonKey(name: 'overall_score') double overallScore,
    @JsonKey(name: 'skin_age') int skinAge,
    String summary,
    List<ZoneScoreEntity> zones,
    @JsonKey(name: 'morning_routine') List<RoutineStepEntity> morningRoutine,
    @JsonKey(name: 'evening_routine') List<RoutineStepEntity> eveningRoutine,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$AnalysisEntityImplCopyWithImpl<$Res>
    extends _$AnalysisEntityCopyWithImpl<$Res, _$AnalysisEntityImpl>
    implements _$$AnalysisEntityImplCopyWith<$Res> {
  __$$AnalysisEntityImplCopyWithImpl(
    _$AnalysisEntityImpl _value,
    $Res Function(_$AnalysisEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalysisEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? photoUrl = freezed,
    Object? overallScore = null,
    Object? skinAge = null,
    Object? summary = null,
    Object? zones = null,
    Object? morningRoutine = null,
    Object? eveningRoutine = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$AnalysisEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        photoUrl: freezed == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        overallScore: null == overallScore
            ? _value.overallScore
            : overallScore // ignore: cast_nullable_to_non_nullable
                  as double,
        skinAge: null == skinAge
            ? _value.skinAge
            : skinAge // ignore: cast_nullable_to_non_nullable
                  as int,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        zones: null == zones
            ? _value._zones
            : zones // ignore: cast_nullable_to_non_nullable
                  as List<ZoneScoreEntity>,
        morningRoutine: null == morningRoutine
            ? _value._morningRoutine
            : morningRoutine // ignore: cast_nullable_to_non_nullable
                  as List<RoutineStepEntity>,
        eveningRoutine: null == eveningRoutine
            ? _value._eveningRoutine
            : eveningRoutine // ignore: cast_nullable_to_non_nullable
                  as List<RoutineStepEntity>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalysisEntityImpl implements _AnalysisEntity {
  const _$AnalysisEntityImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'photo_url') this.photoUrl,
    @JsonKey(name: 'overall_score') required this.overallScore,
    @JsonKey(name: 'skin_age') required this.skinAge,
    this.summary = '',
    final List<ZoneScoreEntity> zones = const [],
    @JsonKey(name: 'morning_routine')
    final List<RoutineStepEntity> morningRoutine = const [],
    @JsonKey(name: 'evening_routine')
    final List<RoutineStepEntity> eveningRoutine = const [],
    @JsonKey(name: 'created_at') this.createdAt,
  }) : _zones = zones,
       _morningRoutine = morningRoutine,
       _eveningRoutine = eveningRoutine;

  factory _$AnalysisEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalysisEntityImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  @override
  @JsonKey(name: 'overall_score')
  final double overallScore;
  @override
  @JsonKey(name: 'skin_age')
  final int skinAge;
  @override
  @JsonKey()
  final String summary;
  final List<ZoneScoreEntity> _zones;
  @override
  @JsonKey()
  List<ZoneScoreEntity> get zones {
    if (_zones is EqualUnmodifiableListView) return _zones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_zones);
  }

  final List<RoutineStepEntity> _morningRoutine;
  @override
  @JsonKey(name: 'morning_routine')
  List<RoutineStepEntity> get morningRoutine {
    if (_morningRoutine is EqualUnmodifiableListView) return _morningRoutine;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_morningRoutine);
  }

  final List<RoutineStepEntity> _eveningRoutine;
  @override
  @JsonKey(name: 'evening_routine')
  List<RoutineStepEntity> get eveningRoutine {
    if (_eveningRoutine is EqualUnmodifiableListView) return _eveningRoutine;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_eveningRoutine);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AnalysisEntity(id: $id, userId: $userId, photoUrl: $photoUrl, overallScore: $overallScore, skinAge: $skinAge, summary: $summary, zones: $zones, morningRoutine: $morningRoutine, eveningRoutine: $eveningRoutine, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalysisEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.overallScore, overallScore) ||
                other.overallScore == overallScore) &&
            (identical(other.skinAge, skinAge) || other.skinAge == skinAge) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._zones, _zones) &&
            const DeepCollectionEquality().equals(
              other._morningRoutine,
              _morningRoutine,
            ) &&
            const DeepCollectionEquality().equals(
              other._eveningRoutine,
              _eveningRoutine,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    photoUrl,
    overallScore,
    skinAge,
    summary,
    const DeepCollectionEquality().hash(_zones),
    const DeepCollectionEquality().hash(_morningRoutine),
    const DeepCollectionEquality().hash(_eveningRoutine),
    createdAt,
  );

  /// Create a copy of AnalysisEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalysisEntityImplCopyWith<_$AnalysisEntityImpl> get copyWith =>
      __$$AnalysisEntityImplCopyWithImpl<_$AnalysisEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalysisEntityImplToJson(this);
  }
}

abstract class _AnalysisEntity implements AnalysisEntity {
  const factory _AnalysisEntity({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'photo_url') final String? photoUrl,
    @JsonKey(name: 'overall_score') required final double overallScore,
    @JsonKey(name: 'skin_age') required final int skinAge,
    final String summary,
    final List<ZoneScoreEntity> zones,
    @JsonKey(name: 'morning_routine')
    final List<RoutineStepEntity> morningRoutine,
    @JsonKey(name: 'evening_routine')
    final List<RoutineStepEntity> eveningRoutine,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$AnalysisEntityImpl;

  factory _AnalysisEntity.fromJson(Map<String, dynamic> json) =
      _$AnalysisEntityImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'photo_url')
  String? get photoUrl;
  @override
  @JsonKey(name: 'overall_score')
  double get overallScore;
  @override
  @JsonKey(name: 'skin_age')
  int get skinAge;
  @override
  String get summary;
  @override
  List<ZoneScoreEntity> get zones;
  @override
  @JsonKey(name: 'morning_routine')
  List<RoutineStepEntity> get morningRoutine;
  @override
  @JsonKey(name: 'evening_routine')
  List<RoutineStepEntity> get eveningRoutine;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of AnalysisEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalysisEntityImplCopyWith<_$AnalysisEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
