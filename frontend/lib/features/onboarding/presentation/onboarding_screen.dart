import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentStep = 0;
  String? _selectedLevel;
  String? _selectedSport;

  final List<String> _levels = ['Beginner', 'Intermediate', 'Advanced'];
  final List<Map<String, dynamic>> _sports = [
    {'name': 'Gym', 'icon': Icons.fitness_center},
    {'name': 'Football', 'icon': Icons.sports_soccer},
    {'name': 'Basketball', 'icon': Icons.sports_basketball},
    {'name': 'Boxing', 'icon': Icons.sports_mma},
    {'name': 'Athletics', 'icon': Icons.directions_run},
    {'name': 'Home', 'icon': Icons.home_work_outlined},
  ];

  void _nextStep() {
    if (_currentStep == 0 && _selectedLevel != null) {
      setState(() => _currentStep++);
    } else if (_currentStep == 1 && _selectedSport != null) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    // Refresh names from l10n
    final localizedLevels = [
      l10n.onboardingLevelBeginner,
      l10n.onboardingLevelIntermediate,
      l10n.onboardingLevelAdvanced
    ];

    return Scaffold(
      appBar: AppBar(
        leading: _currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() => _currentStep--),
              )
            : null,
        title: Text('Step ${_currentStep + 1} of 2'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: _currentStep == 0 ? _buildLevelStep(theme, l10n, localizedLevels) : _buildSportStep(theme, l10n),
              ),
            ),
            // Bottom Action
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: AppColors.background,
                border: Border(top: BorderSide(color: AppColors.surface, width: 1)),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_currentStep == 0 && _selectedLevel != null) ||
                             (_currentStep == 1 && _selectedSport != null)
                      ? _nextStep
                      : null,
                  child: Text(_currentStep == 1 ? l10n.onboardingNext : l10n.onboardingNext),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelStep(ThemeData theme, AppLocalizations l10n, List<String> localizedLevels) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.onboardingLevelTitle,
          style: theme.textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Help us tailor your workouts to your experience.',
          style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 32),
        ...localizedLevels.map((level) {
          final isSelected = _selectedLevel == level;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: InkWell(
              onTap: () => setState(() => _selectedLevel = level),
              borderRadius: BorderRadius.circular(16),
              child: Ink(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.neonGreen : Colors.transparent,
                    width: isSelected ? 2 : 0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined,
                        color: isSelected ? AppColors.neonGreen : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        level,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: isSelected ? AppColors.neonGreen : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildSportStep(ThemeData theme, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.onboardingSportTitle,
          style: theme.textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'What are you training for mostly?',
          style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 32),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: _sports.length,
          itemBuilder: (context, index) {
            final sport = _sports[index];
            final name = sport['name'] as String;
            final isSelected = _selectedSport == name;

            return InkWell(
              onTap: () => setState(() => _selectedSport = name),
              borderRadius: BorderRadius.circular(16),
              child: Ink(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.neonGreen : Colors.transparent,
                    width: isSelected ? 2 : 0,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      sport['icon'] as IconData,
                      size: 40,
                      color: isSelected ? AppColors.neonGreen : AppColors.textPrimary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isSelected ? AppColors.neonGreen : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
