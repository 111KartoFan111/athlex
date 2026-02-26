import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/progress_repository.dart';

final workoutHistoryProvider = FutureProvider<List<dynamic>>((ref) async {
  final repository = ref.watch(progressRepositoryProvider);
  return await repository.getWorkoutHistory();
});
