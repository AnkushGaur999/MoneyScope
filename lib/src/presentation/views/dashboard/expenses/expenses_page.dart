import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:money_scope/src/core/config/helper/time_formater.dart';
import 'package:money_scope/src/core/constants/app_routes.dart';
import 'package:money_scope/src/core/storage/database/mapper/category_icon_mapper.dart';
import 'package:money_scope/src/presentation/providers/expenses_provider/expenses_provider.dart';
import 'package:money_scope/src/presentation/views/dashboard/expenses/widgets/no_expenses_view.dart';
import 'package:money_scope/src/presentation/views/dashboard/home/widgets/month_selector.dart';



class ExpensesPage extends ConsumerStatefulWidget {
  const ExpensesPage({super.key});

  @override
  ConsumerState<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends ConsumerState<ExpensesPage> {
  final _months = getPreviousMonths();

  void _changeMonth(int delta) {
    final currentMonth = ref.read(expenseSelectedMonthProvider);
    final index = _months.indexOf(currentMonth);
    final nextIndex = index + delta;

    if (nextIndex < 0 || nextIndex >= _months.length) return;

    ref.read(expenseSelectedMonthProvider.notifier).update(_months[nextIndex]);
  }

  @override
  Widget build(BuildContext context) {
    final selectedMonth = ref.watch(expenseSelectedMonthProvider);
    final expenseAsyncNotifier = ref.watch(expenseProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Expenses",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        spacing: 8,
        children: [
          MonthSelector(
            selectedMonth: DateFormat("MMMM yyyy").format(selectedMonth),
            onPrevious: () => _changeMonth(1),
            onNext: () => _changeMonth(-1),
          ),

          Expanded(
            child: expenseAsyncNotifier.when(
              data: (data) {
                if (data.isEmpty) {
                  return const NoExpensesView();
                }

                return ListView.separated(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final expense = data[index].expense;
                    final category = data[index].category;
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(category.color),
                        child: Icon(CategoryIconMapper.get(category.icon)),
                      ),
                      title: Text(
                        category.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(getDayLabel(expense.date)),
                      trailing: Text(
                        '₹${expense.amount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                );
              },
              error: (error, stacktrace) =>
                  Center(child: Text(error.toString())),
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () => context.pushNamed(AppRoutes.addExpense),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
