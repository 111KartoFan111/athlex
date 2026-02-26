import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../workout/domain/models/exercise_model.dart';

class AdminExerciseRepository {
  final _dio;

  AdminExerciseRepository(this._dio);

  Future<List<ExerciseModel>> getExercises() async {
    try {
      final response = await _dio.get('/admin/exercises');
      final List<dynamic> data = response.data;
      return data.map((json) => ExerciseModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch admin exercises: $e');
    }
  }

  Future<void> deleteExercise(int exerciseId) async {
    try {
      await _dio.delete('/admin/exercises/$exerciseId');
    } catch (e) {
      throw Exception('Failed to delete exercise: $e');
    }
  }

  Future<void> createExercise(Map<String, dynamic> request) async {
    try {
      await _dio.post('/admin/exercises', data: request);
    } catch (e) {
      throw Exception('Failed to create exercise: $e');
    }
  }
}

final adminExerciseRepositoryProvider = Provider<AdminExerciseRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AdminExerciseRepository(dio);
});

final adminExercisesProvider = FutureProvider<List<ExerciseModel>>((ref) async {
  final repository = ref.watch(adminExerciseRepositoryProvider);
  return repository.getExercises();
});

class AdminExerciseActionNotifier extends StateNotifier<AsyncValue<void>> {
  final AdminExerciseRepository _repository;
  final Ref _ref;

  AdminExerciseActionNotifier(this._repository, this._ref) : super(const AsyncValue.data(null));

  Future<void> deleteExercise(int exerciseId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteExercise(exerciseId);
      _ref.invalidate(adminExercisesProvider);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> createExercise(Map<String, dynamic> request) async {
    state = const AsyncValue.loading();
    try {
      await _repository.createExercise(request);
      _ref.invalidate(adminExercisesProvider);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final adminExerciseActionProvider = StateNotifierProvider<AdminExerciseActionNotifier, AsyncValue<void>>((ref) {
  final repo = ref.watch(adminExerciseRepositoryProvider);
  return AdminExerciseActionNotifier(repo, ref);
});
