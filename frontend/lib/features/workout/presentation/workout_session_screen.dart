import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../progress/data/progress_repository.dart';
import '../data/workout_repository.dart';
import '../domain/models/workout_model.dart';

final workoutDetailsProvider = FutureProvider.family<WorkoutModel, String>((ref, id) async {
  return ref.watch(workoutRepositoryProvider).getWorkoutById(id);
});

class WorkoutSessionScreen extends ConsumerWidget {
  final String workoutId;
  const WorkoutSessionScreen({super.key, required this.workoutId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout'),
        actions: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: AppColors.neonGreen),
            child: const Text('Save'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ref.watch(workoutDetailsProvider(workoutId)).when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.neonGreen)),
        error: (error, stack) => Center(child: Text('Failed: $error', style: const TextStyle(color: AppColors.error))),
        data: (workout) {
          return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    '${workout.sport.name.toUpperCase()} • ${(workout.level ?? "ALL").toUpperCase()}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.textSecondary,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    workout.title,
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${workout.durationMin} min • ${workout.calories ?? "--"} kcal • ${workout.equipmentNeeded ?? "No equipment"}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Watch Video Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.play_circle_fill),
                      label: const Text('Watch Video'),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Session List Header
                  Text(
                    'Session',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  
                  if (workout.exercises.isEmpty)
                     const Text('No exercises found', style: TextStyle(color: AppColors.textSecondary))
                  else
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < workout.exercises.length; i++)
                              Column(
                                children: [
                                  _buildExerciseRow(theme, i + 1, workout.exercises[i].title, '${workout.exercises[i].reps ?? "-"} reps'),
                                  if (i < workout.exercises.length - 1)
                                    const Divider(height: 1, color: AppColors.background),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // Bottom padding to clear fixed bar
          const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
        ],
      );
    }),
      
      // Fixed Bottom Area
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: const Border(
            top: BorderSide(color: AppColors.surface, width: 1),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: Consumer(
                  builder: (context, ref, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        try {
                          await ref.read(progressRepositoryProvider).logWorkout(
                            workoutId: int.parse(workoutId), 
                            durationMin: 30, 
                            caloriesBurned: 400, 
                            performanceScore: 8
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Workout Logged!')));
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e', style: const TextStyle(color: AppColors.error))));
                          }
                        }
                      },
                      child: const Text('Log completed'),
                    );
                  }
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary),
                  child: const Text('Open timer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseRow(ThemeData theme, int index, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.textSecondary.withValues(alpha: 255 * 0.5), width: 1),
            ),
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const Icon(Icons.play_circle_outline, color: AppColors.neonGreen, size: 28),
        ],
      ),
    );
  }
}
