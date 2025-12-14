import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:money_scope/src/core/constants/app_routes.dart';
import 'package:money_scope/src/core/storage/database/mapper/category_icon_mapper.dart';
import 'package:money_scope/src/presentation/providers/expenses_provider/expenses_provider.dart';

class ExpensesPage extends ConsumerWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: expenseAsyncNotifier.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: ElevatedButton(onPressed: () {}, child: Text("Add")),
            );
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
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(expense.date.toString()),
                trailing: Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
          );
        },
        error: (error, stacktrace) => Center(child: Text(error.toString())),
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
      ),

      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () => context.pushNamed(AppRoutes.addExpense),
        child: Icon(Icons.add),
      ),
    );
  }
}
