import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors/money_scope_colors_dart.dart';

class AppDarkThemeData {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: MoneyScopeColorsDark.primary,
      onPrimary: MoneyScopeColorsDark.onPrimary,
      secondary: MoneyScopeColorsDark.secondary,
      onSecondary: MoneyScopeColorsDark.onSecondary,
      tertiary: MoneyScopeColorsDark.tertiary,
      onTertiary: MoneyScopeColorsDark.onTertiary,
      error: MoneyScopeColorsDark.error,
      onError: MoneyScopeColorsDark.onError,
      surface: MoneyScopeColorsDark.surface,
      onSurface: MoneyScopeColorsDark.onSurface,
      surfaceContainerHighest: MoneyScopeColorsDark.surfaceVariant,
      onSurfaceVariant: MoneyScopeColorsDark.onSurfaceVariant,
      outline: MoneyScopeColorsDark.outline,
    ),

    scaffoldBackgroundColor: MoneyScopeColorsDark.background,

    appBarTheme: AppBarTheme(
      backgroundColor: MoneyScopeColorsDark.surface,
      foregroundColor: MoneyScopeColorsDark.onSurface,
      titleTextStyle: GoogleFonts.notoSans(
        color: MoneyScopeColorsDark.primary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      elevation: 2,
    ),

    textTheme: GoogleFonts.notoSansTextTheme(
      ThemeData.dark().textTheme,
    ),

    cardTheme: CardThemeData(
      color: MoneyScopeColorsDark.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    dividerTheme: const DividerThemeData(color: MoneyScopeColorsDark.divider),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: MoneyScopeColorsDark.primary,
      foregroundColor: MoneyScopeColorsDark.onPrimary,
    ),

  );
}
