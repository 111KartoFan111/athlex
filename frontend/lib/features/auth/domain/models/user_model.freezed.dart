// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  int get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get level => throw _privateConstructorUsedError;
  SportModel? get primarySport => throw _privateConstructorUsedError;
  String? get goal => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  String? get rankTitle => throw _privateConstructorUsedError;
  bool get isBlocked => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    int id,
    String email,
    String role,
    String? level,
    SportModel? primarySport,
    String? goal,
    int currentStreak,
    String? rankTitle,
    bool isBlocked,
  });

  $SportModelCopyWith<$Res>? get primarySport;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? level = freezed,
    Object? primarySport = freezed,
    Object? goal = freezed,
    Object? currentStreak = null,
    Object? rankTitle = freezed,
    Object? isBlocked = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            level: freezed == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as String?,
            primarySport: freezed == primarySport
                ? _value.primarySport
                : primarySport // ignore: cast_nullable_to_non_nullable
                      as SportModel?,
            goal: freezed == goal
                ? _value.goal
                : goal // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            rankTitle: freezed == rankTitle
                ? _value.rankTitle
                : rankTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            isBlocked: null == isBlocked
                ? _value.isBlocked
                : isBlocked // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SportModelCopyWith<$Res>? get primarySport {
    if (_value.primarySport == null) {
      return null;
    }

    return $SportModelCopyWith<$Res>(_value.primarySport!, (value) {
      return _then(_value.copyWith(primarySport: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String email,
    String role,
    String? level,
    SportModel? primarySport,
    String? goal,
    int currentStreak,
    String? rankTitle,
    bool isBlocked,
  });

  @override
  $SportModelCopyWith<$Res>? get primarySport;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? level = freezed,
    Object? primarySport = freezed,
    Object? goal = freezed,
    Object? currentStreak = null,
    Object? rankTitle = freezed,
    Object? isBlocked = null,
  }) {
    return _then(
      _$UserModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        level: freezed == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String?,
        primarySport: freezed == primarySport
            ? _value.primarySport
            : primarySport // ignore: cast_nullable_to_non_nullable
                  as SportModel?,
        goal: freezed == goal
            ? _value.goal
            : goal // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        rankTitle: freezed == rankTitle
            ? _value.rankTitle
            : rankTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        isBlocked: null == isBlocked
            ? _value.isBlocked
            : isBlocked // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl({
    required this.id,
    required this.email,
    required this.role,
    this.level,
    this.primarySport,
    this.goal,
    this.currentStreak = 0,
    this.rankTitle,
    this.isBlocked = false,
  });

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final int id;
  @override
  final String email;
  @override
  final String role;
  @override
  final String? level;
  @override
  final SportModel? primarySport;
  @override
  final String? goal;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  final String? rankTitle;
  @override
  @JsonKey()
  final bool isBlocked;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, role: $role, level: $level, primarySport: $primarySport, goal: $goal, currentStreak: $currentStreak, rankTitle: $rankTitle, isBlocked: $isBlocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.primarySport, primarySport) ||
                other.primarySport == primarySport) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.rankTitle, rankTitle) ||
                other.rankTitle == rankTitle) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    role,
    level,
    primarySport,
    goal,
    currentStreak,
    rankTitle,
    isBlocked,
  );

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel({
    required final int id,
    required final String email,
    required final String role,
    final String? level,
    final SportModel? primarySport,
    final String? goal,
    final int currentStreak,
    final String? rankTitle,
    final bool isBlocked,
  }) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  int get id;
  @override
  String get email;
  @override
  String get role;
  @override
  String? get level;
  @override
  SportModel? get primarySport;
  @override
  String? get goal;
  @override
  int get currentStreak;
  @override
  String? get rankTitle;
  @override
  bool get isBlocked;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
