import 'package:money_scope/src/core/constants/app_routes.dart';
import 'package:money_scope/src/presentation/views/dashboard/analytics/analytics_page.dart';
import 'package:money_scope/src/presentation/views/dashboard/dashboard_page.dart';
import 'package:money_scope/src/presentation/views/dashboard/expenses/add_expense_page.dart';
import 'package:money_scope/src/presentation/views/dashboard/expenses/expenses_page.dart';
import 'package:money_scope/src/presentation/views/dashboard/home/home_page.dart';
import 'package:money_scope/src/presentation/views/dashboard/profile/profile_page.dart';
import 'package:money_scope/src/presentation/views/dashboard/settings/settings_page.dart';
import 'package:money_scope/src/presentation/views/notification/notification_page.dart';
import 'package:money_scope/src/presentation/views/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static const String _splash = "/";
  static const String _home = "/${AppRoutes.home}";
  static const String _analytics = "/${AppRoutes.analytics}";
  static const String _expenses = "/${AppRoutes.expenses}";
  static const String _settings = "/${AppRoutes.settings}";
  static const String _profile = AppRoutes.profile;
  static const String _notification = AppRoutes.notification;
  static const String _addExpense = "/${AppRoutes.addExpense}";

  static final GoRouter router = GoRouter(
    initialLocation: _splash,

    routes: [
      GoRoute(
        name: AppRoutes.splash,
        path: _splash,
        pageBuilder: (context, state) =>
            const MaterialPage(child: SplashPage()),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            DashboardPage(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.home,
                path: _home,
                pageBuilder: (context, state) =>
                    fadeScalePage(state: state, child: const HomePage()),
                routes: [
                  GoRoute(
                    name: AppRoutes.notification,
                    path: _notification,
                    builder: (context, state) => const NotificationPage(),
                  ),
                ],
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.expenses,
                path: _expenses,
                pageBuilder: (context, state) =>
                    fadeScalePage(state: state, child: const ExpensesPage()),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.analytics,
                path: _analytics,
                pageBuilder: (context, state) =>
                    fadeScalePage(state: state, child: const AnalyticsPage()),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.settings,
                path: _settings,
                pageBuilder: (context, state) =>
                    fadeScalePage(state: state, child: const SettingsPage()),
                routes: [
                  GoRoute(
                    name: AppRoutes.profile,
                    path: _profile,
                    pageBuilder: (context, state) =>
                        fadeScalePage(state: state, child: const ProfilePage()),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        name: AppRoutes.addExpense,
        path: _addExpense,
        pageBuilder: (context, state) =>
            fadeScalePage(state: state, child: const AddExpensePage()),
      ),
    ],
    errorBuilder: (context, state) {
      return const Center(child: Text("No Page Found!"));
    },
  );
}

CustomTransitionPage<T> fadeScalePage<T>({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, _, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween(begin: 0.95, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: child,
        ),
      );
    },
  );
}
