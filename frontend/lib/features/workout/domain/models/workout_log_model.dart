import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../auth/domain/models/user_model.dart';
import 'workout_model.dart';

part 'workout_log_model.freezed.dart';
part 'workout_log_model.g.dart';

@freezed
class WorkoutLogModel with _$WorkoutLogModel {
  const factory WorkoutLogModel({
    required int id,
    required UserModel user,
    required WorkoutModel workout,
    required DateTime date,
    required int duration,
    required int caloriesBurned,
    int? performanceScore,
  }) = _WorkoutLogModel;

  factory WorkoutLogModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutLogModelFromJson(json);
}
