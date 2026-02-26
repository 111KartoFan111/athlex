import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../data/workout_repository.dart';
import '../domain/models/workout_model.dart';

final workoutsBySportProvider = FutureProvider.family<List<WorkoutModel>, int>((ref, sportId) async {
  return ref.watch(workoutRepositoryProvider).getWorkoutsBySport(sportId);
});

class WorkoutsBySportScreen extends ConsumerWidget {
  final int sportId;
  final String sportName;

  const WorkoutsBySportScreen({
    super.key,
    required this.sportId,
    required this.sportName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final workoutsAsync = ref.watch(workoutsBySportProvider(sportId));

    return Scaffold(
      appBar: AppBar(
        title: Text(sportName),
      ),
      body: SafeArea(
        child: workoutsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.neonGreen)),
          error: (err, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off, color: AppColors.textSecondary, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    'No workouts available for $sportName yet.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ),
          data: (workouts) {
            if (workouts.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.fitness_center, color: AppColors.textSecondary, size: 64),
                      const SizedBox(height: 16),
                      Text(
                        'No workouts found for $sportName',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Check back later or explore other sports.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: workouts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final workout = workouts[index];
                return Card(
                  child: InkWell(
                    onTap: () => context.push('/workout/${workout.id}'),
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.fitness_center, color: AppColors.neonGreen, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  workout.title,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                              if (workout.level != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.neonGreen.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
                                  ),
                                  child: Text(
                                    workout.level!,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: AppColors.neonGreen,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '${workout.durationMin} min  •  ${workout.calories ?? '--'} kcal  •  ${workout.equipmentNeeded ?? 'No equipment'}',
                            style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => context.push('/workout/${workout.id}'),
                              child: const Text('Open Workout'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
