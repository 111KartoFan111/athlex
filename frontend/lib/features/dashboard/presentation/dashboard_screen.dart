import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/circular_progress_ring.dart';
import '../../../core/widgets/tag_widget.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Daily Dashboard',
                style: theme.textTheme.headlineLarge,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.local_fire_department, color: AppColors.neonGreen, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    'Streak 2  •  Rank Rookie',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.neonGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Progress Rings
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularProgressRing(
                    progress: 0.65,
                    label: 'Kcal',
                    value: '450',
                  ),
                  CircularProgressRing(
                    progress: 0.4,
                    label: 'Time',
                    value: '25m',
                  ),
                  CircularProgressRing(
                    progress: 0.8,
                    label: 'Performance',
                    value: '80%',
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.timer_outlined),
                      label: const Text('Interval Timer'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.smart_toy_outlined),
                      label: const Text('AI Coach'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Daily Challenge
              Text(
                'Daily Challenge',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          TagWidget(text: 'Explosive', isPrimary: true),
                          SizedBox(width: 8),
                          TagWidget(text: 'No equipment'),
                          SizedBox(width: 8),
                          TagWidget(text: 'HIIT'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '15 Min Fat Burner',
                        style: theme.textTheme.titleMedium?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Push your limits with this intense bodyweight routine designed to torch calories.',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.textSecondary.withOpacity(0.3)),
                            foregroundColor: AppColors.textPrimary,
                          ),
                          child: const Text('View Challenge'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Recommended Workout
              Text(
                'Recommended',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.fitness_center, color: AppColors.neonGreen),
                          ),
                          const Text('Gym • 45m', style: TextStyle(color: AppColors.textSecondary)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Upper Body Power',
                        style: theme.textTheme.titleMedium?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Chest, Shoulders & Triceps focus',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Open Workout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
