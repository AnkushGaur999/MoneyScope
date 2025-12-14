import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_scope/src/core/config/generated/assets.gen.dart';
import 'package:money_scope/src/core/constants/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1)).then((value) {
      if (mounted) context.goNamed(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Assets.images.moneyScope.image(width: 180, height: 180),
      ),
    );
  }
}
