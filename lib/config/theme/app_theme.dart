import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: ColorScheme.light(
          primary: AppColors.ink,
          secondary: AppColors.accent,
          surface: AppColors.surface,
          onSurface: AppColors.ink,
          error: AppColors.error,
          outline: AppColors.border,
          outlineVariant: AppColors.border2,
        ),
        textTheme: AppTextStyles.uiTextTheme.apply(
          bodyColor: AppColors.ink,
          displayColor: AppColors.ink,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.ink,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.border),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.ink,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.border),
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bgDark,
        colorScheme: ColorScheme.dark(
          primary: AppColors.inkDark,
          secondary: AppColors.accent,
          surface: AppColors.surfaceDark,
          onSurface: AppColors.inkDark,
          error: AppColors.error,
          outline: AppColors.border,
          outlineVariant: AppColors.border2,
        ),
        textTheme: AppTextStyles.uiTextTheme.apply(
          bodyColor: AppColors.inkDark,
          displayColor: AppColors.inkDark,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.inkDark,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: AppColors.surfaceDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.border),
          ),
        ),
      );
}
