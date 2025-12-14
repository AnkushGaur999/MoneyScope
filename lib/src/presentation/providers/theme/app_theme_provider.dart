import 'package:money_scope/src/presentation/providers/theme/theme_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_provider.g.dart';

@riverpod
class AppTheme extends _$AppTheme {
  @override
  ThemeState build() {
    return LightTheme();
  }

  Future<void> toggleTheme() async {
    state = state is LightTheme ? DarkTheme() : LightTheme();
  }
}
