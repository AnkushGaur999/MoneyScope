import 'package:money_scope/src/core/storage/local/app_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_preference_provider.g.dart';

@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

@riverpod
Future<AppPreferences> appPreferences(Ref ref) async {
  final sharePref = await ref.watch(sharedPreferencesProvider.future);
  return AppPreferences(pref: sharePref);
}
