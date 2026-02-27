import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/admin_exercises_provider.dart';
import '../widgets/create_exercise_modal.dart';

class AdminExercisesTableView extends ConsumerWidget {
  final String title;
  const AdminExercisesTableView({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsync = ref.watch(adminExercisesProvider);
    final actionState = ref.watch(adminExerciseActionProvider);

    // Listen for action errors
    ref.listen(adminExerciseActionProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Action failed: ${next.error}')));
      }
    });

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manage $title',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 32),

          // Top Action Bar
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search $title...',
                    filled: true,
                    fillColor: AppColors.surface, // #1C1C1E
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.textSecondary,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              ElevatedButton.icon(
                onPressed: () => _showCreateModal(context),
                icon: const Icon(Icons.add),
                label: const Text('Create New'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neonGreen,
                  foregroundColor: AppColors.background,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Data Table
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surface, // #1C1C1E
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dataTableTheme: const DataTableThemeData(
                        headingRowColor: WidgetStatePropertyAll(
                          AppColors.surface,
                        ),
                        dataRowColor: WidgetStatePropertyAll(AppColors.surface),
                        headingTextStyle: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        dataTextStyle: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                        dividerThickness: 1,
                      ),
                    ),
                    child: exercisesAsync.when(
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.neonGreen,
                        ),
                      ),
                      error: (err, stack) => Center(
                        child: Text(
                          'Error loading exercises: $err',
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      ),
                      data: (exercises) {
                        return DataTable(
                          columns: const [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Title')),
                            DataColumn(label: Text('Target Muscle')),
                            DataColumn(label: Text('Reps')),
                            DataColumn(label: Text('Has Video')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: exercises
                              .map(
                                (exercise) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        exercise.id.toString(),
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    DataCell(Text(exercise.title)),
                                    DataCell(
                                      Text(exercise.targetMuscleGroup ?? '-'),
                                    ),
                                    DataCell(
                                      Text(exercise.reps?.toString() ?? '-'),
                                    ),
                                    DataCell(
                                      Text(
                                        exercise.videoUrl != null
                                            ? 'Yes'
                                            : 'No',
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          OutlinedButton(
                                            onPressed:
                                                () {}, // Edit is currently a placeholder
                                            style: OutlinedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                  ),
                                              side: const BorderSide(
                                                color: AppColors.neonGreen,
                                              ),
                                              foregroundColor:
                                                  AppColors.neonGreen,
                                            ),
                                            child: const Text('Edit'),
                                          ),
                                          const SizedBox(width: 8),
                                          OutlinedButton(
                                            onPressed: actionState.isLoading
                                                ? null
                                                : () {
                                                    ref
                                                        .read(
                                                          adminExerciseActionProvider
                                                              .notifier,
                                                        )
                                                        .deleteExercise(
                                                          exercise.id,
                                                        );
                                                  },
                                            style: OutlinedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                  ),
                                              side: const BorderSide(
                                                color: Colors.redAccent,
                                              ),
                                              foregroundColor: Colors.redAccent,
                                            ),
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CreateExerciseModal(),
    );
  }
}
