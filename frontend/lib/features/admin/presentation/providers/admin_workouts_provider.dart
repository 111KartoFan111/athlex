import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../workout/domain/models/workout_model.dart';

class AdminWorkoutRepository {
  final _dio;

  AdminWorkoutRepository(this._dio);

  Future<List<WorkoutModel>> getWorkouts() async {
    try {
      final response = await _dio.get('/admin/workouts');
      final List<dynamic> data = response.data;
      return data.map((json) => WorkoutModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch admin workouts: $e');
    }
  }

  Future<void> deleteWorkout(int workoutId) async {
    try {
      await _dio.delete('/admin/workouts/$workoutId');
    } catch (e) {
      throw Exception('Failed to delete workout: $e');
    }
  }

  Future<void> createWorkout(Map<String, dynamic> request) async {
    try {
      await _dio.post('/admin/workouts', data: request);
    } catch (e) {
      throw Exception('Failed to create workout: $e');
    }
  }
}

final adminWorkoutRepositoryProvider = Provider<AdminWorkoutRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AdminWorkoutRepository(dio);
});

final adminWorkoutsProvider = FutureProvider<List<WorkoutModel>>((ref) async {
  final repository = ref.watch(adminWorkoutRepositoryProvider);
  return repository.getWorkouts();
});

class AdminWorkoutActionNotifier extends StateNotifier<AsyncValue<void>> {
  final AdminWorkoutRepository _repository;
  final Ref _ref;

  AdminWorkoutActionNotifier(this._repository, this._ref) : super(const AsyncValue.data(null));

  Future<void> deleteWorkout(int workoutId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteWorkout(workoutId);
      _ref.invalidate(adminWorkoutsProvider);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> createWorkout(Map<String, dynamic> request) async {
    state = const AsyncValue.loading();
    try {
      await _repository.createWorkout(request);
      _ref.invalidate(adminWorkoutsProvider);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final adminWorkoutActionProvider = StateNotifierProvider<AdminWorkoutActionNotifier, AsyncValue<void>>((ref) {
  final repo = ref.watch(adminWorkoutRepositoryProvider);
  return AdminWorkoutActionNotifier(repo, ref);
});
