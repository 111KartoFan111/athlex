import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../providers/admin_challenges_provider.dart';

class CreateChallengeModal extends ConsumerStatefulWidget {
  const CreateChallengeModal({super.key});

  @override
  ConsumerState<CreateChallengeModal> createState() =>
      _CreateChallengeModalState();
}

class _CreateChallengeModalState extends ConsumerState<CreateChallengeModal> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();
  final _targetController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_titleController.text.isEmpty ||
        _durationController.text.isEmpty ||
        _targetController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    await ref.read(adminChallengeActionProvider.notifier).createChallenge({
      'title': _titleController.text,
      'description': _descriptionController.text.isEmpty
          ? null
          : _descriptionController.text,
      'durationDays': int.tryParse(_durationController.text) ?? 0,
      'targetMetric': _targetController.text,
    });

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting = ref.watch(adminChallengeActionProvider).isLoading;
    return AlertDialog(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      title: const Text(
        'Create New Challenge',
        style: TextStyle(color: AppColors.textPrimary),
      ),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _field('Title *', _titleController),
            const SizedBox(height: 16),
            _field('Description', _descriptionController),
            const SizedBox(height: 16),
            _field('Duration (days) *', _durationController, number: true),
            const SizedBox(height: 16),
            _field('Target metric *', _targetController),
          ],
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
          child: isSubmitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.background,
                  ),
                )
              : const Text('Save'),
        ),
      ],
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    bool number = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: number ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
