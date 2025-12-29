import 'package:money_scope/src/core/storage/database/dao/expenses_dao.dart';
import 'package:money_scope/src/domain/repositories/home_repository.dart';
import 'package:money_scope/src/domain/entities/category_entity.dart';
import 'package:money_scope/src/domain/entities/category_spent_entity.dart';
import 'package:money_scope/src/domain/entities/expense_entity.dart';
import 'package:money_scope/src/domain/entities/expense_with_category.dart';

class HomeRepositoryImpl extends HomeRepository {
  final ExpensesDao expensesDao;

  HomeRepositoryImpl({required this.expensesDao});

  /// Get Top 3 Expenses by Category in a particular time period
  @override
  Future<List<CategorySpentEntity>> topSpending(
    DateTime start,
    DateTime end,
    int limit,
  ) async {
    return await expensesDao.topSpending(start, end, limit);
  }

  /// Get total spent in a particular time period
  @override
  Future<double> totalSpend(DateTime start, DateTime end) async {
    return await expensesDao.totalSpend(start, end);
  }

  /// Get Recent Top Expenses in a particular time period
  @override
  Future<List<ExpenseWithCategory>> getRecentExpense({
    required DateTime start,
    required DateTime end,
    int? limit,
  }) async {
    final rows = await expensesDao.getExpensesWithCategoryByMonth(
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
