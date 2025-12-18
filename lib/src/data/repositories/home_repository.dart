import 'package:money_scope/src/domain/entities/category_spent_entity.dart';
import 'package:money_scope/src/domain/entities/expense_with_category.dart';

abstract class HomeRepository {
  Future<double> totalSpend(DateTime start, DateTime end);

  Future<List<CategorySpentEntity>> topSpending(
    DateTime start,
    DateTime end,
    int limit,
  );


  Future<List<ExpenseWithCategory>> getRecentExpense({
    required DateTime start,
    required DateTime end,
    int? limit,
  });
}
