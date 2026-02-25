// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkoutLogModel _$WorkoutLogModelFromJson(Map<String, dynamic> json) {
  return _WorkoutLogModel.fromJson(json);
}

/// @nodoc
mixin _$WorkoutLogModel {
  int get id => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;
  WorkoutModel get workout => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  int get caloriesBurned => throw _privateConstructorUsedError;
  int? get performanceScore => throw _privateConstructorUsedError;

  /// Serializes this WorkoutLogModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutLogModelCopyWith<WorkoutLogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutLogModelCopyWith<$Res> {
  factory $WorkoutLogModelCopyWith(
    WorkoutLogModel value,
    $Res Function(WorkoutLogModel) then,
  ) = _$WorkoutLogModelCopyWithImpl<$Res, WorkoutLogModel>;
  @useResult
  $Res call({
    int id,
    UserModel user,
    WorkoutModel workout,
    DateTime date,
    int duration,
    int caloriesBurned,
    int? performanceScore,
  });

  $UserModelCopyWith<$Res> get user;
  $WorkoutModelCopyWith<$Res> get workout;
}

/// @nodoc
class _$WorkoutLogModelCopyWithImpl<$Res, $Val extends WorkoutLogModel>
    implements $WorkoutLogModelCopyWith<$Res> {
  _$WorkoutLogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user = null,
    Object? workout = null,
    Object? date = null,
    Object? duration = null,
    Object? caloriesBurned = null,
    Object? performanceScore = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as UserModel,
            workout: null == workout
                ? _value.workout
                : workout // ignore: cast_nullable_to_non_nullable
                      as WorkoutModel,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int,
            caloriesBurned: null == caloriesBurned
                ? _value.caloriesBurned
                : caloriesBurned // ignore: cast_nullable_to_non_nullable
                      as int,
            performanceScore: freezed == performanceScore
                ? _value.performanceScore
                : performanceScore // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of WorkoutLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of WorkoutLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutModelCopyWith<$Res> get workout {
    return $WorkoutModelCopyWith<$Res>(_value.workout, (value) {
      return _then(_value.copyWith(workout: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkoutLogModelImplCopyWith<$Res>
    implements $WorkoutLogModelCopyWith<$Res> {
  factory _$$WorkoutLogModelImplCopyWith(
    _$WorkoutLogModelImpl value,
    $Res Function(_$WorkoutLogModelImpl) then,
  ) = __$$WorkoutLogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    UserModel user,
    WorkoutModel workout,
    DateTime date,
    int duration,
    int caloriesBurned,
    int? performanceScore,
  });

  @override
  $UserModelCopyWith<$Res> get user;
  @override
  $WorkoutModelCopyWith<$Res> get workout;
}

/// @nodoc
class __$$WorkoutLogModelImplCopyWithImpl<$Res>
    extends _$WorkoutLogModelCopyWithImpl<$Res, _$WorkoutLogModelImpl>
    implements _$$WorkoutLogModelImplCopyWith<$Res> {
  __$$WorkoutLogModelImplCopyWithImpl(
    _$WorkoutLogModelImpl _value,
    $Res Function(_$WorkoutLogModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user = null,
    Object? workout = null,
    Object? date = null,
    Object? duration = null,
    Object? caloriesBurned = null,
    Object? performanceScore = freezed,
  }) {
    return _then(
      _$WorkoutLogModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as UserModel,
        workout: null == workout
            ? _value.workout
            : workout // ignore: cast_nullable_to_non_nullable
                  as WorkoutModel,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
        caloriesBurned: null == caloriesBurned
            ? _value.caloriesBurned
            : caloriesBurned // ignore: cast_nullable_to_non_nullable
                  as int,
        performanceScore: freezed == performanceScore
            ? _value.performanceScore
            : performanceScore // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutLogModelImpl implements _WorkoutLogModel {
  const _$WorkoutLogModelImpl({
    required this.id,
    required this.user,
    required this.workout,
    required this.date,
    required this.duration,
    required this.caloriesBurned,
    this.performanceScore,
  });

  factory _$WorkoutLogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutLogModelImplFromJson(json);

  @override
  final int id;
  @override
  final UserModel user;
  @override
  final WorkoutModel workout;
  @override
  final DateTime date;
  @override
  final int duration;
  @override
  final int caloriesBurned;
  @override
  final int? performanceScore;

  @override
  String toString() {
    return 'WorkoutLogModel(id: $id, user: $user, workout: $workout, date: $date, duration: $duration, caloriesBurned: $caloriesBurned, performanceScore: $performanceScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutLogModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.workout, workout) || other.workout == workout) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.caloriesBurned, caloriesBurned) ||
                other.caloriesBurned == caloriesBurned) &&
            (identical(other.performanceScore, performanceScore) ||
                other.performanceScore == performanceScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    user,
    workout,
    date,
    duration,
    caloriesBurned,
    performanceScore,
  );

  /// Create a copy of WorkoutLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutLogModelImplCopyWith<_$WorkoutLogModelImpl> get copyWith =>
      __$$WorkoutLogModelImplCopyWithImpl<_$WorkoutLogModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutLogModelImplToJson(this);
  }
}

abstract class _WorkoutLogModel implements WorkoutLogModel {
  const factory _WorkoutLogModel({
    required final int id,
    required final UserModel user,
    required final WorkoutModel workout,
    required final DateTime date,
    required final int duration,
    required final int caloriesBurned,
    final int? performanceScore,
  }) = _$WorkoutLogModelImpl;

  factory _WorkoutLogModel.fromJson(Map<String, dynamic> json) =
      _$WorkoutLogModelImpl.fromJson;

  @override
  int get id;
  @override
  UserModel get user;
  @override
  WorkoutModel get workout;
  @override
  DateTime get date;
  @override
  int get duration;
  @override
  int get caloriesBurned;
  @override
  int? get performanceScore;

  /// Create a copy of WorkoutLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutLogModelImplCopyWith<_$WorkoutLogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
