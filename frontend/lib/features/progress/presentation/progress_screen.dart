import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_colors.dart';
import 'providers/progress_provider.dart';
import '../../profile/data/user_repository.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final historyAsync = ref.watch(workoutHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Progress'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Row
              Row(
                children: [
                  _buildSummaryBlock(theme, '24', 'Total Workouts'),
                  const SizedBox(width: 16),
                  _buildSummaryBlock(theme, '12h', 'Active Hours'),
                  const SizedBox(width: 16),
                  _buildSummaryBlock(theme, '8.5k', 'Kcal Burned'),
                ],
              ),
              const SizedBox(height: 32),

              // Activity Chart
              Text(
                'Activity This Week',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Container(
                height: 240,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 100,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            const style = TextStyle(color: AppColors.textSecondary, fontSize: 12);
                            String text;
                            switch (value.toInt()) {
                              case 0: text = 'M'; break;
                              case 1: text = 'T'; break;
                              case 2: text = 'W'; break;
                              case 3: text = 'T'; break;
                              case 4: text = 'F'; break;
                              case 5: text = 'S'; break;
                              case 6: text = 'S'; break;
                              default: text = ''; break;
                            }
                            return SideTitleWidget(
                              meta: meta,
                              space: 8,
                              child: Text(text, style: style),
                            );
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      _makeBarData(0, 40),
                      _makeBarData(1, 80),
                      _makeBarData(2, 30),
                      _makeBarData(3, 90),
                      _makeBarData(4, 50),
                      _makeBarData(5, 100),
                      _makeBarData(6, 60),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // History List
              Text(
                'History',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              historyAsync.when(
                loading: () => const Center(child: CircularProgressIndicator(color: AppColors.neonGreen)),
                error: (err, stack) => Center(child: Text('Failed to load history', style: TextStyle(color: AppColors.error))),
                data: (historyLogs) {
                  if (historyLogs.isEmpty) {
                     return const Center(child: Text('No workouts logged yet.'));
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: historyLogs.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = historyLogs[index];
                      final workout = item['workout'];
                      final rawDate = item['date'];
                      final dateStr = rawDate != null ? DateFormat('MMM dd, yyyy').format(DateTime.parse(rawDate)) : 'Unknown Date';
                      
                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          title: Text(
                            workout?['title'] ?? 'Unknown Workout',
                            style: theme.textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            dateStr,
                            style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                          ),
                          trailing: const Icon(
                            Icons.check_circle,
                            color: AppColors.neonGreen,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryBlock(ThemeData theme, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeBarData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColors.neonGreen,
          width: 16,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: AppColors.background,
          ),
        ),
      ],
    );
  }
}
