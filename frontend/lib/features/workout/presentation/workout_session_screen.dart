import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    'GYM • BEGINNER',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.textSecondary,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Upper Body Power',
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '32 min • 360 kcal • Dumbbells • Bench',
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
                  
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                            child: Text(
                              'Warm-up',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          _buildExerciseRow(theme, 1, 'Jumping Jacks', 'Controlled tempo • 2 mins'),
                          const Divider(height: 1, color: AppColors.background),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                            child: Text(
                              'Main Block',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          _buildExerciseRow(theme, 2, 'DB Bench Press', 'Controlled tempo • 10 reps'),
                          const Divider(height: 1, color: AppColors.background),
                          _buildExerciseRow(theme, 3, 'Incline Dumbbell Fly', 'Controlled tempo • 12 reps'),
                          const Divider(height: 1, color: AppColors.background),
                          _buildExerciseRow(theme, 4, 'Shoulder Press', 'Controlled tempo • 10 reps'),
                          const Divider(height: 1, color: AppColors.background),
                          _buildExerciseRow(theme, 5, 'Tricep Extensions', 'Controlled tempo • 15 reps'),
                          const Divider(height: 1, color: AppColors.background),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                            child: Text(
                              'Finisher',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          _buildExerciseRow(theme, 6, 'Cool Down Stretch', 'Hold positions • 5 mins'),
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
      ),
      
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
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Log completed'),
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
