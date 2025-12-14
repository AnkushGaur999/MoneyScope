import 'package:drift/drift.dart';
import 'package:money_scope/src/core/storage/database/app_database.dart';
import 'package:money_scope/src/core/storage/database/tables/categories_table.dart';
import 'package:money_scope/src/core/storage/database/tables/expenses_table.dart';

part 'expenses_dao.g.dart';

class ExpenseWithCategoryData {
  final ExpensesTableData expense;
  final CategoriesTableData category;

  ExpenseWithCategoryData({required this.expense, required this.category});
}

@DriftAccessor(tables: [ExpensesTable, CategoriesTable])
class ExpensesDao extends DatabaseAccessor<AppDatabase> with _$ExpensesDaoMixin {
  ExpensesDao(super.db);

  // Insert
  Future<void> insertExpense(ExpensesTableCompanion expense) =>
      into(expensesTable).insert(expense);

  // Delete
  Future<void> deleteExpense(String id) =>
      (delete(expensesTable)..where((tbl) => tbl.id.equals(id))).go();

  // Watch all expenses
  Stream<List<ExpensesTableData>> watchAllExpenses() => select(expensesTable).watch();

  Stream<List<ExpenseWithCategoryData>> watchAllExpensesWithCategory() {
    final query = select(expensesTable).join([
      innerJoin(
        categoriesTable,
        categoriesTable.id.equalsExp(expensesTable.categoryId),
      )
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return ExpenseWithCategoryData(
          expense: row.readTable(expensesTable),
          category: row.readTable(categoriesTable),
        );
      }).toList();
    });
  }

  // Monthly expenses
  Future<List<ExpensesTableData>> getExpensesByMonth(
    DateTime start,
    DateTime end,
  ) {
    return (select(
      expensesTable,
    )..where((tbl) => tbl.date.isBetweenValues(start, end)))
        .get();
  }
}
