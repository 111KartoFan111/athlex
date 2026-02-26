import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Pure Black (#000000) for screen backgrounds and bottom navigation.
  static const Color background = Color(0xFF000000);

  /// Dark Grey (#1C1C1E) for cards, surfaces, structured elements with rounded corners.
  static const Color surface = Color(0xFF1C1C1E);

  /// Neon Green (#39FF14) for primary accents, active buttons, icons, progress fills.
  static const Color neonGreen = Color(0xFF39FF14);

  /// White (#FFFFFF) for primary headings, titles, prominent text.
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Light Grey (#8E8E93) for subtitles, secondary text, inactive tab icons.
  static const Color textSecondary = Color(0xFF8E8E93);

  /// Error Red (#FF453A) for destructive actions or failure states.
  static const Color error = Color(0xFFFF453A);
}
