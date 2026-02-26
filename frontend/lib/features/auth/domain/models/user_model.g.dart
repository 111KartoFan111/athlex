// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      role: json['role'] as String,
      level: json['level'] as String?,
      primarySport: json['primarySport'] == null
          ? null
          : SportModel.fromJson(json['primarySport'] as Map<String, dynamic>),
      goal: json['goal'] as String?,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      rankTitle: json['rankTitle'] as String?,
      isBlocked: json['isBlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'role': instance.role,
      'level': instance.level,
      'primarySport': instance.primarySport,
      'goal': instance.goal,
      'currentStreak': instance.currentStreak,
      'rankTitle': instance.rankTitle,
      'isBlocked': instance.isBlocked,
    };
