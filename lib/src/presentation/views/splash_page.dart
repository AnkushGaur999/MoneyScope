import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:money_scope/src/core/config/generated/assets.gen.dart';
import 'package:money_scope/src/core/constants/app_routes.dart';
import 'package:money_scope/src/presentation/providers/user/user_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _userRegistered();
  }

  Future<void> _userRegistered() async {
    final user = await ref.read(userProvider.future);

    if (mounted) {
      if (user != null) {
        context.goNamed(AppRoutes.home);
      } else {
        context.goNamed(AppRoutes.userRegistration);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Assets.images.moneyScope.image(
            width: 180,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
