import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../providers/admin_exercises_provider.dart';
import '../providers/admin_workouts_provider.dart';

class CreateExerciseModal extends ConsumerStatefulWidget {
  const CreateExerciseModal({super.key});

  @override
  ConsumerState<CreateExerciseModal> createState() => _CreateExerciseModalState();
}

class _CreateExerciseModalState extends ConsumerState<CreateExerciseModal> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _videoUrlController = TextEditingController();
  final _muscleGroupController = TextEditingController();
  final _repsController = TextEditingController();

  int? _selectedWorkoutId;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _videoUrlController.dispose();
    _muscleGroupController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_titleController.text.isEmpty || _selectedWorkoutId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final request = {
      'workoutId': _selectedWorkoutId,
      'title': _titleController.text,
      'description': _descriptionController.text.isEmpty ? null : _descriptionController.text,
      'videoUrl': _videoUrlController.text.isEmpty ? null : _videoUrlController.text,
      'targetMuscleGroup': _muscleGroupController.text.isEmpty ? null : _muscleGroupController.text,
      'reps': int.tryParse(_repsController.text),
    };

    ref.read(adminExerciseActionProvider.notifier).createExercise(request).then((_) {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final workoutsAsync = ref.watch(adminWorkoutsProvider);
    final isSubmitting = ref.watch(adminExerciseActionProvider).isLoading;

    return AlertDialog(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      title: const Text('Create New Exercise', style: TextStyle(color: AppColors.textPrimary)),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Workout Dropdown
              const Text('Linked Workout *', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: workoutsAsync.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (e, _) => const Text('Error loading workouts', style: TextStyle(color: Colors.redAccent)),
                  data: (workouts) => DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      dropdownColor: AppColors.surface,
                      value: _selectedWorkoutId,
                      hint: const Text('Select Workout', style: TextStyle(color: AppColors.textSecondary)),
                      items: workouts.map((workout) {
                        return DropdownMenuItem<int>(
                          value: workout.id,
                          child: Text('${workout.title} (${workout.sport.name})', style: const TextStyle(color: AppColors.textPrimary)),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _selectedWorkoutId = val),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              _buildModalTextField('Title *', _titleController),
              const SizedBox(height: 16),
              _buildModalTextField('Description (optional)', _descriptionController),
              const SizedBox(height: 16),
              _buildModalTextField('Video URL (optional)', _videoUrlController),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(child: _buildModalTextField('Muscle Group', _muscleGroupController)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildModalTextField('Reps', _repsController, isNumber: true)),
                ],
              ),
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
