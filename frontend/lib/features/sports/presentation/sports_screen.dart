import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/tag_widget.dart';

class SportsScreen extends ConsumerWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    // Mock data
    final sports = [
      {'name': 'Gym', 'icon': Icons.fitness_center, 'isPrimary': true},
      {'name': 'Football', 'icon': Icons.sports_soccer, 'isPrimary': false},
      {'name': 'Basketball', 'icon': Icons.sports_basketball, 'isPrimary': false},
      {'name': 'Boxing', 'icon': Icons.sports_mma, 'isPrimary': false},
      {'name': 'Athletics', 'icon': Icons.directions_run, 'isPrimary': false},
      {'name': 'Home', 'icon': Icons.home_work_outlined, 'isPrimary': false},
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Sports',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Multi-sport training library',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                itemCount: sports.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final sport = sports[index];
                  final isPrimary = sport['isPrimary'] as bool;

                  return Card(
                    child: InkWell(
                      onTap: () {
                        // To View Workout Placeholder
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isPrimary ? AppColors.neonGreen.withValues(alpha: 255 * 0.5) : AppColors.textSecondary.withValues(alpha: 255 * 0.3),
                                ),
                              ),
                              child: Icon(
                                sport['icon'] as IconData,
                                size: 28,
                                color: isPrimary ? AppColors.neonGreen : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sport['name'] as String,
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Tap to explore workouts',
                                    style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            TagWidget(
                              text: isPrimary ? 'Primary' : 'Sport',
                              isPrimary: isPrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
