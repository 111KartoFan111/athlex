// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkoutModel _$WorkoutModelFromJson(Map<String, dynamic> json) {
  return _WorkoutModel.fromJson(json);
}

/// @nodoc
mixin _$WorkoutModel {
  int get id => throw _privateConstructorUsedError;
  SportModel get sport => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get durationMin => throw _privateConstructorUsedError;
  int? get calories => throw _privateConstructorUsedError;
  String? get level => throw _privateConstructorUsedError;
  String? get equipmentNeeded => throw _privateConstructorUsedError;
  bool get isAiGenerated => throw _privateConstructorUsedError;
  List<ExerciseModel> get exercises => throw _privateConstructorUsedError;

  /// Serializes this WorkoutModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutModelCopyWith<WorkoutModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutModelCopyWith<$Res> {
  factory $WorkoutModelCopyWith(
    WorkoutModel value,
    $Res Function(WorkoutModel) then,
  ) = _$WorkoutModelCopyWithImpl<$Res, WorkoutModel>;
  @useResult
  $Res call({
    int id,
    SportModel sport,
    String title,
    int durationMin,
    int? calories,
    String? level,
    String? equipmentNeeded,
    bool isAiGenerated,
    List<ExerciseModel> exercises,
  });

  $SportModelCopyWith<$Res> get sport;
}

