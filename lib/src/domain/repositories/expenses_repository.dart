import 'package:money_scope/src/core/storage/database/app_database.dart';
import 'package:money_scope/src/domain/entities/expense_entity.dart';
import 'package:money_scope/src/domain/entities/expense_with_category.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(ExpenseEntity expense);

  Future<void> deleteExpense(String id);

  Stream<List<ExpenseEntity>> watchAllExpenses();

  Stream<List<ExpenseWithCategory>> watchAllExpensesWithCategory();

  Future<List<ExpensesTableData>> getExpensesByMonth({
    required DateTime start,
    required DateTime end,
    int? limit,
  });

  Future<List<ExpenseWithCategory>> getExpensesWithCategoryByMonth({
    required DateTime start,
    required DateTime end,
    int? limit,
  });
}
