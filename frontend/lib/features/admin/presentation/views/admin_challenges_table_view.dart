import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/admin_challenges_provider.dart';
import '../widgets/create_challenge_modal.dart';

class AdminChallengesTableView extends ConsumerWidget {
  final String title;

  const AdminChallengesTableView({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengesAsync = ref.watch(adminChallengesProvider);
    final actionState = ref.watch(adminChallengeActionProvider);

    ref.listen(adminChallengeActionProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Action failed: ${next.error}')));
      }
    });

    return Padding(
      padding: const EdgeInsets.all(32),
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
          Row(
            children: [
              const Spacer(),
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
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surface,
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
                      ),
                    ),
                    child: challengesAsync.when(
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.neonGreen,
                        ),
                      ),
                      error: (err, _) => Center(
                        child: Text(
                          'Error loading challenges: $err',
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      ),
                      data: (challenges) {
                        return DataTable(
                          columns: const [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Title')),
                            DataColumn(label: Text('Duration')),
                            DataColumn(label: Text('Target')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: challenges
                              .map(
                                (challenge) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        challenge.id.toString(),
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    DataCell(Text(challenge.title)),
                                    DataCell(
                                      Text('${challenge.durationDays} days'),
                                    ),
                                    DataCell(Text(challenge.targetMetric)),
                                    DataCell(
                                      OutlinedButton(
                                        onPressed: actionState.isLoading
                                            ? null
                                            : () => ref
                                                  .read(
                                                    adminChallengeActionProvider
                                                        .notifier,
                                                  )
                                                  .deleteChallenge(
                                                    challenge.id,
                                                  ),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          side: const BorderSide(
                                            color: Colors.redAccent,
                                          ),
                                          foregroundColor: Colors.redAccent,
                                        ),
                                        child: const Text('Delete'),
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
      builder: (context) => const CreateChallengeModal(),
    );
  }
}
