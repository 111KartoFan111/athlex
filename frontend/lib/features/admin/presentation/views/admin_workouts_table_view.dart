import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../workout/domain/models/workout_model.dart';
import '../providers/admin_workouts_provider.dart';
import '../widgets/create_workout_modal.dart';

class AdminWorkoutsTableView extends ConsumerWidget {
  final String title;
  const AdminWorkoutsTableView({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutsAsync = ref.watch(adminWorkoutsProvider);
    final actionState = ref.watch(adminWorkoutActionProvider);

    // Listen for action errors
    ref.listen(adminWorkoutActionProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Action failed: ${next.error}')),
        );
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
                    prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                        headingRowColor: WidgetStatePropertyAll(AppColors.surface),
                        dataRowColor: WidgetStatePropertyAll(AppColors.surface),
                        headingTextStyle: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                        dataTextStyle: TextStyle(color: AppColors.textSecondary),
                        dividerThickness: 1,
                      ),
                    ),
                    child: workoutsAsync.when(
                      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.neonGreen)),
                      error: (err, stack) => Center(child: Text('Error loading workouts: $err', style: const TextStyle(color: Colors.redAccent))),
                      data: (workouts) {
                        return DataTable(
                          columns: const [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Sport')),
                            DataColumn(label: Text('Title')),
                            DataColumn(label: Text('Duration (min)')),
                            DataColumn(label: Text('Level')),
                            DataColumn(label: Text('AI Generated')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: workouts.map((workout) => DataRow(
                            cells: [
                              DataCell(Text(workout.id.toString(), style: const TextStyle(color: AppColors.textPrimary))),
                              DataCell(Text(workout.sport.name)),
                              DataCell(Text(workout.title)),
                              DataCell(Text(workout.durationMin.toString())),
                              DataCell(Text(workout.level ?? '-')),
                              DataCell(Text(workout.isAiGenerated ? 'Yes' : 'No')),
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {}, // Edit is currently a placeholder
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        side: const BorderSide(color: AppColors.neonGreen),
                                        foregroundColor: AppColors.neonGreen,
                                      ),
                                      child: const Text('Edit'),
                                    ),
                                    const SizedBox(width: 8),
                                    OutlinedButton(
                                      onPressed: actionState.isLoading ? null : () {
                                        ref.read(adminWorkoutActionProvider.notifier).deleteWorkout(workout.id);
                                      },
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        side: const BorderSide(color: Colors.redAccent),
                                        foregroundColor: Colors.redAccent,
                                      ),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )).toList(),
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

  Widget _buildStatusBadge(String status) {
    final isActive = status == 'Active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.neonGreen.withValues(alpha: 255 * 0.1) : Colors.redAccent.withValues(alpha: 255 * 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? AppColors.neonGreen : Colors.redAccent,
        ),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isActive ? AppColors.neonGreen : Colors.redAccent,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showCreateModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CreateWorkoutModal(),
    );
  }
}
