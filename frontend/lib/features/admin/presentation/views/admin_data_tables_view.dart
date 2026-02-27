import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/admin_users_provider.dart';

class AdminDataTablesView extends ConsumerWidget {
  final String title;
  const AdminDataTablesView({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(adminUsersProvider);
    final actionState = ref.watch(adminUserActionProvider);

    // Listen for action errors
    ref.listen(adminUserActionProvider, (previous, next) {
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
              child: usersAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.neonGreen),
                ),
                error: (err, stack) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Error loading users: $err',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
                data: (users) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dataTableTheme: const DataTableThemeData(
                          headingRowColor: WidgetStatePropertyAll(
                            AppColors.surface,
                          ),
                          dataRowColor: WidgetStatePropertyAll(
                            AppColors.surface,
                          ),
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
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Role')),
                          DataColumn(label: Text('Level')),
                          DataColumn(label: Text('Primary Sport')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: users
                            .map(
                              (user) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      user.id.toString(),
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(user.email)),
                                  DataCell(Text(user.role)),
                                  DataCell(Text(user.level ?? '-')),
                                  DataCell(
                                    Text(user.primarySport?.name ?? '-'),
                                  ),
                                  DataCell(
                                    _buildStatusBadge(
                                      user.isBlocked ? 'Banned' : 'Active',
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        OutlinedButton(
                                          onPressed: actionState.isLoading
                                              ? null
                                              : () {
                                                  final newRole =
                                                      user.role == 'ADMIN'
                                                      ? 'USER'
                                                      : 'ADMIN';
                                                  ref
                                                      .read(
                                                        adminUserActionProvider
                                                            .notifier,
                                                      )
                                                      .updateRole(
                                                        user.id,
                                                        newRole,
                                                      );
                                                },
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            side: const BorderSide(
                                              color: AppColors.neonGreen,
                                            ),
                                            foregroundColor:
                                                AppColors.neonGreen,
                                          ),
                                          child: Text(
                                            user.role == 'ADMIN'
                                                ? 'Revoke Admin'
                                                : 'Make Admin',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        OutlinedButton(
                                          onPressed: actionState.isLoading
                                              ? null
                                              : () {
                                                  if (user.isBlocked) {
                                                    ref
                                                        .read(
                                                          adminUserActionProvider
                                                              .notifier,
                                                        )
                                                        .unblockUser(user.id);
                                                  } else {
                                                    ref
                                                        .read(
                                                          adminUserActionProvider
                                                              .notifier,
                                                        )
                                                        .blockUser(user.id);
                                                  }
                                                },
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            side: const BorderSide(
                                              color: Colors.redAccent,
                                            ),
                                            foregroundColor: Colors.redAccent,
                                          ),
                                          child: Text(
                                            user.isBlocked
                                                ? 'Unblock'
                                                : 'Block',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
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
        color: isActive
            ? AppColors.neonGreen.withValues(alpha: 255 * 0.1)
            : Colors.redAccent.withValues(alpha: 255 * 0.1),
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
}
