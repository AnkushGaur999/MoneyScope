import 'package:drift/drift.dart';
import 'package:money_scope/src/core/storage/database/app_database.dart';
import 'package:money_scope/src/core/storage/database/tables/categories_table.dart';
import 'package:money_scope/src/core/storage/database/tables/expenses_table.dart';
import 'package:money_scope/src/domain/entities/category_spent_entity.dart';

part 'expenses_dao.g.dart';

class ExpenseWithCategoryData {
  final ExpensesTableData expense;
  final CategoriesTableData category;

  ExpenseWithCategoryData({required this.expense, required this.category});
}

@DriftAccessor(tables: [ExpensesTable, CategoriesTable])
class ExpensesDao extends DatabaseAccessor<AppDatabase>
    with _$ExpensesDaoMixin {
  ExpensesDao(super.db);

  // Insert
  Future<void> insertExpense(ExpensesTableCompanion expense) =>
      into(expensesTable).insert(expense);

  // Delete
  Future<void> deleteExpense(String id) =>
      (delete(expensesTable)..where((tbl) => tbl.id.equals(id))).go();

  // Watch all expenses
  Stream<List<ExpensesTableData>> watchAllExpenses() =>
      select(expensesTable).watch();

  Stream<List<ExpenseWithCategoryData>> watchAllExpensesWithCategory() {
    final query = select(expensesTable).join([
      innerJoin(
        categoriesTable,
        categoriesTable.id.equalsExp(expensesTable.categoryId),
      ),
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

  Future<List<CategorySpentEntity>> topSpending(
    DateTime start,
    DateTime end,
    int limit,
  ) async {
    final rows = await customSelect(
      '''
      SELECT 
        c.id        AS categoryId,
        c.name      AS name,
        c.icon      AS icon,
        c.color     AS color,
        SUM(e.amount) AS total
      FROM expenses_table e
      JOIN categories_table c ON c.id = e.category_id
      WHERE e.date BETWEEN ? AND ?
      GROUP BY c.id
      ORDER BY total DESC
      LIMIT ?
      ''',
      variables: [
        Variable.withDateTime(start),
        Variable.withDateTime(end),
        Variable.withInt(limit),
      ],
    ).get();

    return rows.map((r) {
      return CategorySpentEntity(
        categoryId: r.data['categoryId'] as String,
        name: r.data['name'] as String,
        icon: r.data['icon'] as String,
        color: r.data['color'] as int,
        total: (r.data['total'] as num).toDouble(),
      );
    }).toList();
  }

  Future<double> totalSpend(DateTime start, DateTime end) async {
    final result = await customSelect(
      '''
      SELECT SUM(amount) AS total
      FROM expenses_table
      WHERE date BETWEEN ? AND ?
      ''',
      variables: [Variable.withDateTime(start), Variable.withDateTime(end)],
    ).getSingle();

    return (result.data['total'] as num?)?.toDouble() ?? 0;
  }

  Future<List<ExpenseWithCategoryData>> getExpensesWithCategoryByMonth({
    required DateTime start,
    required DateTime end,
    int? limit,
  }) async {
    final query =
        select(expensesTable).join([
            innerJoin(
              categoriesTable,
              categoriesTable.id.equalsExp(expensesTable.categoryId),
            ),
          ])
          ..where(expensesTable.date.isBetweenValues(start, end))
          ..orderBy([
            OrderingTerm(
              expression: expensesTable.date,
              mode: OrderingMode.desc,
            ),
          ]);

    if (limit != null) {
      query.limit(limit);
    }

    final rows = await query.get();

    return rows
        .map(
          (row) => ExpenseWithCategoryData(
            expense: row.readTable(expensesTable),
            category: row.readTable(categoriesTable),
          ),
        )
        .toList();
  }

  // Monthly expenses
  Future<List<ExpensesTableData>> getExpensesByMonth(
    DateTime start,
    DateTime end, {
    int? limit,
  }) {
    final query = (select(expensesTable)
      ..where((tbl) => tbl.date.isBetweenValues(start, end)));

    if (limit != null) {
      query.limit(limit);
    }

    return query.get();
  }
}
