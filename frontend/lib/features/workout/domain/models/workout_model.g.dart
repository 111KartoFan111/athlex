// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutModelImpl _$$WorkoutModelImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutModelImpl(
      id: (json['id'] as num).toInt(),
      sport: SportModel.fromJson(json['sport'] as Map<String, dynamic>),
      title: json['title'] as String,
      durationMin: (json['durationMin'] as num).toInt(),
      calories: (json['calories'] as num?)?.toInt(),
      level: json['level'] as String?,
      equipmentNeeded: json['equipmentNeeded'] as String?,
      isAiGenerated: json['isAiGenerated'] as bool? ?? false,
      exercises:
          (json['exercises'] as List<dynamic>?)
              ?.map((e) => ExerciseModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$WorkoutModelImplToJson(_$WorkoutModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sport': instance.sport,
      'title': instance.title,
      'durationMin': instance.durationMin,
      'calories': instance.calories,
      'level': instance.level,
      'equipmentNeeded': instance.equipmentNeeded,
      'isAiGenerated': instance.isAiGenerated,
      'exercises': instance.exercises,
    };
