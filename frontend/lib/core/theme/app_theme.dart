import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.neonGreen,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonGreen,
        secondary: AppColors.neonGreen,
        surface: AppColors.surface,
        background: AppColors.background,
        onPrimary: AppColors.background,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(color: AppColors.textPrimary),
        displayMedium: baseTextTheme.displayMedium?.copyWith(color: AppColors.textPrimary),
        displaySmall: baseTextTheme.displaySmall?.copyWith(color: AppColors.textPrimary),
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        titleLarge: baseTextTheme.titleLarge?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        titleMedium: baseTextTheme.titleMedium?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        titleSmall: baseTextTheme.titleSmall?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: AppColors.textPrimary),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
        bodySmall: baseTextTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        labelLarge: baseTextTheme.labelLarge?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        labelMedium: baseTextTheme.labelMedium?.copyWith(color: AppColors.textSecondary),
        labelSmall: baseTextTheme.labelSmall?.copyWith(color: AppColors.textSecondary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.neonGreen,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.neonGreen,
          foregroundColor: AppColors.background,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.neonGreen,
          side: const BorderSide(color: AppColors.neonGreen, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.surface,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.textSecondary.withValues(alpha: 255 * 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.textSecondary.withValues(alpha: 255 * 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.neonGreen, width: 2),
        ),
        hintStyle: baseTextTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        labelStyle: baseTextTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
