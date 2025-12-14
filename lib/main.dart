import 'package:money_scope/src/core/config/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_scope/src/presentation/providers/theme/app_theme_provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(appThemeProvider);
    return MaterialApp.router(
      title: 'MoneyScope',
      theme: themeProvider.theme,
      routerConfig: AppRoute.router,
    );
  }
}
