// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseModelImpl _$$ExerciseModelImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      videoUrl: json['videoUrl'] as String?,
      targetMuscleGroup: json['targetMuscleGroup'] as String?,
      reps: (json['reps'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ExerciseModelImplToJson(_$ExerciseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'videoUrl': instance.videoUrl,
      'targetMuscleGroup': instance.targetMuscleGroup,
      'reps': instance.reps,
    };
