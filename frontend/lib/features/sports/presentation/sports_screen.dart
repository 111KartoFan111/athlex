import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/tag_widget.dart';
import '../data/sport_repository.dart';
import '../domain/models/sport_model.dart';
import '../../profile/data/user_repository.dart';
import '../../auth/presentation/providers/auth_provider.dart';

final sportsCatalogProvider = FutureProvider<List<SportModel>>((ref) async {
  return ref.watch(sportRepositoryProvider).getSports();
});

class SportsScreen extends ConsumerWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

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
              child: ref.watch(sportsCatalogProvider).when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.neonGreen),
                ),
                error: (error, stack) => Center(
                  child: Text('Failed to load sports: $error', style: const TextStyle(color: AppColors.error)),
                ),
                data: (sports) {
                  final user = ref.watch(authStateProvider).value;
                  final primarySportId = user?.primarySport?.id;

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    itemCount: sports.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final sport = sports[index];
                      final isPrimary = sport.id == primarySportId;

                      return Card(
                        child: InkWell(
                          onTap: () => context.push('/workouts/sport/${sport.id}?name=${Uri.encodeComponent(sport.name)}'),
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
                                    Icons.fitness_center, // Fallback icon
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
                                        sport.name,
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
