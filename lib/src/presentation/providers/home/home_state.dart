import 'package:money_scope/src/domain/entities/category_spent_entity.dart';
import 'package:money_scope/src/domain/entities/expense_with_category.dart';

class HomeState {
  final double lastMonthTotalSpent;
  final double currentMonthTotalSpent;

  final double totalAmount;
  final List<CategorySpentEntity> expenseList;
  final List<ExpenseWithCategory> recentExpense;

  const HomeState({
    required this.lastMonthTotalSpent,
    required this.currentMonthTotalSpent,
    required this.totalAmount,
    required this.expenseList,
    required this.recentExpense,
  });
}
