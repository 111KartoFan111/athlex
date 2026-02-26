import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/presentation/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.neonGreen),
            tooltip: 'Logout',
            onPressed: () async {
              await ref.read(authStateProvider.notifier).logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: authState.when(
          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.neonGreen)),
          error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: AppColors.error))),
          data: (user) {
            if (user == null) {
              return const Center(child: Text('Not logged in'));
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),

                  // Avatar
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.neonGreen, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        user.email.substring(0, 1).toUpperCase(),
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: AppColors.neonGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email
                  Text(
                    user.email,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Role badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.neonGreen.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.neonGreen.withOpacity(0.4)),
                    ),
                    child: Text(
                      user.role,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.neonGreen,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Info cards
                  _buildInfoCard(
                    theme,
                    icon: Icons.emoji_events,
                    label: 'Rank',
                    value: user.rankTitle ?? 'Beginner',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    theme,
                    icon: Icons.local_fire_department,
                    label: 'Current Streak',
                    value: '${user.currentStreak} days',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    theme,
                    icon: Icons.fitness_center,
                    label: 'Level',
                    value: user.level ?? 'Not set',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    theme,
                    icon: Icons.sports,
                    label: 'Primary Sport',
                    value: user.primarySport?.name ?? 'Not set',
                  ),
                  const SizedBox(height: 40),

                  // Logout button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await ref.read(authStateProvider.notifier).logout();
                        if (context.mounted) {
                          context.go('/login');
                        }
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Sign Out'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: BorderSide(color: AppColors.error.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard(ThemeData theme, {required IconData icon, required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.neonGreen, size: 20),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
              Text(value, style: theme.textTheme.titleMedium?.copyWith(color: AppColors.textPrimary)),
            ],
          ),
        ],
      ),
    );
  }
}
