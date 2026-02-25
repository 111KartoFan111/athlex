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
      appBar: AppBar(
        title: const Text('Sports Library'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: sports.length,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          sport['icon'] as IconData,
                          size: 36,
                          color: isPrimary ? AppColors.neonGreen : AppColors.textPrimary,
                        ),
                        TagWidget(
                          text: isPrimary ? 'Primary' : 'Sport',
                          isPrimary: isPrimary,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      sport['name'] as String,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap to explore workouts',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
