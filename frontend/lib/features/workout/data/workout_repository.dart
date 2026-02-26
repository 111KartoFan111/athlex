цimport 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../domain/models/workout_model.dart';

final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return WorkoutRepository(dio);
});

class WorkoutRepository {
  final Dio _dio;

  WorkoutRepository(this._dio);

  Future<List<Map<String, dynamic>>> getAllWorkouts() async {
    try {
      final response = await _dio.get('/workouts');
      final List<dynamic> data = response.data;
      return data.cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to fetch workouts: $e');
    }
  }

  Future<List<WorkoutModel>> getWorkouts({String? level}) async {
    try {
      final queryParams = level != null ? {'level': level.toUpperCase()} : null;
      final response = await _dio.get('/workouts', queryParameters: queryParams);
      final List<dynamic> data = response.data;
      return data.map((json) => WorkoutModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch workouts: $e');
    }
  }

  Future<List<WorkoutModel>> getWorkoutsBySport(int sportId) async {
    try {
      final response = await _dio.get('/workouts', queryParameters: {'sportId': sportId});
      final List<dynamic> data = response.data;
      return data.map((json) => WorkoutModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch workouts for sport: $e');
    }
  }

  Future<WorkoutModel> getWorkoutById(String id) async {
    try {
      final response = await _dio.get('/workouts/$id');
      return WorkoutModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch workout details: $e');
    }
  }
}
