import 'package:money_scope/src/core/storage/local/app_preferences.dart';
import 'package:money_scope/src/presentation/providers/app_preference_provider.dart';
import 'package:money_scope/src/presentation/providers/theme/theme_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_provider.g.dart';

@riverpod
class AppTheme extends _$AppTheme {
  late final AppPreferences _appPref;

  @override
  ThemeState build() {
    final sp = ref.watch(sharedPreferencesProvider).value;

    if (sp == null) return LightTheme();

    _appPref = AppPreferences(pref: sp);

    return _appPref.getTheme();
  }

  Future<void> toggleTheme() async {
    final updated = state is LightTheme ? DarkTheme() : LightTheme();
    state = updated;
    _appPref.updateTheme(updated);
  }
}
