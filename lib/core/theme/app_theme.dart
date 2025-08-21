import 'package:cumpri/core/theme/color/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    final baseTheme = ThemeData.light();
    const colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      error: AppColors.error,
      onError: AppColors.onError,
    );

    return baseTheme.copyWith(
      scaffoldBackgroundColor: AppColors.surface,
      colorScheme: colorScheme,
    );
  }

  static ThemeData darkTheme() {
    final baseTheme = ThemeData.dark();
    const colorScheme = ColorScheme.dark(
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkOnPrimary,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkOnSecondary,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      error: AppColors.darkError,
      onError: AppColors.darkOnError,
    );

    return baseTheme.copyWith(
      scaffoldBackgroundColor: AppColors.darkSurface,
      colorScheme: colorScheme,
    );
  }
}
