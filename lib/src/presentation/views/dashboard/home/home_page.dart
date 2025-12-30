import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_scope/src/core/config/generated/assets.gen.dart';
import 'package:money_scope/src/core/constants/app_routes.dart';
import 'package:money_scope/src/domain/entities/expense_with_category.dart';
import 'package:money_scope/src/presentation/providers/home/home_provider.dart';
import 'package:money_scope/src/presentation/views/dashboard/home/widgets/insights_card.dart';
import 'package:money_scope/src/presentation/views/dashboard/home/widgets/recent_expenses.dart';
import 'package:money_scope/src/presentation/views/dashboard/home/widgets/top_spending_breakdown.dart';
import 'package:money_scope/src/presentation/views/dashboard/home/widgets/total_spent_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: CircleBorder(),
          child: GestureDetector(
             onTap: () => context.pushNamed(AppRoutes.profile),
            child: Assets.images.moneyScope.image(width: 24, height: 24),
          ),
        ),
        title: const Text("MoneyScope"),
        centerTitle: true,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: ()=> context.pushNamed(AppRoutes.notification),
                icon: const Icon(Icons.notifications_active_rounded),
              );
            },
          ),
        ],
      ),

      body: ref
          .watch(homeProvider)
          .when(
            data: (data) {
              final currentMonthTotalAmount = data.currentMonthTotalSpent;

              final List<ExpenseWithCategory> recentExpenseList =
                  data.recentExpense;

              final topExpense = data.topExpenseList.firstOrNull;

              final totalMonthlyBudget = data.monthlyBudget;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TotalSpentCard(
                      spentAmount: data.currentMonthTotalSpent,
                      totalMonthlyBudget: totalMonthlyBudget,
                    ),

                    InsightsCard(
                      topExpense: topExpense,
                      totalSpent: data.currentMonthTotalSpent,
                    ),

                    TopSpendingBreakdown(
                      totalAmount: currentMonthTotalAmount,
                      expenseList: data.topExpenseList,
                    ),

                    RecentExpenses(recentExpenseList: recentExpenseList),

                    const SizedBox(height: 60),
                  ],
                ),
              );
            },
            error: (error, stack) {
              return const Center(child: Text("Something went wrong"));
            },
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
