import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class TagWidget extends StatelessWidget {
  final String text;
  final bool isPrimary;

  const TagWidget({
    super.key,
    required this.text,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.neonGreen.withOpacity(0.1) : AppColors.background,
        border: Border.all(
          color: isPrimary ? AppColors.neonGreen : AppColors.textSecondary.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isPrimary ? AppColors.neonGreen : AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
