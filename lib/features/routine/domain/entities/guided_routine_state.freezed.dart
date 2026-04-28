// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guided_routine_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GuidedRoutineState {
  List<RoutineStepDetailEntity> get steps => throw _privateConstructorUsedError;
  int get currentStepIndex => throw _privateConstructorUsedError;
  bool get isTimerRunning => throw _privateConstructorUsedError;
  int get elapsedSeconds => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  /// Create a copy of GuidedRoutineState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GuidedRoutineStateCopyWith<GuidedRoutineState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuidedRoutineStateCopyWith<$Res> {
  factory $GuidedRoutineStateCopyWith(
    GuidedRoutineState value,
    $Res Function(GuidedRoutineState) then,
  ) = _$GuidedRoutineStateCopyWithImpl<$Res, GuidedRoutineState>;
  @useResult
  $Res call({
    List<RoutineStepDetailEntity> steps,
    int currentStepIndex,
    bool isTimerRunning,
    int elapsedSeconds,
    bool isCompleted,
  });
}

/// @nodoc
class _$GuidedRoutineStateCopyWithImpl<$Res, $Val extends GuidedRoutineState>
    implements $GuidedRoutineStateCopyWith<$Res> {
  _$GuidedRoutineStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GuidedRoutineState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steps = null,
    Object? currentStepIndex = null,
    Object? isTimerRunning = null,
    Object? elapsedSeconds = null,
    Object? isCompleted = null,
  }) {
    return _then(
      _value.copyWith(
            steps: null == steps
                ? _value.steps
                : steps // ignore: cast_nullable_to_non_nullable
                      as List<RoutineStepDetailEntity>,
            currentStepIndex: null == currentStepIndex
                ? _value.currentStepIndex
                : currentStepIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            isTimerRunning: null == isTimerRunning
                ? _value.isTimerRunning
                : isTimerRunning // ignore: cast_nullable_to_non_nullable
                      as bool,
            elapsedSeconds: null == elapsedSeconds
                ? _value.elapsedSeconds
                : elapsedSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GuidedRoutineStateImplCopyWith<$Res>
    implements $GuidedRoutineStateCopyWith<$Res> {
  factory _$$GuidedRoutineStateImplCopyWith(
    _$GuidedRoutineStateImpl value,
    $Res Function(_$GuidedRoutineStateImpl) then,
  ) = __$$GuidedRoutineStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<RoutineStepDetailEntity> steps,
    int currentStepIndex,
    bool isTimerRunning,
    int elapsedSeconds,
    bool isCompleted,
  });
}

/// @nodoc
class __$$GuidedRoutineStateImplCopyWithImpl<$Res>
    extends _$GuidedRoutineStateCopyWithImpl<$Res, _$GuidedRoutineStateImpl>
    implements _$$GuidedRoutineStateImplCopyWith<$Res> {
  __$$GuidedRoutineStateImplCopyWithImpl(
    _$GuidedRoutineStateImpl _value,
    $Res Function(_$GuidedRoutineStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GuidedRoutineState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steps = null,
    Object? currentStepIndex = null,
    Object? isTimerRunning = null,
    Object? elapsedSeconds = null,
    Object? isCompleted = null,
  }) {
    return _then(
      _$GuidedRoutineStateImpl(
        steps: null == steps
            ? _value._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<RoutineStepDetailEntity>,
        currentStepIndex: null == currentStepIndex
            ? _value.currentStepIndex
            : currentStepIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        isTimerRunning: null == isTimerRunning
            ? _value.isTimerRunning
            : isTimerRunning // ignore: cast_nullable_to_non_nullable
                  as bool,
        elapsedSeconds: null == elapsedSeconds
            ? _value.elapsedSeconds
            : elapsedSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$GuidedRoutineStateImpl extends _GuidedRoutineState {
  const _$GuidedRoutineStateImpl({
    required final List<RoutineStepDetailEntity> steps,
    this.currentStepIndex = 0,
    this.isTimerRunning = false,
    this.elapsedSeconds = 0,
    this.isCompleted = false,
  }) : _steps = steps,
       super._();

  final List<RoutineStepDetailEntity> _steps;
  @override
  List<RoutineStepDetailEntity> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  @JsonKey()
  final int currentStepIndex;
  @override
  @JsonKey()
  final bool isTimerRunning;
  @override
  @JsonKey()
  final int elapsedSeconds;
  @override
  @JsonKey()
  final bool isCompleted;

  @override
  String toString() {
    return 'GuidedRoutineState(steps: $steps, currentStepIndex: $currentStepIndex, isTimerRunning: $isTimerRunning, elapsedSeconds: $elapsedSeconds, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuidedRoutineStateImpl &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.currentStepIndex, currentStepIndex) ||
                other.currentStepIndex == currentStepIndex) &&
            (identical(other.isTimerRunning, isTimerRunning) ||
                other.isTimerRunning == isTimerRunning) &&
            (identical(other.elapsedSeconds, elapsedSeconds) ||
                other.elapsedSeconds == elapsedSeconds) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_steps),
    currentStepIndex,
    isTimerRunning,
    elapsedSeconds,
    isCompleted,
  );

  /// Create a copy of GuidedRoutineState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuidedRoutineStateImplCopyWith<_$GuidedRoutineStateImpl> get copyWith =>
      __$$GuidedRoutineStateImplCopyWithImpl<_$GuidedRoutineStateImpl>(
        this,
        _$identity,
      );
}

abstract class _GuidedRoutineState extends GuidedRoutineState {
  const factory _GuidedRoutineState({
    required final List<RoutineStepDetailEntity> steps,
    final int currentStepIndex,
    final bool isTimerRunning,
    final int elapsedSeconds,
    final bool isCompleted,
  }) = _$GuidedRoutineStateImpl;
  const _GuidedRoutineState._() : super._();

  @override
  List<RoutineStepDetailEntity> get steps;
  @override
  int get currentStepIndex;
  @override
  bool get isTimerRunning;
  @override
  int get elapsedSeconds;
  @override
  bool get isCompleted;

  /// Create a copy of GuidedRoutineState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuidedRoutineStateImplCopyWith<_$GuidedRoutineStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
