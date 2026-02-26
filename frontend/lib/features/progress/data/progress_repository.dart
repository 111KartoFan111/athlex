import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ProgressRepository(dio);
});

class ProgressRepository {
  final Dio _dio;

  ProgressRepository(this._dio);

  Future<void> logWorkout({
    required int workoutId,
    required int durationMin,
    required int caloriesBurned,
    required int performanceScore,
  }) async {
    try {
      await _dio.post('/progress/log', data: {
        'workoutId': workoutId,
        'durationMin': durationMin,
        'caloriesBurned': caloriesBurned,
        'performanceScore': performanceScore,
      });
    } catch (e) {
    } catch (e) {
      throw Exception('Failed to log workout: $e');
    }
  }

  Future<List<dynamic>> getWorkoutHistory() async {
    try {
      final response = await _dio.get('/progress/history');
      return response.data as List<dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch history: $e');
    }
  }
}
