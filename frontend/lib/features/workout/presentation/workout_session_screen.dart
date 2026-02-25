import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/tag_widget.dart';

class WorkoutSessionScreen extends ConsumerWidget {
  final String workoutId;
  const WorkoutSessionScreen({super.key, required this.workoutId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    // Mock data for steps
    final steps = [
      {'title': 'Warm-up: Jumping Jacks', 'reps': '2 mins', 'muscle': 'Full Body'},
      {'title': 'DB Bench Press', 'reps': '3 sets x 10 reps', 'muscle': 'Chest'},
      {'title': 'Incline Dumbbell Fly', 'reps': '3 sets x 12 reps', 'muscle': 'Chest'},
      {'title': 'Shoulder Press', 'reps': '3 sets x 10 reps', 'muscle': 'Shoulders'},
      {'title': 'Tricep Extensions', 'reps': '3 sets x 15 reps', 'muscle': 'Triceps'},
      {'title': 'Cool Down Stretch', 'reps': '5 mins', 'muscle': 'Flexibility'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout'),
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
                    'Upper Body Power',
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text('45 Min', style: theme.textTheme.bodyMedium),
                      const SizedBox(width: 16),
                      Icon(Icons.local_fire_department_outlined, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text('350 Kcal', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Equipment Tags
                  const Row(
                    children: [
                      TagWidget(text: 'Dumbbells'),
                      SizedBox(width: 8),
                      TagWidget(text: 'Bench'),
                    ],
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
                ],
              ),
            ),
          ),
          
          // Steps List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final step = steps[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.neonGreen.withOpacity(0.5)),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: AppColors.neonGreen,
                              fontWeight: FontWeight.bold,
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
                              step['title']!,
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${step['reps']}  •  ${step['muscle']}',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                    ],
                  ),
                );
              },
              childCount: steps.length,
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
          border: Border(
            top: BorderSide(color: AppColors.surface, width: 1),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Open Timer'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Log Completed'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