/// @nodoc
class _$WorkoutModelCopyWithImpl<$Res, $Val extends WorkoutModel>
    implements $WorkoutModelCopyWith<$Res> {
  _$WorkoutModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sport = null,
    Object? title = null,
    Object? durationMin = null,
    Object? calories = freezed,
    Object? level = freezed,
    Object? equipmentNeeded = freezed,
    Object? isAiGenerated = null,
    Object? exercises = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            sport: null == sport
                ? _value.sport
                : sport // ignore: cast_nullable_to_non_nullable
                      as SportModel,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            durationMin: null == durationMin
                ? _value.durationMin
                : durationMin // ignore: cast_nullable_to_non_nullable
                      as int,
            calories: freezed == calories
                ? _value.calories
                : calories // ignore: cast_nullable_to_non_nullable
                      as int?,
            level: freezed == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as String?,
            equipmentNeeded: freezed == equipmentNeeded
                ? _value.equipmentNeeded
                : equipmentNeeded // ignore: cast_nullable_to_non_nullable
                      as String?,
            isAiGenerated: null == isAiGenerated
                ? _value.isAiGenerated
                : isAiGenerated // ignore: cast_nullable_to_non_nullable
                      as bool,
            exercises: null == exercises
                ? _value.exercises
                : exercises // ignore: cast_nullable_to_non_nullable
                      as List<ExerciseModel>,
          )
          as $Val,
    );
  }

  /// Create a copy of WorkoutModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SportModelCopyWith<$Res> get sport {
    return $SportModelCopyWith<$Res>(_value.sport, (value) {
      return _then(_value.copyWith(sport: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkoutModelImplCopyWith<$Res>
    implements $WorkoutModelCopyWith<$Res> {
  factory _$$WorkoutModelImplCopyWith(
    _$WorkoutModelImpl value,
    $Res Function(_$WorkoutModelImpl) then,
  ) = __$$WorkoutModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    SportModel sport,
    String title,
    int durationMin,
    int? calories,
    String? level,
    String? equipmentNeeded,
    bool isAiGenerated,
    List<ExerciseModel> exercises,
  });

  @override
  $SportModelCopyWith<$Res> get sport;
}

/// @nodoc
class __$$WorkoutModelImplCopyWithImpl<$Res>
    extends _$WorkoutModelCopyWithImpl<$Res, _$WorkoutModelImpl>
    implements _$$WorkoutModelImplCopyWith<$Res> {
  __$$WorkoutModelImplCopyWithImpl(
    _$WorkoutModelImpl _value,
    $Res Function(_$WorkoutModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sport = null,
    Object? title = null,
    Object? durationMin = null,
    Object? calories = freezed,
    Object? level = freezed,
    Object? equipmentNeeded = freezed,
    Object? isAiGenerated = null,
    Object? exercises = null,
  }) {
    return _then(
      _$WorkoutModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        sport: null == sport
            ? _value.sport
            : sport // ignore: cast_nullable_to_non_nullable
                  as SportModel,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        durationMin: null == durationMin
            ? _value.durationMin
            : durationMin // ignore: cast_nullable_to_non_nullable
                  as int,
        calories: freezed == calories
            ? _value.calories
            : calories // ignore: cast_nullable_to_non_nullable
                  as int?,
        level: freezed == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String?,
        equipmentNeeded: freezed == equipmentNeeded
            ? _value.equipmentNeeded
            : equipmentNeeded // ignore: cast_nullable_to_non_nullable
                  as String?,
        isAiGenerated: null == isAiGenerated
            ? _value.isAiGenerated
            : isAiGenerated // ignore: cast_nullable_to_non_nullable
                  as bool,
        exercises: null == exercises
            ? _value._exercises
            : exercises // ignore: cast_nullable_to_non_nullable
                  as List<ExerciseModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutModelImpl implements _WorkoutModel {
  const _$WorkoutModelImpl({
    required this.id,
    required this.sport,
    required this.title,
    required this.durationMin,
    this.calories,
    this.level,
    this.equipmentNeeded,
    this.isAiGenerated = false,
    final List<ExerciseModel> exercises = const [],
  }) : _exercises = exercises;

  factory _$WorkoutModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutModelImplFromJson(json);

  @override
  final int id;
  @override
  final SportModel sport;
  @override
  final String title;
  @override
  final int durationMin;
  @override
  final int? calories;
  @override
  final String? level;
  @override
  final String? equipmentNeeded;
  @override
  @JsonKey()
  final bool isAiGenerated;
  final List<ExerciseModel> _exercises;
  @override
  @JsonKey()
  List<ExerciseModel> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  String toString() {
    return 'WorkoutModel(id: $id, sport: $sport, title: $title, durationMin: $durationMin, calories: $calories, level: $level, equipmentNeeded: $equipmentNeeded, isAiGenerated: $isAiGenerated, exercises: $exercises)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sport, sport) || other.sport == sport) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.durationMin, durationMin) ||
                other.durationMin == durationMin) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.equipmentNeeded, equipmentNeeded) ||
                other.equipmentNeeded == equipmentNeeded) &&
            (identical(other.isAiGenerated, isAiGenerated) ||
                other.isAiGenerated == isAiGenerated) &&
            const DeepCollectionEquality().equals(
              other._exercises,
              _exercises,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sport,
    title,
    durationMin,
    calories,
    level,
    equipmentNeeded,
    isAiGenerated,
    const DeepCollectionEquality().hash(_exercises),
  );

  /// Create a copy of WorkoutModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutModelImplCopyWith<_$WorkoutModelImpl> get copyWith =>
      __$$WorkoutModelImplCopyWithImpl<_$WorkoutModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutModelImplToJson(this);
  }
}

abstract class _WorkoutModel implements WorkoutModel {
  const factory _WorkoutModel({
    required final int id,
    required final SportModel sport,
    required final String title,
    required final int durationMin,
    final int? calories,
    final String? level,
    final String? equipmentNeeded,
    final bool isAiGenerated,
    final List<ExerciseModel> exercises,
  }) = _$WorkoutModelImpl;

  factory _WorkoutModel.fromJson(Map<String, dynamic> json) =
      _$WorkoutModelImpl.fromJson;

  @override
  int get id;
  @override
  SportModel get sport;
  @override
  String get title;
  @override
  int get durationMin;
  @override
  int? get calories;
  @override
  String? get level;
  @override
  String? get equipmentNeeded;
  @override
  bool get isAiGenerated;
  @override
  List<ExerciseModel> get exercises;

  /// Create a copy of WorkoutModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutModelImplCopyWith<_$WorkoutModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
