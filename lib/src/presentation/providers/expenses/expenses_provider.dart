import 'package:money_scope/src/core/services/notification_services.dart';
import 'package:money_scope/src/domain/repositories/expenses_repository.dart';
import 'package:money_scope/src/domain/entities/expense_entity.dart';
import 'package:money_scope/src/domain/entities/expense_with_category.dart';
import 'package:money_scope/src/domain/entities/notification_entity.dart';
import 'package:money_scope/src/data/repositories/expenses_repository_impl.dart';
import 'package:money_scope/src/presentation/providers/analytics/analytics_provider.dart';
import 'package:money_scope/src/presentation/providers/category_provider/category_provider.dart';
import 'package:money_scope/src/presentation/providers/database/database_provider.dart';
import 'package:money_scope/src/presentation/providers/home/home_provider.dart';
import 'package:money_scope/src/presentation/providers/notification/notification_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

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
    ref.invalidate(analyticsRangeSelectorProvider);
    ref.invalidate(homeProvider);

    final category = ref
        .read(categoryProvider)
        .value
        ?.where((category) => expense.categoryId == category.id)
        .first;

    if (category == null) return;

    final notification = NotificationEntity(
      id: Uuid().v4(),
      type: "expense_added",
      title: expense.name,
      message: "Expense Successfully Added",
      icon: category.icon,
      color: category.color,
      isRead: false,
      date: DateTime.now(),
      metaData: MetaData(
        categoryId: category.id,
        expenseId: expense.id,
        amount: expense.amount,
      ),
    );

    ref.read(notificationProvider.notifier).add(notification);

    NotificationServices.instance.showNotification(
      id: 101,
      title: expense.name,
      body: "You expense is successfully added",
    );
  }
}
