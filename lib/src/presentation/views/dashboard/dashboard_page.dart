import 'package:money_scope/src/presentation/views/dashboard/widegts/bottom_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardPage({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final index = navigationShell.currentIndex;

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: navigationShell),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              child: Container(
                height: 76,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    BottomNavItem(
                      icon: Icons.dashboard_outlined,
                      label: "Dashboard",
                      isSelected: index == 0,
                      onTap: () => _onTap(0),
                    ),
                    BottomNavItem(
                      icon: Icons.receipt_long_outlined,
                      label: "Expenses",
                      isSelected: index == 1,
                      onTap: () => _onTap(1),
                    ),
                    BottomNavItem(
                      icon: Icons.insights_outlined,
                      label: "Analytics",
                      isSelected: index == 2,
                      onTap: () => _onTap(2),
                    ),
                    BottomNavItem(
                      icon: Icons.settings_outlined,
                      label: "Settings",
                      isSelected: index == 3,
                      onTap: () => _onTap(3),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
