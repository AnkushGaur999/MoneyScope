import 'package:money_scope/src/presentation/providers/theme/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _preferences;

  AppPreferences._private(this._preferences);

  static AppPreferences? _instance;

  static const String _theme = "theme";

  factory AppPreferences({required SharedPreferences pref}) {
    _instance ??= AppPreferences._private(pref);

    return _instance!;
  }

  ThemeState getTheme() {
    final type = _preferences.getString(_theme) ?? "light";

    return type == "light" ? LightTheme() : DarkTheme();
  }

  Future<void> updateTheme(ThemeState theme) async {
    final type = theme is LightTheme ? "light" : "dark";
    await _preferences.setString(_theme, type);
  }
}
