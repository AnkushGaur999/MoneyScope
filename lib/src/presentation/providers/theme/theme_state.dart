import 'package:flutter/material.dart';
import 'package:money_scope/src/core/config/theme/app_dark_theme_data.dart';
import 'package:money_scope/src/core/config/theme/app_light_theme_data.dart';

sealed class ThemeState {
  final ThemeData theme;

  const ThemeState({required this.theme});
}

final class LightTheme extends ThemeState {
  LightTheme() : super(theme: AppLightThemeData.theme);
}

final class DarkTheme extends ThemeState {
  DarkTheme() : super(theme: AppDarkThemeData.theme);
}
