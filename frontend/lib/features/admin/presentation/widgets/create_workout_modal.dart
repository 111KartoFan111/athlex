import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../sports/presentation/sports_screen.dart';
import '../providers/admin_workouts_provider.dart';

class CreateWorkoutModal extends ConsumerStatefulWidget {
  const CreateWorkoutModal({super.key});

  @override
  ConsumerState<CreateWorkoutModal> createState() => _CreateWorkoutModalState();
}

class _CreateWorkoutModalState extends ConsumerState<CreateWorkoutModal> {
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _equipmentController = TextEditingController();
  
  String _selectedLevel = 'BEGINNER';
  int? _selectedSportId;

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _caloriesController.dispose();
    _equipmentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_titleController.text.isEmpty || _durationController.text.isEmpty || _selectedSportId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final request = {
      'title': _titleController.text,
      'sportId': _selectedSportId,
      'level': _selectedLevel,
      'durationMin': int.tryParse(_durationController.text) ?? 0,
      'calories': int.tryParse(_caloriesController.text),
      'equipmentNeeded': _equipmentController.text.isEmpty ? null : _equipmentController.text,
    };

    ref.read(adminWorkoutActionProvider.notifier).createWorkout(request).then((_) {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sportsAsync = ref.watch(sportsCatalogProvider);
    final isSubmitting = ref.watch(adminWorkoutActionProvider).isLoading;

    return AlertDialog(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      title: const Text('Create New Workout', style: TextStyle(color: AppColors.textPrimary)),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildModalTextField('Title *', _titleController),
              const SizedBox(height: 16),
              
              // Sport Dropdown
              const Text('Sport *', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: sportsAsync.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (e, _) => Text('Error loading sports', style: TextStyle(color: Colors.redAccent)),
                  data: (sports) => DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      dropdownColor: AppColors.surface,
                      value: _selectedSportId,
                      hint: const Text('Select Sport', style: TextStyle(color: AppColors.textSecondary)),
                      items: sports.map((sport) {
                        return DropdownMenuItem<int>(
                          value: sport.id,
                          child: Text(sport.name, style: const TextStyle(color: AppColors.textPrimary)),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _selectedSportId = val),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Level Dropdown
              const Text('Level *', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: AppColors.surface,
                    value: _selectedLevel,
                    items: const [
                      DropdownMenuItem(value: 'BEGINNER', child: Text('BEGINNER', style: TextStyle(color: AppColors.textPrimary))),
                      DropdownMenuItem(value: 'INTERMEDIATE', child: Text('INTERMEDIATE', style: TextStyle(color: AppColors.textPrimary))),
                      DropdownMenuItem(value: 'ADVANCED', child: Text('ADVANCED', style: TextStyle(color: AppColors.textPrimary))),
                      DropdownMenuItem(value: 'ELITE', child: Text('ELITE', style: TextStyle(color: AppColors.textPrimary))),
                    ],
                    onChanged: (val) => setState(() => _selectedLevel = val!),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              _buildModalTextField('Duration (mins) *', _durationController, isNumber: true),
              const SizedBox(height: 16),
              _buildModalTextField('Calories (optional)', _caloriesController, isNumber: true),
              const SizedBox(height: 16),
              _buildModalTextField('Equipment (optional)', _equipmentController),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: isSubmitting ? null : () => Navigator.pop(context),
          style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: isSubmitting ? null : _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.neonGreen,
            foregroundColor: AppColors.background,
          ),
          child: isSubmitting 
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: AppColors.background, strokeWidth: 2))
              : const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildModalTextField(String label, TextEditingController controller, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.surface, // Dark grey inputs
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
