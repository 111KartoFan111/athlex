import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'views/admin_dashboard_view.dart';
import 'views/admin_data_tables_view.dart';
import 'views/admin_workouts_table_view.dart';
import 'views/admin_exercises_table_view.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _views = [
    const AdminDashboardView(),
    const AdminDataTablesView(title: 'Users'),
    const AdminWorkoutsTableView(title: 'Workouts'),
    const AdminExercisesTableView(title: 'Exercises'),
    const Center(child: Text('Challenges (Placeholder)')),
    const Center(child: Text('Settings (Placeholder)')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: AppColors.background, // Black
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'ATHLEX ADMIN',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _buildSidebarItem(0, Icons.dashboard, 'Dashboard'),
                _buildSidebarItem(1, Icons.group, 'Users'),
                _buildSidebarItem(2, Icons.fitness_center, 'Workouts'),
                _buildSidebarItem(3, Icons.sports_gymnastics, 'Exercises'),
                _buildSidebarItem(4, Icons.emoji_events, 'Challenges'),
                const Spacer(),
                _buildSidebarItem(5, Icons.settings, 'Settings'),
                const SizedBox(height: 24),
              ],
            ),
          ),
          
          // Main Content
          Expanded(
            child: Container(
              color: const Color(0xFF0A0A0A), // Very dark grey
              child: _views[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(int index, IconData icon, String title) {
    final isSelected = _selectedIndex == index;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.neonGreen.withValues(alpha: 255 * 0.1) : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isSelected ? AppColors.neonGreen : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.neonGreen : AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.neonGreen : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
