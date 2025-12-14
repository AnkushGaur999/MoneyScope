import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:money_scope/src/presentation/providers/theme/app_theme_provider.dart';
import 'package:money_scope/src/presentation/providers/theme/theme_state.dart';
import 'package:money_scope/src/presentation/views/dashboard/home/widgets/insights_card.dart';
import 'package:money_scope/src/presentation/views/dashboard/home/widgets/recent_expenses.dart';
import 'package:money_scope/src/presentation/views/dashboard/home/widgets/spending_breakdown.dart';
import 'package:money_scope/src/presentation/views/dashboard/home/widgets/month_selector.dart';
import 'package:money_scope/src/presentation/views/dashboard/home/widgets/total_spent_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("MoneyScope"),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final isLight = ref.watch(appThemeProvider) is LightTheme;
              return IconButton(
                onPressed: () =>
                    ref.read(appThemeProvider.notifier).toggleTheme(),
                icon: isLight ? Icon(Icons.dark_mode) : Icon(Icons.light_mode),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MonthSelector(),

            const TotalSpentCard(),

            const InsightsCard(),

            const SpendingBreakdown(),

            const RecentExpenses(),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
