import 'package:money_scope/src/data/repositories/expenses_repository.dart';
import 'package:money_scope/src/domain/entities/expense_entity.dart';
import 'package:money_scope/src/domain/entities/expense_with_category.dart';
import 'package:money_scope/src/domain/repositories/expenses_repository_impl.dart';
import 'package:money_scope/src/presentation/providers/analytics_provider/analytics_provider.dart';
import 'package:money_scope/src/presentation/providers/database_provider/database_provider.dart';
import 'package:money_scope/src/presentation/providers/home_provider/home_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expenses_provider.g.dart';

@riverpod
ExpenseRepository expenseRepository(Ref ref) {
  final db = ref.watch(databaseProvider);

  return ExpenseRepositoryImpl(db.expensesDao);
}

@riverpod
class ExpenseSelectedMonth extends _$ExpenseSelectedMonth {
  @override
  DateTime build() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  void update(DateTime date) {
    state = date;
  }
}

@riverpod
class Expense extends _$Expense {
  @override
  FutureOr<List<ExpenseWithCategory>> build() {
    final selectedMonth = ref.watch(expenseSelectedMonthProvider);

    final start = DateTime(selectedMonth.year, selectedMonth.month, 1);
    final end = DateTime(
      selectedMonth.year,
      selectedMonth.month + 1,
      1,
    ).subtract(const Duration(seconds: 1));

    return ref
        .read(expenseRepositoryProvider)
        .getExpensesWithCategoryByMonth(start: start, end: end);
  }


  Future<void> addExpense(ExpenseEntity expense) async {
    await ref.read(expenseRepositoryProvider).addExpense(expense);
    ref.read(analyticsProvider.notifier).getMonthData();
    ref.invalidate(homeProvider);

  }

  // Future<void> _getUpdateMonthExpenses() async {
  //   final selectedMonth = ref.read(expenseSelectedMonthProvider);
  //
  //   final start = DateTime(selectedMonth.year, selectedMonth.month, 1);
  //   final end = DateTime(
  //     selectedMonth.year,
  //     selectedMonth.month + 1,
  //     1,
  //   ).subtract(const Duration(seconds: 1));
  //   final result = await ref
  //       .read(expenseRepositoryProvider)
  //       .getExpensesWithCategoryByMonth(start: start, end: end);
  //
  //   state = AsyncData(result);
  // }
}
