import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.backgroundCream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryYellow,
        primary: AppColors.primaryYellow,
        onPrimary: AppColors.darkBrown,
        secondary: AppColors.mangroveGreen,
        surface: AppColors.backgroundCream,
      ),
      textTheme: TextTheme(
        // Tipografía de Títulos y Encabezados: Outfit
        displayLarge: GoogleFonts.outfit(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.darkBrown,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: AppColors.darkBrown,
        ),
        titleLarge: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.darkBrown,
        ),
        titleMedium: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.darkBrown,
        ),
        // Tipografía de Lectura y Contenido: Rubik
        bodyLarge: GoogleFonts.rubik(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.darkBrown,
        ),
        bodyMedium: GoogleFonts.rubik(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.darkBrown,
        ),
        bodySmall: GoogleFonts.rubik(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.darkBrown.withOpacity(0.7),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        errorMaxLines: 3,
        errorStyle: GoogleFonts.rubik(
          color: AppColors.errorRed,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.25,
        ),
        hintStyle: GoogleFonts.rubik(
          color: AppColors.darkBrown.withOpacity(0.4),
          fontSize: 14,
        ),
        labelStyle: GoogleFonts.rubik(
          color: AppColors.darkBrown.withOpacity(0.8),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.doughBeige, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.doughBeige, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primaryYellow, width: 2.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 2.5),
        ),
      ),
    );
  }
}
