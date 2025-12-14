import 'package:money_scope/src/domain/entities/category_entity.dart';
import 'package:money_scope/src/domain/entities/expense_entity.dart';

class ExpenseWithCategory {
  final ExpenseEntity expense;
  final CategoryEntity category;

  const ExpenseWithCategory({
    required this.expense,
    required this.category,
  });
}
