import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../sports/domain/models/sport_model.dart';
import 'exercise_model.dart';

part 'workout_model.freezed.dart';
part 'workout_model.g.dart';

@freezed
class WorkoutModel with _$WorkoutModel {
  const factory WorkoutModel({
    required int id,
    required SportModel sport,
    required String title,
    required int durationMin,
    int? calories,
    String? level,
    String? equipmentNeeded,
    @Default(false) bool isAiGenerated,
    @Default([]) List<ExerciseModel> exercises,
  }) = _WorkoutModel;

  factory WorkoutModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutModelFromJson(json);
}
