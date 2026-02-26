import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/admin_dashboard_provider.dart';

class AdminDashboardView extends ConsumerWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(adminDashboardProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard Overview',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 32),
          
          // Summary Widgets
          dashboardAsync.when(
            loading: () => const Center(child: CircularProgressIndicator(color: AppColors.neonGreen)),
            error: (err, stack) => Text('Error loading dashboard: $err', style: const TextStyle(color: Colors.redAccent)),
            data: (stats) => Row(
              children: [
                _buildSummaryCard('Total Users', '${stats['totalUsers'] ?? 0}', '+12% this week', true),
                const SizedBox(width: 24),
                _buildSummaryCard('Active Users', '${stats['activeUsers'] ?? 0}', '+5% this week', true),
                const SizedBox(width: 24),
                _buildSummaryCard('Workouts Completed', '${stats['completedWorkouts'] ?? 0}', '+18% this week', true),
                const SizedBox(width: 24),
                _buildSummaryCard('Server Load', '42%', '-2% today', false),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Growth Chart
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface, // #1C1C1E
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'User Growth (Last 30 Days)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 5,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: 30,
                      minY: 0,
                      maxY: 13000,
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 10000),
                            FlSpot(5, 10500),
                            FlSpot(10, 10800),
                            FlSpot(15, 11200),
                            FlSpot(20, 11800),
                            FlSpot(25, 12100),
                            FlSpot(30, 12450),
                          ],
                          isCurved: true,
                          color: AppColors.neonGreen,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.neonGreen.withValues(alpha: 255 * 0.3),
                                AppColors.neonGreen.withValues(alpha: 255 * 0.0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, String change, bool isPositive) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface, // #1C1C1E
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              change,
              style: TextStyle(
                color: isPositive ? AppColors.neonGreen : AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
