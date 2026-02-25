// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sport_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SportModel _$SportModelFromJson(Map<String, dynamic> json) {
  return _SportModel.fromJson(json);
}

/// @nodoc
mixin _$SportModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;

  /// Serializes this SportModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SportModelCopyWith<SportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SportModelCopyWith<$Res> {
  factory $SportModelCopyWith(
    SportModel value,
    $Res Function(SportModel) then,
  ) = _$SportModelCopyWithImpl<$Res, SportModel>;
  @useResult
  $Res call({int id, String name, String category, String? iconUrl});
}

/// @nodoc
class _$SportModelCopyWithImpl<$Res, $Val extends SportModel>
    implements $SportModelCopyWith<$Res> {
  _$SportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? iconUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SportModelImplCopyWith<$Res>
    implements $SportModelCopyWith<$Res> {
  factory _$$SportModelImplCopyWith(
    _$SportModelImpl value,
    $Res Function(_$SportModelImpl) then,
  ) = __$$SportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String category, String? iconUrl});
}

/// @nodoc
class __$$SportModelImplCopyWithImpl<$Res>
    extends _$SportModelCopyWithImpl<$Res, _$SportModelImpl>
    implements _$$SportModelImplCopyWith<$Res> {
  __$$SportModelImplCopyWithImpl(
    _$SportModelImpl _value,
    $Res Function(_$SportModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? iconUrl = freezed,
  }) {
    return _then(
      _$SportModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SportModelImpl implements _SportModel {
  const _$SportModelImpl({
    required this.id,
    required this.name,
    required this.category,
    this.iconUrl,
  });

  factory _$SportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SportModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String category;
  @override
  final String? iconUrl;

  @override
  String toString() {
    return 'SportModel(id: $id, name: $name, category: $category, iconUrl: $iconUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SportModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, category, iconUrl);

  /// Create a copy of SportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SportModelImplCopyWith<_$SportModelImpl> get copyWith =>
      __$$SportModelImplCopyWithImpl<_$SportModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SportModelImplToJson(this);
  }
}

abstract class _SportModel implements SportModel {
  const factory _SportModel({
    required final int id,
    required final String name,
    required final String category,
    final String? iconUrl,
  }) = _$SportModelImpl;

  factory _SportModel.fromJson(Map<String, dynamic> json) =
      _$SportModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get category;
  @override
  String? get iconUrl;

  /// Create a copy of SportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SportModelImplCopyWith<_$SportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
