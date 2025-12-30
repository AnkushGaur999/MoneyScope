import 'package:drift/drift.dart';
import 'package:money_scope/src/core/storage/database/app_database.dart';
import 'package:money_scope/src/core/storage/database/dao/expenses_dao.dart';
import 'package:money_scope/src/domain/entities/category_entity.dart';
import 'package:money_scope/src/domain/entities/expense_entity.dart';
import 'package:money_scope/src/domain/entities/expense_with_category.dart';
import 'package:money_scope/src/domain/repositories/expenses_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpensesDao dao;

  ExpenseRepositoryImpl(this.dao);

  @override
  Future<void> addExpense(ExpenseEntity expense) async {
    return dao.insertExpense(
      ExpensesTableCompanion.insert(
        id: expense.id,
        name: expense.name,
        amount: expense.amount,
        categoryId: expense.categoryId,
        note: Value(expense.note),
        date: expense.date,
        isRecurring: Value(expense.isRecurring),
      ),
    );
  }

  @override
  Stream<List<ExpenseEntity>> watchAllExpenses() {
    return dao.watchAllExpenses().map(
      (rows) => rows.map((e) => e.toDomain()).toList(),
    );
  }

  @override
  Stream<List<ExpenseWithCategory>> watchAllExpensesWithCategory() {
    return dao.watchAllExpensesWithCategory().map(
      (rows) => rows
          .map(
            (e) => ExpenseWithCategory(
              expense: e.expense.toDomain(),
              category: e.category.toDomain(),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<void> deleteExpense(String id) async {
    dao.deleteExpense(id);
  }

  @override
  Future<List<ExpensesTableData>> getExpensesByMonth({
    required DateTime start,
    required DateTime end,
    int? limit,
  }) {
    return dao.getExpensesByMonth(start, end, limit: limit);
  }

  @override
  Future<List<ExpenseWithCategory>> getExpensesWithCategoryByMonth({
    required DateTime start,
    required DateTime end,
    int? limit,
  }) async {
    final rows = await dao.getExpensesWithCategoryByMonth(
      start: start,
      end: end,
      limit: limit,
    );

    return rows
        .map(
          (e) => ExpenseWithCategory(
            expense: e.expense.toDomain(),
            category: e.category.toDomain(),
          ),
        )
        .toList();
  }
}
