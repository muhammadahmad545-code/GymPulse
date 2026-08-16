import 'package:flutter/material.dart';

/// Mr. Gym design tokens.
abstract final class GpColors {
  static const background = Color(0xFF0E1114);
  static const surface = Color(0xFF171B21);
  static const surfaceElevated = Color(0xFF1F252D);
  static const primary = Color(0xFFB6FF3B);
  static const secondary = Color(0xFF3DD6F5);
  static const success = Color(0xFF3DDC97);
  static const warning = Color(0xFFF5B942);
  static const danger = Color(0xFFFF5C5C);
  static const textPrimary = Color(0xFFF4F6F8);
  static const textSecondary = Color(0xFF9AA3AD);
  static const border = Color(0xFF2A313A);

  static const lightBackground = Color(0xFFF3F5F7);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceElevated = Color(0xFFF7F8FA);
  static const lightTextPrimary = Color(0xFF12161C);
  static const lightTextSecondary = Color(0xFF5B6570);
  static const lightBorder = Color(0xFFE2E6EA);
  static const lightPrimary = Color(0xFF5A8F00);
  static const lightSecondary = Color(0xFF087E99);
}

abstract final class GpRadii {
  static const sm = 8.0;
  static const md = 14.0;
  static const lg = 20.0;
}

abstract final class GpSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

ThemeData buildMrGymDarkTheme() {
  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
  );
  return base.copyWith(
    scaffoldBackgroundColor: GpColors.background,
    colorScheme: const ColorScheme.dark(
      surface: GpColors.surface,
      primary: GpColors.primary,
      secondary: GpColors.secondary,
      error: GpColors.danger,
      onPrimary: Color(0xFF101410),
      onSecondary: Color(0xFF041018),
      onSurface: GpColors.textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: GpColors.background,
      foregroundColor: GpColors.textPrimary,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: GpColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(GpRadii.md),
        side: const BorderSide(color: GpColors.border),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: GpColors.surfaceElevated,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(GpRadii.sm),
        borderSide: const BorderSide(color: GpColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(GpRadii.sm),
        borderSide: const BorderSide(color: GpColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(GpRadii.sm),
        borderSide: const BorderSide(color: GpColors.primary, width: 1.5),
      ),
      labelStyle: const TextStyle(color: GpColors.textSecondary),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: GpColors.surface,
      selectedItemColor: GpColors.primary,
      unselectedItemColor: GpColors.textSecondary,
      type: BottomNavigationBarType.fixed,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: GpColors.surfaceElevated,
      contentTextStyle: const TextStyle(color: GpColors.textPrimary),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(GpRadii.sm),
      ),
    ),
    dividerColor: GpColors.border,
    textTheme: base.textTheme.apply(
      bodyColor: GpColors.textPrimary,
      displayColor: GpColors.textPrimary,
    ),
  );
}

ThemeData buildMrGymLightTheme() {
  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Roboto',
  );
  return base.copyWith(
    scaffoldBackgroundColor: GpColors.lightBackground,
    colorScheme: const ColorScheme.light(
      surface: GpColors.lightSurface,
      primary: GpColors.lightPrimary,
      secondary: GpColors.lightSecondary,
      error: GpColors.danger,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: GpColors.lightTextPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: GpColors.lightBackground,
      foregroundColor: GpColors.lightTextPrimary,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: GpColors.lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(GpRadii.md),
        side: const BorderSide(color: GpColors.lightBorder),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: GpColors.lightSurfaceElevated,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(GpRadii.sm),
        borderSide: const BorderSide(color: GpColors.lightBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(GpRadii.sm),
        borderSide: const BorderSide(color: GpColors.lightBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(GpRadii.sm),
        borderSide: const BorderSide(color: GpColors.lightPrimary, width: 1.5),
      ),
      labelStyle: const TextStyle(color: GpColors.lightTextSecondary),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: GpColors.lightSurface,
      selectedItemColor: GpColors.lightPrimary,
      unselectedItemColor: GpColors.lightTextSecondary,
      type: BottomNavigationBarType.fixed,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF1F252D),
      contentTextStyle: const TextStyle(color: GpColors.textPrimary),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(GpRadii.sm),
      ),
    ),
    dividerColor: GpColors.lightBorder,
    textTheme: base.textTheme.apply(
      bodyColor: GpColors.lightTextPrimary,
      displayColor: GpColors.lightTextPrimary,
    ),
  );
}
