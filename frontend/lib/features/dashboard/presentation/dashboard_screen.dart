import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/circular_progress_ring.dart';
import '../../../core/widgets/tag_widget.dart';
import '../../challenges/data/challenge_repository.dart';
import '../../profile/data/user_repository.dart';
import '../../workout/data/workout_repository.dart';

final dashboardStatsProvider = FutureProvider<Map<String, dynamic>>((
  ref,
) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getDashboardStats();
});

/// Fetches the first available workout to use as the daily recommendation
final recommendedWorkoutProvider = FutureProvider<Map<String, dynamic>?>((
  ref,
) async {
  final repo = ref.watch(workoutRepositoryProvider);
  final workouts = await repo.getAllWorkouts();
  if (workouts.isEmpty) return null;
  // Prefer a beginner-level workout if available
  try {
    return workouts.firstWhere(
      (w) => (w['level'] as String?)?.toLowerCase() == 'beginner',
      orElse: () => workouts.first,
    );
  } catch (_) {
    return workouts.first;
  }
});

final dailyChallengeProvider = FutureProvider((ref) async {
  final repo = ref.watch(challengeRepositoryProvider);
  return repo.getDailyChallenge();
});

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final recommendedWorkout = ref.watch(recommendedWorkoutProvider);
    final dailyChallenge = ref.watch(dailyChallengeProvider);

    return Scaffold(
      body: SafeArea(
        child: ref
            .watch(dashboardStatsProvider)
            .when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.neonGreen),
              ),
              error: (error, stack) => Center(
                child: Text(
                  'Failed to load dashboard: $error',
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
              data: (stats) {
                final streak = stats['currentStreak'] ?? 0;
                final rank = stats['rankTitle'] ?? 'Beginner';
                final calories = stats['totalCaloriesBurned'] ?? 0;
                final duration = stats['totalDurationMin'] ?? 0;

                // Calculate simplistic percentages based on mock daily goals
                final calProgress = (calories / 600).clamp(0.0, 1.0);
                final timeProgress = (duration / 45).clamp(0.0, 1.0);

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Text(
                        'ATHLEX',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ready to crush it today?',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Daily Dashboard Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.local_fire_department,
                                    color: AppColors.neonGreen,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Streak $streak  •  Rank $rank',
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircularProgressRing(
                                    progress: calProgress.toDouble(),
                                    label: 'Kcal',
                                    value: calories.toString(),
                                  ),
                                  CircularProgressRing(
                                    progress: timeProgress.toDouble(),
                                    label: 'Time',
                                    value: '${duration}m',
                                  ),
                                  const CircularProgressRing(
                                    progress: 0.8,
                                    label: 'Performance',
                                    value: '80%',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () => context.push('/timer'),
                                      icon: const Icon(Icons.timer_outlined),
                                      label: const Text('Interval Timer'),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () =>
                                          context.push('/ai-coach'),
                                      icon: const Icon(
                                        Icons.smart_toy_outlined,
                                      ),
                                      label: const Text('AI Coach'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Daily Challenge
                      Text(
                        'Daily Challenge',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      dailyChallenge.when(
                        loading: () => const Card(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.neonGreen,
                              ),
                            ),
                          ),
                        ),
                        error: (_, __) => const SizedBox.shrink(),
                        data: (challenge) {
                          if (challenge == null) {
                            return const Card(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Text('No challenge available yet.'),
                              ),
                            );
                          }
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const TagWidget(
                                        text: 'Challenge',
                                        isPrimary: true,
                                      ),
                                      const SizedBox(width: 8),
                                      TagWidget(
                                        text: '${challenge.durationDays} days',
                                      ),
                                      const SizedBox(width: 8),
                                      TagWidget(text: challenge.targetMetric),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    challenge.title,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontSize: 18),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    challenge.description ??
                                        'Track your progress and stay consistent.',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),

                      // Recommended Workout
                      Text('Recommended', style: theme.textTheme.titleLarge),
                      const SizedBox(height: 12),
                      recommendedWorkout.when(
                        loading: () => const Card(
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.neonGreen,
                              ),
                            ),
                          ),
                        ),
                        error: (e, _) => const SizedBox.shrink(),
                        data: (workout) {
                          if (workout == null) return const SizedBox.shrink();
                          final id = workout['id']?.toString() ?? '';
                          final title = workout['title'] ?? 'Workout';
                          final duration =
                              workout['durationMin'] ??
                              workout['duration_min'] ??
                              0;
                          final calories = workout['calories'] ?? 0;
                          final level =
                              (workout['level'] as String? ?? 'Beginner')
                                  .toLowerCase();
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.background,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.fitness_center,
                                          color: AppColors.neonGreen,
                                        ),
                                      ),
                                      Text(
                                        level,
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    title,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontSize: 18),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$duration min • $calories kcal • $level',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: id.isNotEmpty
                                          ? () => context.push('/workout/$id')
                                          : null,
                                      child: const Text('Open Workout'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                );
              },
            ),
      ),
    );
  }
}
