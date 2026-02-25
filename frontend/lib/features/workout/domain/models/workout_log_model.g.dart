// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutLogModelImpl _$$WorkoutLogModelImplFromJson(
  Map<String, dynamic> json,
) => _$WorkoutLogModelImpl(
  id: (json['id'] as num).toInt(),
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  workout: WorkoutModel.fromJson(json['workout'] as Map<String, dynamic>),
  date: DateTime.parse(json['date'] as String),
  duration: (json['duration'] as num).toInt(),
  caloriesBurned: (json['caloriesBurned'] as num).toInt(),
  performanceScore: (json['performanceScore'] as num?)?.toInt(),
);

Map<String, dynamic> _$$WorkoutLogModelImplToJson(
  _$WorkoutLogModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user,
  'workout': instance.workout,
  'date': instance.date.toIso8601String(),
  'duration': instance.duration,
  'caloriesBurned': instance.caloriesBurned,
  'performanceScore': instance.performanceScore,
};
