import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors/money_scope_colors_light.dart';

abstract class AppLightThemeData {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: MoneyScopeColorsLight.primary,
      onPrimary: MoneyScopeColorsLight.onPrimary,
      secondary: MoneyScopeColorsLight.secondary,
      onSecondary: MoneyScopeColorsLight.onSecondary,
      tertiary: MoneyScopeColorsLight.tertiary,
      onTertiary: MoneyScopeColorsLight.onTertiary,
      error: MoneyScopeColorsLight.error,
      onError: MoneyScopeColorsLight.onError,
      surface: MoneyScopeColorsLight.surface,
      onSurface: MoneyScopeColorsLight.onSurface,
      surfaceContainerHighest: MoneyScopeColorsLight.surfaceVariant,
      onSurfaceVariant: MoneyScopeColorsLight.onSurfaceVariant,
      outline: MoneyScopeColorsLight.outline,
    ),

    scaffoldBackgroundColor: MoneyScopeColorsLight.background,

    appBarTheme: AppBarTheme(
      backgroundColor: MoneyScopeColorsLight.surface,
      foregroundColor: MoneyScopeColorsLight.onSurface,
      titleTextStyle: GoogleFonts.notoSans(
        color: MoneyScopeColorsLight.primary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      elevation: 2,
    ),

    cardTheme: CardThemeData(
      color: MoneyScopeColorsLight.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    textTheme: GoogleFonts.notoSansTextTheme(
      ThemeData.light().textTheme,
    ),

    dividerTheme: const DividerThemeData(color: MoneyScopeColorsLight.divider),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: MoneyScopeColorsLight.primary,
      foregroundColor: MoneyScopeColorsLight.onPrimary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MoneyScopeColorsLight.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: MoneyScopeColorsLight.outline),
      ),
    ),
  );
}
