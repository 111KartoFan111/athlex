import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AdminDataTablesView extends StatelessWidget {
  final String title;
  const AdminDataTablesView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Mock user data
    final data = [
      {'id': 'USR-001', 'email': 'john.doe@example.com', 'role': 'User', 'level': 'Intermediate', 'sport': 'Gym', 'status': 'Active'},
      {'id': 'USR-002', 'email': 'sarah.m@example.com', 'role': 'User', 'level': 'Beginner', 'sport': 'Home', 'status': 'Active'},
      {'id': 'USR-003', 'email': 'mike99@example.com', 'role': 'User', 'level': 'Advanced', 'sport': 'Boxing', 'status': 'Banned'},
      {'id': 'USR-004', 'email': 'admin@athlex.app', 'role': 'Admin', 'level': 'Elite', 'sport': 'Gym', 'status': 'Active'},
    ];

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
                    rows: data.map((item) => DataRow(
                      cells: [
                        DataCell(Text(item['id']!, style: const TextStyle(color: AppColors.textPrimary))),
                        DataCell(Text(item['email']!)),
                        DataCell(Text(item['role']!)),
                        DataCell(Text(item['level']!)),
                        DataCell(Text(item['sport']!)),
                        DataCell(_buildStatusBadge(item['status']!)),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  side: const BorderSide(color: AppColors.neonGreen),
                                  foregroundColor: AppColors.neonGreen,
                                ),
                                child: const Text('Edit'),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton(
                                onPressed: () {},
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
      builder: (context) {
        // Mock Form Fields (Title, Duration, Calories, Equipment)
        return AlertDialog(
          backgroundColor: AppColors.background,
          surfaceTintColor: Colors.transparent,
          title: const Text('Create New Workout'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildModalTextField('Title'),
                const SizedBox(height: 16),
                _buildModalTextField('Duration (mins)'),
                const SizedBox(height: 16),
                _buildModalTextField('Calories'),
                const SizedBox(height: 16),
                _buildModalTextField('Equipment'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonGreen,
                foregroundColor: AppColors.background,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildModalTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColors.surface, // Dark grey inputs
      ),
    );
  }
}
